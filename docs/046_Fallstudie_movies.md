



# Fallstudie 'movies' {#case-movies}


<img src="images/FOM.jpg" width="30%" style="display: block; margin: auto;" />

<img src="images/licence.png" width="10%" style="display: block; margin: auto;" />


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Lernziele:

- Grundlegende Funktionen von `dplyr` andwenden können.
- Das Konzept der Pfeife in einem echten Datensatz anwenden können.
- Auch mit relativ großen Daten sicher hantieren können.
</div>\EndKnitrBlock{rmdcaution}



Der Datensatz `movies` enthält Bewertungen von Filmen, zusammen mit einigen zusätzlichen Informationen wie Genre, Erscheinungsjahr und Budgethöhe. Wir nutzen diesen Datensatz um uns einige Übung mit Aufbereiten und Zusammenfassen von Daten zu verschaffen.


Für dieses Kapitel werden folgende Pakete benötigt:


```r
library(tidyverse)  # Datenjudo und Visualisierung
library(corrr)
```


Zunächst laden wir die Daten und werfen einen Blick in den Datensatz:


```r
movies <- read.csv("data/movies.csv")
glimpse(movies)
#> Observations: 58,788
#> Variables: 24
#> $ title       <fctr> $, $1000 a Touchdown, $21 a Day Once a Month, $40...
#> $ year        <int> 1971, 1939, 1941, 1996, 1975, 2000, 2002, 2002, 19...
#> $ length      <int> 121, 71, 7, 70, 71, 91, 93, 25, 97, 61, 99, 96, 10...
#> $ budget      <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
#> $ rating      <dbl> 6.4, 6.0, 8.2, 8.2, 3.4, 4.3, 5.3, 6.7, 6.6, 6.0, ...
#> $ votes       <int> 348, 20, 5, 6, 17, 45, 200, 24, 18, 51, 23, 53, 44...
#> $ r1          <dbl> 4.5, 0.0, 0.0, 14.5, 24.5, 4.5, 4.5, 4.5, 4.5, 4.5...
#> $ r2          <dbl> 4.5, 14.5, 0.0, 0.0, 4.5, 4.5, 0.0, 4.5, 4.5, 0.0,...
#> $ r3          <dbl> 4.5, 4.5, 0.0, 0.0, 0.0, 4.5, 4.5, 4.5, 4.5, 4.5, ...
#> $ r4          <dbl> 4.5, 24.5, 0.0, 0.0, 14.5, 14.5, 4.5, 4.5, 0.0, 4....
#> $ r5          <dbl> 14.5, 14.5, 0.0, 0.0, 14.5, 14.5, 24.5, 4.5, 0.0, ...
#> $ r6          <dbl> 24.5, 14.5, 24.5, 0.0, 4.5, 14.5, 24.5, 14.5, 0.0,...
#> $ r7          <dbl> 24.5, 14.5, 0.0, 0.0, 0.0, 4.5, 14.5, 14.5, 34.5, ...
#> $ r8          <dbl> 14.5, 4.5, 44.5, 0.0, 0.0, 4.5, 4.5, 14.5, 14.5, 4...
#> $ r9          <dbl> 4.5, 4.5, 24.5, 34.5, 0.0, 14.5, 4.5, 4.5, 4.5, 4....
#> $ r10         <dbl> 4.5, 14.5, 24.5, 45.5, 24.5, 14.5, 14.5, 14.5, 24....
#> $ mpaa        <fctr> , , , , , , R, , , , , , , , PG-13, PG-13, , , , ...
#> $ Action      <int> 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0,...
#> $ Animation   <int> 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
#> $ Comedy      <int> 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0,...
#> $ Drama       <int> 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1,...
#> $ Documentary <int> 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
#> $ Romance     <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
#> $ Short       <int> 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0,...
```

Hier findet man einige Erklärungen zu diesem Datensatz: <http://had.co.nz/data/movies/>.

## Wie viele Filme gibt es pro Genre?

