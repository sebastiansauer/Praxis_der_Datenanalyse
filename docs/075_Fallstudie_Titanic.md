

# Fallstudien

## Überleben auf der Titanic
In dieser YACSDA (Yet-another-case-study-on-data-analysis) geht es um die beispielhafte Analyse nominaler Daten anhand des "klassischen" Falls zum Untergang der Titanic. Eine Frage, die sich hier aufdrängt, lautet: Kann (konnte) man sich vom Tod freikaufen, etwas polemisch formuliert. Oder neutraler: Hängt die Überlebensquote von der Klasse, in der derPassagiers reist, ab?



### Daten und Pakete laden



```r
library("titanic")
data(titanic_train)
```

Man beachte, dass ein Paket nur *einmalig* zu installieren ist (wie jede Software). Dann aber muss das Paket bei jedem Starten von R wieder von neuem gestartet werden. Außerdem ist es wichtig zu wissen, dass das Laden eines Pakets nicht automatisch die Datensätze aus dem Paket lädt. Man muss das oder die gewünschten Pakete selber (mit `data(...)`) laden. Und: Der Name eines Pakets (z.B. `titanic`) muss nicht identisch sein mit dem oder den Datensätzen des Pakets (z.B. `titanic_train`).


```r
library(tidyverse)
```


### Erster Blick
Werfen wir einen ersten Blick in die Daten:
  

```r
# install.packages("dplyr", dependencies = TRUE) # ggf. vorher installieren
glimpse(titanic_train)
#> Observations: 891
#> Variables: 12
#> $ PassengerId <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,...
#> $ Survived    <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0,...
#> $ Pclass      <int> 3, 1, 3, 1, 3, 3, 1, 3, 3, 2, 3, 1, 3, 3, 3, 2, 3,...
#> $ Name        <chr> "Braund, Mr. Owen Harris", "Cumings, Mrs. John Bra...
#> $ Sex         <chr> "male", "female", "female", "female", "male", "mal...
#> $ Age         <dbl> 22, 38, 26, 35, 35, NA, 54, 2, 27, 14, 4, 58, 20, ...
#> $ SibSp       <int> 1, 1, 0, 1, 0, 0, 0, 3, 0, 1, 1, 0, 0, 1, 0, 0, 4,...
#> $ Parch       <int> 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 5, 0, 0, 1,...
#> $ Ticket      <chr> "A/5 21171", "PC 17599", "STON/O2. 3101282", "1138...
#> $ Fare        <dbl> 7.25, 71.28, 7.92, 53.10, 8.05, 8.46, 51.86, 21.07...
#> $ Cabin       <chr> "", "C85", "", "C123", "", "", "E46", "", "", "", ...
#> $ Embarked    <chr> "S", "C", "S", "S", "S", "Q", "S", "S", "S", "C", ...
```

### Welche Variablen sind interessant?
Von 12 Variablen des Datensatzes interessieren uns offenbar `Pclass` und `Survived`; Hilfe zum Datensatz kann man übrigens mit `help(titanic_train)` bekommen. Diese beiden Variablen sind kategorial (nicht-metrisch), wobei sie in der Tabelle mit Zahlen kodiert sind. Natürlich ändert die Art der Codierung (hier als Zahl) nichts am eigentlichen Skalenniveau. Genauso könnte man "Mann" mit `1` und "Frau" mit `2` kodieren; ein Mittelwert bliebe genauso (wenig) aussagekräftig. Zu beachten ist hier nur, dass sich manche R-Befehle verunsichern lassen, wenn nominale Variablen mit Zahlen kodiert sind. Daher ist es oft besser, nominale Variablen mit Text-Werten zu benennen (wie "survived" vs. "drowned" etc.). Wir kommen später auf diesen Punkt zurück.

### Univariate Häufigkeiten
Bevor wir uns in kompliziertere Fragestellungen stürzen, halten wir fest: Wir untersuchen zwei nominale Variablen. Sprich: wir werden Häufigkeiten auszählen. Häufigkeiten (und relative Häufigkeiten, also Anteile oder Quoten) sind das, was uns hier beschäftigt.

Zählen wir zuerst die univariaten Häufigkeiten aus: Wie viele Passagiere gab es pro Klasse? Wie viele Passagiere gab es pro Wert von `Survived` (also die überlebten bzw. nicht überlebten)?