Normalerweise würde man für diese Frage eine Spalte wie "Genre" nehmen und die verschiedenen Werte dieser Spalte auszählen. Das geht sehr bequem mit `dplyr::count`. Hier gibt es allerdings so eine Spalte nicht. Wir müssen uns anders behelfen.

```r
movies %>% 
  select(Action:Short) %>% 
  summarise_all(funs(sum))
#>   Action Animation Comedy Drama Documentary Romance Short
#> 1   4688      3690  17271 21811        3472    4744  9458
```

Auf Deutsch heißt diese Syntax



\BeginKnitrBlock{rmdpseudocode}<div class="rmdpseudocode">Nimm die Tabelle "movies" UND DANN  
nimm alle Spalten von "Action" bis "Short" UND DANN  
fasse alle Spalten (die wir genommen haben) zusammen und zwar...
mit der oder den Funktionen "Summe" (sum).  
</div>\EndKnitrBlock{rmdpseudocode}


Genau wie der Befehl `summarise` fasst auch `summarise_all` Spalten zu einer Zahl zusammen - nur eben nicht *eine*, sondern *alle* Spalten eines Dataframe. Die Funktion(en), die beim Zusammenfassen verwendet werden sollen, werden mit `funs()` definiert.

## Welches Genre ist am häufigsten?

Bzw. in welchem Genre wurden am meisten Filme gedreht (in unserem Datensatz)?


```r
movies %>% 
  select(Action:Short) %>% 
  summarise_all(funs(sum)) %>% 
  gather() %>% 
  arrange()
#>           key value
#> 1      Action  4688
#> 2   Animation  3690
#> 3      Comedy 17271
#> 4       Drama 21811
#> 5 Documentary  3472
#> 6     Romance  4744
#> 7       Short  9458
```

Der Befehl `gather` baut einen Dataframe von "breit" nach "lang" um (vgl. Kapitel \@ref(normalform)). Ah, ~~Schmunzetten~~ Dramen sind also am häufigsten (wie der Befehl `arrange` dann zeigt). Welcome to Hollywood. :tada:

## Zusammenhang zwischen Budget und Beurteilung

Werden teuerere Filme (also Filme mit mehr Budget) besser beurteilt im Schnitt? Das würde man erwarten, denn zum Spaß werden die Investoren wohl nicht ihr Geld raus. Schauen wir es uns an.


```r
movies %>% 
  select(budget, rating, votes) %>% 
  correlate 
#> # A tibble: 3 x 4
#>   rowname  budget  rating votes
#>     <chr>   <dbl>   <dbl> <dbl>
#> 1  budget      NA -0.0142 0.441
#> 2  rating -0.0142      NA 0.104
#> 3   votes  0.4413  0.1037    NA
```

Wir haben gerade die drei Spalten `budget`, `rating` und `votes` ausgewählt, dann in der nächsten Zeile die fehlenden Werte eliminiert und schließlich die Korrelation zwischen allen Paaren gebildet. Interessanterweise gibt es keine Korrelation zwischen dem Budget und dem Rating! Teuere Filme sind also mitnichten besser bewertet. Allerdings haben Filme mit mehr Budget eine größere Anzahl an Bewertungen, sind also offenbar bekannter. Vielleicht gehen dann auch entsprechend mehr Leute im Kino - auch wenn diese Filme nicht besser sind. Teuerere Filme sind also bekannter, wenn auch nicht besser (beurteilt); so könnte man die Daten lesen.

## Wurden die Filme im Lauf der Jahre teurer und/oder "besser"?


```r
movies %>% 
  select(year, rating, budget) %>% 
  correlate
#> # A tibble: 3 x 4
#>   rowname    year  rating  budget
#>     <chr>   <dbl>   <dbl>   <dbl>
#> 1    year      NA -0.0699  0.2907
#> 2  rating -0.0699      NA -0.0142
#> 3  budget  0.2907 -0.0142      NA
```

Offenbar wurden die Filme im Lauf der Zeit nicht besser beurteilt: Die Korrelation von `year` und `rating` ist praktisch Null. Wohl wurden sie aber teurer: Die Korrelation von `year` und `budget` ist substanziell.