```r
c1 <- dplyr::count(titanic_train, Pclass)
c1
#> # A tibble: 3 × 2
#>   Pclass     n
#>    <int> <int>
#> 1      1   216
#> 2      2   184
#> 3      3   491
```


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Achtung - Namenskollision! Sowohl im Paket `mosaic` als auch im Paket `dplyr` gibt es einen Befehl `count`. Für `select` gilt das gleiche. Das arme R weiß nicht, welchen von beiden wir meinen und entscheidet sich im Zweifel für den falschen. Da hilft, zu sagen, aus welchem Paket wir den Befehl beziehen wollen. Das macht der Operator `::`.
</div>\EndKnitrBlock{rmdcaution}


Aha. Zur besseren Anschaulichkeit können wir das auch plotten (ein Diagramm dazu malen). 


```r
# install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)
qplot(x = Pclass, y = n, data = c1)
```

<img src="075_Fallstudie_Titanic_files/figure-html/plot-titanic1-1.png" width="70%" style="display: block; margin: auto;" />

Der Befehl `qplot` zeichnet automatisch Punkte, wenn auf beiden Achsen "Zahlen-Variablen" stehen (also Variablen, die keinen "Text", sondern nur Zahlen beinhalten. In R sind das Variablen vom Typ `int` (integer), also Ganze Zahlen oder vom Typ `num` (numeric), also reelle Zahlen).


```r

c2 <- dplyr::count(titanic_train, Survived)
c2
#> # A tibble: 2 × 2
#>   Survived     n
#>      <int> <int>
#> 1        0   549
#> 2        1   342
```

Man beachte, dass der Befehl `count` stehts eine Tabelle (data.frame bzw. `tibble`) verlangt und zurückliefert.


### Bivariate Häufigkeiten
OK, gut. Jetzt wissen wir die Häufigkeiten pro Wert von `Survived` (dasselbe gilt für `Pclass`). Eigentlich interessiert uns aber die Frage, ob sich die relativen Häufigkeiten der Stufen von `Pclass` innerhalb der Stufen von `Survived` unterscheiden. Einfacher gesagt: Ist der Anteil der Überlebenden in der 1. Klasse größer als in der 3. Klasse?

Zählen wir zuerst die Häufigkeiten für alle Kombinationen von `Survived` und `Pclass`:
  

```r
c3 <- dplyr::count(titanic_train, Survived, Pclass)
c3
#> Source: local data frame [6 x 3]
#> Groups: Survived [?]
#> 
#>   Survived Pclass     n
#>      <int>  <int> <int>
#> 1        0      1    80
#> 2        0      2    97
#> 3        0      3   372
#> 4        1      1   136
#> 5        1      2    87
#> 6        1      3   119
```

Da `Pclass` 3 Stufen hat (1., 2. und 3. Klasse) und innerhalb jeder dieser 3 Klassen es die Gruppe der Überlebenden und der Nicht-Überlebenden gibt, haben wir insgesamt 3*2=6 Gruppen.

Es ist hilfreich, sich diese Häufigkeiten wiederum zu plotten; wir nehmen den gleichen Befehl wie oben.


```r
qplot(x = Pclass, y = n, data = c3)
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-5-1.png" width="70%" style="display: block; margin: auto;" />

Hm, nicht so hilfreich. Schöner wäre, wenn wir (farblich) erkennen könnten, welcher Punkt für "Überlebt" und welcher Punkt für "Nicht-Überlebt" steht. Mit `qplot` geht das recht einfach: Wir sagen der Funktion `qplot`, dass die Farbe (`color`) der Punkte den Stufen von `Survived` zugeordnet werden sollen:
  

```r
qplot(x = Pclass, y = n, color = Survived, data = c3)
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-6-1.png" width="70%" style="display: block; margin: auto;" />

Viel besser. Was noch stört, ist, dass `Survived` als metrische Variable verstanden wird. Das Farbschema lässt Nuancen, feine Farbschattierungen, zu. Für nominale Variablen macht das keinen Sinn; es gibt da keine Zwischentöne. Tot ist tot, lebendig ist lebendig. Wir sollten daher der Funktion sagen, dass es sich um nominale Variablen handelt:
  

```r
qplot(x = factor(Pclass), y = n, color = factor(Survived), data = c3)
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-7-1.png" width="70%" style="display: block; margin: auto;" />

Viel besser. Jetzt noch ein bisschen Schnickschnack:
  
  

```r
qplot(x = factor(Pclass), y = n, color = factor(Survived), data = c3) + 
  labs(x = "Klasse", 
       title = "Überleben auf der Titanic",
       colour = "Überlebt?")
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-8-1.png" width="70%" style="display: block; margin: auto;" />


### Signifikanztest

Manche Leute mögen Signifikanztests. Ich persönlich stehe ihnen kritisch gegenüber, da ein p-Wert eine Funktion der Stichprobengröße ist und außerdem zumeist missverstanden wird (er gibt *nicht* die Wahrscheinlichkeit der getesteten Hypothese an, was die Frage aufwirft, warum er mich dann interessieren sollte). Aber seisdrum, berechnen wir mal einen p-Wert. Es gibt mehrere statistische Tests, die sich hier potenziell anböten (was die Frage nach der Objektivität von statistischen Tests in ein ungünstiges Licht rückt). Nehmen wir den $\chi^2$-Test.


```r
chisq.test(titanic_train$Survived, titanic_train$Pclass)
#> 
#> 	Pearson's Chi-squared test
#> 
#> data:  titanic_train$Survived and titanic_train$Pclass
#> X-squared = 100, df = 2, p-value <2e-16
```

Der p-Wert ist kleiner als 5%, daher entscheiden wir uns, entsprechend der üblichen Gepflogenheit, gegen die H0 und für die H1: "Es gibt einen Zusammenhang von Überlebensrate und Passagierklasse".


### Effektstärke
Abgesehen von der Signifikanz, und interessanter, ist die Frage, wie sehr die Variablen zusammenhängen. Für Häufigkeitsanalysen mit 2*2-Feldern bietet sich das "Odds Ratio" (OR), das Chancenverhältnis an. Das Chancen-Verhältnis beantwortet die Frage: "Um welchen Faktor ist die Überlebenschance in der einen Klasse größer als in der anderen Klasse?". Eine interessante Frage, als schauen wir es uns an. 

Das OR ist nur definiert für 2*2-Häufigkeitstabellen, daher müssen wir die Anzahl der Passagierklassen von 3 auf 2 verringern. Nehmen wir nur 1. und 3. Klasse, um den vermuteten Effekt deutlich herauszuschälen:
  

```r
t2 <- filter(titanic_train, Pclass != 2)  # "!=" heißt "nicht"
```

Alternativ (synonym) könnten wir auch schreiben:
  

```r
t2 <- filter(titanic_train, Pclass == 1 | Pclass == 3)  # "|" heißt "oder"
```

Und dann zählen wir wieder die Häufigkeiten aus pro Gruppe:
  

```r
c4 <- dplyr::count(t2, Pclass)
c4
#> # A tibble: 2 × 2
#>   Pclass     n
#>    <int> <int>
#> 1      1   216
#> 2      3   491
```


Schauen wir nochmal den p-Wert an, da wir jetzt ja mit einer veränderten Datentabelle operieren:
  

```r
chisq.test(t2$Survived, t2$Pclass)
#> 
#> 	Pearson's Chi-squared test with Yates' continuity correction
#> 
#> data:  t2$Survived and t2$Pclass
#> X-squared = 100, df = 1, p-value <2e-16
```

Ein $\chi^2$-Wert von ~96 bei einem *n* von 707.

Dann berechnen wir die Effektstärke (OR) mit dem Paket `compute.es` (muss ebenfalls installiert sein).

```r
library(compute.es)
chies(chi.sq = 96, n = 707)
#> Mean Differences ES: 
#>  
#>  d [ 95 %CI] = 0.79 [ 0.63 , 0.95 ] 
#>   var(d) = 0.01 
#>   p-value(d) = 0 
#>   U3(d) = 78.6 % 
#>   CLES(d) = 71.2 % 
#>   Cliff's Delta = 0.42 
#>  
#>  g [ 95 %CI] = 0.79 [ 0.63 , 0.95 ] 
#>   var(g) = 0.01 
#>   p-value(g) = 0 
#>   U3(g) = 78.6 % 
#>   CLES(g) = 71.2 % 
#>  
#>  Correlation ES: 
#>  
#>  r [ 95 %CI] = 0.37 [ 0.3 , 0.43 ] 
#>   var(r) = 0 
#>   p-value(r) = 0 
#>  
#>  z [ 95 %CI] = 0.39 [ 0.31 , 0.46 ] 
#>   var(z) = 0 
#>   p-value(z) = 0 
#>  
#>  Odds Ratio ES: 
#>  
#>  OR [ 95 %CI] = 4.21 [ 3.15 , 5.61 ] 
#>   p-value(OR) = 0 
#>  
#>  Log OR [ 95 %CI] = 1.44 [ 1.15 , 1.73 ] 
#>   var(lOR) = 0.02 
#>   p-value(Log OR) = 0 
#>  
#>  Other: 
#>  
#>  NNT = 3.57 
#>  Total N = 707
```

Die Chance zu überleben ist also in der 1. Klasse mehr als 4 mal so hoch wie in der 3. Klasse. Es scheint: Money buys you live...


### Logististische Regression
Berechnen wir noch das Odds Ratio mit Hilfe der logistischen Regression. Zum Einstieg: Ignorieren Sie die folgende Syntax und schauen Sie sich das Diagramm an. Hier sehen wir die (geschätzten) Überlebens-Wahrscheinlichkeiten für Passagiere der 1. Klasse vs. Passagiere der 3. Klasse.


```r
titanic2 <- titanic_train %>% 
  filter(Pclass %in% c(1,3)) %>% 
  mutate(Pclass = factor(Pclass))

glm1 <- glm(data = titanic2, 
            formula = Survived ~ Pclass, 
            family = "binomial")

exp(coef(glm1))
#> (Intercept)     Pclass3 
#>       1.700       0.188

titanic2$pred_prob <- predict(glm1, type = "response")
```


<img src="075_Fallstudie_Titanic_files/figure-html/fig-titanic-1.png" width="70%" style="display: block; margin: auto;" />

Wir sehen, dass die Überlebens-Wahrscheinlichkeit in der 1. Klasse höher ist als in der 3. Klasse. Optisch grob geschätzt, ~60% in der 1. Klasse und ~25% in der 3. Klasse.

Schauen wir uns die logistische Regression an: Zuerst haben wir den Datensatz auf die Zeilen beschränkt, in denen Personen aus der 1. und 3. Klasse vermerkt sind (zwecks Vergleichbarkeit zu oben). Dann haben wir mit `glm` und `family = "binomial"` eine *logistische* Regression angefordert. Man beachte, dass der Befehl sehr ähnlich zur normalen Regression (`lm(...)`) ist.

Da die Koeffizienten in der Logit-Form zurückgegeben werden, haben wir sie mit der Exponential-Funktion in die "normale" Odds-Form gebracht (delogarithmiert, boa). Wir sehen, dass die Überlebens-*Chance* (Odds) 1.7 zu 1 betrug - bei der *ersten* Stufe von `Pclass` (`1`)^[Darum haben wir `Pclass` in eine Faktor-Variable umgewandelt. Die "erste Klasse" ist jetzt die Referenzklasse, also sozusagen x = 0. Hätten wir `Pclass` als numerische Variable beibehalten, so würde der Achsenabschnitt die Überlebensrat für die "nullte" Klasse geben, was wenig Sinn macht.]; von 27 Menschen überlebten in dieser Gruppe also 17 (17/27 = .63 Überlebens-*Wahrscheinlichkeit*); s. `Intercept`; der Achsenabschnitt gibt den Odds an, wenn die Prädiktor-Variable(n) den Wert "Null" hat/ haben, bzw. die erste Ausprägung, hier 1. 

Im Vergleich dazu wird die Überlebens-Chance deutlich schlechter, wenn man die nächste Gruppe von `Pclass` (3) betrachtet. Die Odds verändern sich um den Faktor ~0.2. Da der Faktor *kleiner* als 1 ist, ist das kein gutes Zeichen. Die Überlebens-Chance *sinkt*; etwas genauer auf: 1.7 * 0.2 ≈ 0.34. Das heißt, die Überlebens-Chance ist in der 3. Klasse nur noch ca. 1 zu 3 (Überlebens-Wahrscheinlichkeit: ~25%).

Komfortabler können wir uns die Überlebens-*Wahrscheinlichkeiten* mit der Funktion `predict` ausgeben lassen.


```r
predict(glm1, newdata = data.frame(Pclass = factor("1")), type = "response")
#>    1 
#> 0.63
predict(glm1, newdata = data.frame(Pclass = factor("3")), type = "response")
#>     1 
#> 0.242
```

Alternativ kann man die Häufigkeiten auch noch "per Hand" bestimmen: 
  

```r
titanic_train %>% 
  filter(Pclass %in% c(1,3)) %>% 
  dplyr::select(Survived, Pclass) %>% 
  group_by(Pclass, Survived) %>% 
  summarise(n = n() ) %>% 
  mutate(Anteil = n / sum(n))
#> Source: local data frame [4 x 4]
#> Groups: Pclass [2]
#> 
#>   Pclass Survived     n Anteil
#>    <int>    <int> <int>  <dbl>
#> 1      1        0    80  0.370
#> 2      1        1   136  0.630
#> 3      3        0   372  0.758
#> 4      3        1   119  0.242
```


Übersetzen wir dies Syntax auf Deutsch:


\BeginKnitrBlock{rmdpseudocode}<div class="rmdpseudocode">Nehme den Datensatz "titanic_train" UND DANN  
Filtere nur die 1. und die 3. Klasse heraus UND DANN  
wähle nur die Spalten "Survived" und "Pclass" UND DANN  
gruppiere nach "Pclass" und "Survived" UND DANN  
zähle die Häufigkeiten für jede dieser Gruppen aus UND DANN  
berechne den Anteil an Überlebenden bzw. Nicht-Überlebenden  
für jede der beiden Passagierklassen. FERTIG.  
 
</div>\EndKnitrBlock{rmdpseudocode}


   



### Effektstärken visualieren
Zum Abschluss schauen wir uns die Stärke des Zusammenhangs noch einmal graphisch an. Wir berechnen dafür die relativen Häufigkeiten pro Gruppe (im Datensatz ohne 2. Klasse, der Einfachheit halber).


```r
c5 <- dplyr::count(t2, Pclass, Survived)
c5$prop <- c5$n / 707
c5
#> Source: local data frame [4 x 4]
#> Groups: Pclass [?]
#> 
#>   Pclass Survived     n  prop
#>    <int>    <int> <int> <dbl>
#> 1      1        0    80 0.113
#> 2      1        1   136 0.192
#> 3      3        0   372 0.526
#> 4      3        1   119 0.168
```

Genauer gesagt haben die Häufigkeiten pro Gruppe in Bezug auf die Gesamtzahl aller Passagiere berechnet; die vier Anteile addieren sich also zu 1 auf. 

Das visualisieren wir wieder


```r
qplot(x = factor(Pclass), y = prop, fill = factor(Survived), data = c5, geom = "col")
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-11-1.png" width="70%" style="display: block; margin: auto;" />

Das `geom = "col"` heißt, dass als "geometrisches Objekt" dieses Mal keine Punkte, sondern Säulen (columns) verwendet werden sollen.


```r
qplot(x = factor(Pclass), y = prop, fill = factor(Survived), data = c5, geom = "col")
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-12-1.png" width="70%" style="display: block; margin: auto;" />

Ganz nett, aber die Häufigkeitsunterscheide von `Survived` zwischen den beiden Werten von `Pclass` stechen noch nicht so ins Auge. Wir sollten es anders darstellen.

Hier kommt der Punkt, wo wir von `qplot` auf seinen großen Bruder, `ggplot` wechseln sollten. `qplot` ist in Wirklichkeit nur eine vereinfachte Form von `ggplot`; die Einfachheit wird mit geringeren Möglichkeiten bezahlt. Satteln wir zum Schluss dieser Fallstudie also um:
  

```r
ggplot(data = c5) +
  aes(x = factor(Pclass), y = n, fill = factor(Survived)) + 
  geom_col(position = "fill") +
  labs(x = "Passagierklasse", fill = "Überlebt?", caption = "Nur Passagiere, keine Besatzung")
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-13-1.png" width="70%" style="display: block; margin: auto;" />

Jeden sehen wir die Häufigkeiten des Überlebens bedingt auf die Passagierklasse besser. Wir sehen auf den ersten Blick, dass sich die Überlebensraten deutlich unterscheiden: Im linken Balken überleben die meisten; im rechten Balken ertrinken die meisten. 

Diese letzte Analyse zeigt deutlich die Kraft von (Daten-)Visualisierungen auf. Der zu untersuchende Effekt tritt hier am stärken zu Tage; außerdem ist die Analyse relativ einfach.

Eine alternative Darstellung ist diese:
  

```r
c5 %>% 
  ggplot +
  aes(x = factor(Pclass), y = factor(Survived), fill = n) +
  geom_tile()
```

<img src="075_Fallstudie_Titanic_files/figure-html/unnamed-chunk-14-1.png" width="70%" style="display: block; margin: auto;" />

Hier werden die vier "Fliesen" gleich groß dargestellt; die Fallzahl wird durch die Füllfarbe besorgt.


### Fazit
In der Datenanalyse (mit R) kommt man mit wenigen Befehlen schon sehr weit; `dplyr` und `ggplot2` zählen (zu Recht) zu den am häufigsten verwendeten Paketen. Beide sind flexibel, konsistent und spielen gerne miteinander. Die besten Einblicke haben wir aus deskriptiver bzw. explorativer Analyse (Diagramme) gewonnen. Signifikanztests oder komplizierte Modelle waren nicht zentral. In vielen Studien/Projekten der Datenanalyse gilt ähnliches: Daten umformen und verstehen bzw. "veranschaulichen" sind zentrale Punkte, die häufig viel Zeit und Wissen fordern. Bei der Analyse von nominalskalierten sind Häufigkeitsauswertungen ideal.






