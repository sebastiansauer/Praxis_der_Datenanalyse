





# Textmining



Ein großer Teil der zur Verfügung stehenden Daten liegt nicht als braves Zahlenmaterial vor, sondern in "unstrukturierter" Form, z.B. in Form von Texten. Im Gegensatz zur Analyse von numerischen Daten ist die Analyse von Texten[^99] weniger verbreitet bisher. In Anbetracht der Menge und der Informationsreichhaltigkeit von Text erscheint die Analyse von Text als vielversprechend.

[^99]: Dank an Karsten Lübke, dessen Fachkompetenz mir mindestens so geholfen hat wie seine Begeisterung an der Statistik ansteckend ist. 

In gewisser Weise ist das Textmining ein alternative zu klassischen qualitativen Verfahren der Sozialforschung. Geht es in der qualitativen Sozialforschung primär um das Verstehen eines Textes, so kann man für das Textmining ähnliche Ziele formulieren. Allerdings: Das Textmining ist wesentlich schwächer und beschränkter in der Tiefe des Verstehens. Der Computer ist einfach noch wesentlich *dümmer* als ein Mensch, in dieser Hinsicht. Allerdings ist er auch wesentlich *schneller* als ein Mensch, was das Lesen betrifft. Daher bietet sich das Textmining für das Lesen großer Textmengen an, in denen eine geringe Informationsdichte vermutet wird. Sozusagen maschinelles Sieben im großen Stil. Da fällt viel durch die Maschen, aber es werden Tonnen von Sand bewegt.

In der Regel wird das Textmining als *gemischte* Methode verwendet: sowohl qualitative als auch qualitative Aspekte spielen eine Rolle. Damit vermittelt das Textmining auf konstruktive Art und Weise zwischen den manchmal antagonierenden Schulen der qualitativ-idiographischen und der quantitativ-nomothetischen Sichtweise auf die Welt. Man könnte es auch als qualitative Forschung mit moderner Technik bezeichnen - mit den skizzierten Einschränkungen wohlgemerkt.

## Einführung

### Grundbegriffe
Die computergestützte Analyse von Texten speiste (und speist) sich reichhaltig aus Quellen der Linguistik; entsprechende Fachtermini finden Verwendung:  

- Ein *Corpus* bezeichnet die Menge der zu analyisierenden Dokumente; das könnten z.B. alle Reden der Bundeskanzlerin Angela Merkel sein oder alle Tweets von "\@realDonaldTrump".

- Ein *Token* (*Term*) ist ein elementarer Baustein eines Texts, die kleinste Analyseeinheit, häufig ein Wort. 

- Unter *tidy text* versteht man einen Dataframe, in dem pro Zeile nur ein Term steht [@Silge2016].

### Software
Für dieses Kapitel benötigen Sie R, RStudio sowie diese R-Pakete:


```r
install.packages(c("tidytext", "tidyverse", "pdftools", "downloader",
                    "ggdendro", "gridExtra", "knitr", "tm",
                    "lsa", "knitr", "SnowballC", "wordcloud"),
                    dependencies = TRUE)
```


## Grundlegende Analyse

### Tidy Text Dataframes

Basteln wir uns einen *tidy text* Dataframe. Wir gehen dabei von einem Vektor mit mehreren Text-Elementen aus, das ist ein realistischer Startpunkt. Unser Text-Vektor[^1] besteht aus 4 Elementen.

[^1]: Nach dem Gedicht "Jahrgang 1899" von Erich Kästner


```r
text <- c("Wir haben die Frauen zu Bett gebracht,",
          "als die Männer in Frankreich standen.",
          "Wir hatten uns das viel schöner gedacht.",
          "Wir waren nur Konfirmanden.")
```

Als nächstes machen wir daraus einen Dataframe.


```r
library(tidyverse)
text_df <- data_frame(Zeile = 1:4,
                      text)
```


 Zeile  text                                     
------  -----------------------------------------
     1  Wir haben die Frauen zu Bett gebracht,   
     2  als die Männer in Frankreich standen.    
     3  Wir hatten uns das viel schöner gedacht. 
     4  Wir waren nur Konfirmanden.              

Und "dehnen" diesen Dataframe zu einem *tidy text* Dataframe.

```r
library(tidytext)

text_df %>% 
  unnest_tokens(wort, text)
#> # A tibble: 24 × 2
#>   Zeile  wort
#>   <int> <chr>
#> 1     1   wir
#> 2     1 haben
#> 3     1   die
#> # ... with 21 more rows
```

Das `unnest_tokens` kann übersetzt werden als "entschachtele" oder "dehne" die Tokens - so dass in jeder Zeile nur noch ein Wort (Token) steht. Die Syntax ist `unnest_tokens(Ausgabespalte, Eingabespalte)`. Nebenbei werden übrigens alle Buchstaben auf Kleinschreibung getrimmt.

Als nächstes filtern wir die Satzzeichen heraus, da die Wörter für die Analyse wichtiger (oder zumindest einfacher) sind.


```r
library(stringr)

text_df %>% 
  unnest_tokens(wort, text) %>% 
  filter(str_detect(wort, "[a-z]"))
#> # A tibble: 24 × 2
#>   Zeile  wort
#>   <int> <chr>
#> 1     1   wir
#> 2     1 haben
#> 3     1   die
#> # ... with 21 more rows
```



### Text-Daten einlesen

Nun lesen wir Text-Daten ein; das können beliebige Daten sein. Eine gewisse Reichhaltigkeit ist von Vorteil. Nehmen wir das Parteiprogramm der Partei AfD[^2].

[^2]: https://www.alternativefuer.de/wp-content/uploads/sites/7/2016/05/2016-06-27_afd-grundsatzprogramm_web-version.pdf


```r
library(pdftools)
library(downloader)

afd_url <- "https://www.alternativefuer.de/wp-content/uploads/sites/7/2016/05/2016-06-27_afd-grundsatzprogramm_web-version.pdf"

afd_pfad <- "data/afd_programm.pdf"

download(afd_url, afd_pfad)

afd_raw <- pdf_text(afd_pfad)

afd_raw[3]
#> [1] "3\t Programm für Deutschland | Inhalt\n   7 | Kultur, Sprache und Identität\t\t\t\t                                   45 9 | Einwanderung, Integration und Asyl\t\t\t                       57\n     7.1 \t\t Deutsche Kultur, Sprache und Identität erhalten\t               47   9.1\t Keine irreguläre Einwanderung über das Asylrecht\t        59\n     7.2 \t\t Deutsche Leitkultur statt Multikulturalismus\t\t                 47   9.1.1\t Asylzuwanderung - für einen Paradigmenwechsel\t         59\n     7.3 \t\t Die deutsche Sprache als Zentrum unserer Identität\t            47   9.1.2\t Rückführung - Schluss mit Fehlanreizen und \t\t\t\n     7.4 \t \t Kultur und Kunst von Einflussnahme der Parteien befreien\t     48 \t\t       falscher Nachsicht\t\t\t\t\t                                60\n     7.5 \t\t Für eine zeitgemäße Medienpolitik: Rundfunkbeitrag abschaffen\t 48   9.2\t Einwanderung aus EU-Staaten\t\t\t\t                          61\n     7.6 \t\t Der Islam im Spannungsverhältnis zu unserer Werteordnung\t      48   9.3\t Gesteuerte Einwanderung aus Drittstaaten\t\t               62\n     7.6.1\t\t Der Islam gehört nicht zu Deutschland\t\t\t                      49   9.4\t Integration - Mehr als nur Deutsch lernen\t\t              63\n     7.6.2\t\t Kritik am Islam muss erlaubt sein\t\t\t                          49   9.5\t Kosten der Einwanderung - Transparenz herstellen\t        63\n     7.6.3\t\t Auslandsfinanzierung von Moscheen beenden\t \t                  49   9.6\t Einwandererkriminalität - nichts verschleiern,\n     7.6.4\t\t Keine öffentlich-rechtliche Körperschaft für                     \t\t       nichts verschweigen\t\t\t\t\t                               64\n     \t\t\t      islamische Organisationen\t\t\t\t                                50   9.7\t Einbürgerung - Abschluss gelungener Integration\t         65\n     7.6.5\t\t Keine Vollverschleierung im öffentlichen Raum\t                50\n                                                                              10 | Wirtschaft, digitale Welt und Verbraucherschutz\t           66\n   8 | Schule, Hochschule und Forschung\t\t\t                                 51   10.1\t\t Freier Wettbewerb sichert unseren Wohlstand\t\t          67\n     8.1 \t\t Forschung und Lehre: In Freiheit und als Einheit\t              52   10.2 \t\t Soziale Marktwirtschaft statt Planwirtschaft\t\t        67\n     8.1.1\t \t Autonomie durch Grundfinanzierung stärken\t \t                 52   10.3 \t\t Internationale Wirtschaftspolitik neu ausrichten\t     67\n     8.1.2\t\t Förderung der “Gender-Forschung” beenden\t\t                    52   10.4 \t\t Hohe Standards für Handelsabkommen\t\t                  68\n     8.1.3\t\t Diplom, Magister und Staatsexamen wieder einführen\t           52   10.5 \t\t Bürokratie abbauen\t\t\t\t\t                               68\n     8.1.4\t\t Studienanforderungen erhöhen\t\t\t                               53   10.6 \t\t Den Technologiestandort Deutschland voranbringen\t     68\n     8.2 \t\t Unser Schulsystem: Stark durch Differenzierung\t                53   10.7 \t\t Staatliche Subventionen reduzieren und befristen\t     69\n     8.2.1\t\t Die Einheitsschule führt zu Qualitätsverlust\t\t                53   10.8 \t\t Keine Privatisierung gegen den Willen der Bürger\t     69\n     8.2.2\t\t Wissensvermittlung muss zentrales Anliegen bleiben\t           53   10.9 \t\t Der Mittelstand als Herz unserer Wirtschaftskraft\t    69\n     8.2.3\t\t Leistungsbereitschaft und Disziplin stärken\t\t                 54   10.10 \tDigitalisierung als Chance und Herausforderung\t        69\n     8.2.4\t\t Politisch-ideologische Indoktrination darf es an                   10.10.1 Quelloffene Software und sichere Hardware\t\t           69\n   \t\t\t der Schule nicht geben\t\t\t\t\t                                         54   10.10.2 Sichere Kommunikation als Standortvorteil\n     8.2.5\t\t Duale berufliche Bildung stärken und erhalten\t \t              54 \t\t          und Bürgerrecht\t\t\t\t\t                                70\n     8.2.6\t\t Keine Inklusion “um jeden Preis”. Förder- und                      10.10.3 Deutsche Literatur im Inland digitalisieren\t\t         70\n     \t\t\t      Sonderschulen erhalten\t\t\t\t                                   54   10.11\t\t Verbraucherschutz modernisieren und stärken\t\t         70\n     8.2.7 \t\t Koranschulen schließen. Islamkunde in den                         10.11.1 Lebensmittel besser kennzeichnen\t\t\t                   71\n     \t\t\t      Ethikunterricht integrieren\t\t\t\t                              55   10.11.2 Langlebige Produkte statt geplante Obsoleszenz\t       71\n     8.2.8 \t Keine Sonderrechte für muslimische Schüler\t\t                  55   10.11.3 Textilien und Kinderspielzeug auf Schadstoffe prüfen\t 71\n     8.3 \t\t Nein zu “Gender-Mainstreaming” und                                  10.11.4 Wasseraufbereitung modernisieren und verbessern\t      71\n   \t\t\t        Frühsexualisierung\t\t\t\t\t                                      55\n     8.3.1 \t\t Keine “geschlechterneutrale” Umgestaltung der\n     \t\t\t      deutschen Sprache\t\t\t\t\t                                       55\n     8.3.2 \t Geschlechterquoten sind leistungsfeindlich\n   \t\t\t        und ungerecht\t\t\t\t\t\t                                          56\n"
```


Mit `download` haben wir die Datei mit der Url `afd_url` heruntergeladen und als `afd_pfad` gespeichert. Für uns ist `pdf_text` sehr praktisch, da diese Funktion Text aus einer beliebige PDF-Datei in einen Text-Vektor einliest.


Der Vektor `afd_raw` hat 96 Elemente; zählen wir die Gesamtzahl an Wörtern. Dazu wandeln wir den Vektor in einen tidy text Dataframe um. Auch die Stopwörter entfernen wir wieder wie gehabt.


```r

afd_df <- data_frame(Zeile = 1:96, 
                     afd_raw)


afd_df %>% 
  unnest_tokens(token, afd_raw) %>% 
  filter(str_detect(token, "[a-z]")) -> afd_df

count(afd_df) 
#> # A tibble: 1 × 1
#>       n
#>   <int>
#> 1 26396
```

Eine substanzielle Menge von Text. Was wohl die häufigsten Wörter sind?


### Worthäufigkeiten auszählen


```r
afd_df %>% 
  na.omit() %>%  # fehlende Werte löschen
  count(token, sort = TRUE)
#> # A tibble: 7,087 × 2
#>   token     n
#>   <chr> <int>
#> 1   die  1151
#> 2   und  1147
#> 3   der   870
#> # ... with 7,084 more rows
```

Die häufigsten Wörter sind inhaltsleere Partikel, Präpositionen, Artikel... Solche sogenannten "Stopwörter" sollten wir besser herausfischen, um zu den inhaltlich tragenden Wörtern zu kommen. Praktischerweise gibt es frei verfügbare Listen von Stopwörtern, z.B. im Paket `lsa`.


```r
library(lsa)
data(stopwords_de)

stopwords_de <- data_frame(word = stopwords_de)

stopwords_de <- stopwords_de %>% 
  rename(token = word)

afd_df %>% 
  anti_join(stopwords_de) -> afd_df
```


Unser Datensatz hat jetzt viel weniger Zeilen; wir haben also durch `anti_join` Zeilen gelöscht (herausgefiltert). Das ist die Funktion von `anti_join`: Die Zeilen, die in beiden Dataframes vorkommen, werden herausgefiltert. Es verbleiben also nicht "Nicht-Stopwörter" in unserem Dataframe. Damit wird es schon interessanter, welche Wörter häufig sind.


```r
afd_df %>% 
  count(token, sort = TRUE) -> afd_count

afd_count %>% 
  top_n(10) %>% 
  knitr::kable()
```



token            n
------------  ----
deutschland    190
afd            171
programm        80
wollen          67
bürger          57
euro            55
dafür           53
eu              53
deutsche        47
deutschen       47

Ganz interessant; aber es gibt mehrere Varianten des Themas "deutsch". Es ist wohl sinnvoller, diese auf den gemeinsamen Wortstamm zurückzuführen und diesen nur einmal zu zählen. Dieses Verfahren nennt man "stemming" oder trunkieren.


```r
library(SnowballC)

afd_df %>% 
  mutate(token_stem = wordStem(.$token, language = "german")) %>% 
  count(token_stem, sort = TRUE) -> afd_count

afd_count %>% 
  top_n(10) %>% 
  knitr::kable()
```



token_stem       n
------------  ----
deutschland    219
afd            171
deutsch        119
polit           88
staat           85
programm        81
europa          80
woll            67
burg            66
soll            63

Das ist schon informativer. Dem Befehl `wordStem` füttert man einen Vektor an Wörtern ein und gibt die Sprache an (Default ist Englisch[^3]). Das ist schon alles.

[^3]: http://www.omegahat.net/Rstem/stemming.pdf 

### Visualisierung


Zum Abschluss noch eine Visualisierung mit einer "Wordcloud" dazu.



```r
library(wordcloud)
wordcloud(words = afd_count$token_stem, freq = afd_count$n, max.words = 100, scale = c(2,.5), colors=brewer.pal(6, "Dark2"))
```

<img src="Textmining_files/figure-html/unnamed-chunk-14-1.png" width="70%" style="display: block; margin: auto;" />

Man kann die Anzahl der Wörter, Farben und einige weitere Formatierungen der Wortwolke beeinflussen[^4].

[^4]: https://cran.r-project.org/web/packages/wordcloud/index.html
 
 
Weniger verspielt ist eine schlichte visualisierte Häufigkeitsauszählung dieser Art.


```r

afd_count %>% 
  top_n(30) %>% 
  ggplot() +
  aes(x = reorder(token_stem, n), y = n) +
  geom_col() + 
  labs(title = "mit Trunkierung") +
  coord_flip() -> p1

afd_df %>% 
  count(token, sort = TRUE) %>% 
  top_n(30) %>% 
  ggplot() +
  aes(x = reorder(token, n), y = n) +
  geom_col() +
  labs(title = "ohne Trunkierung") +
  coord_flip() -> p2


library(gridExtra)
grid.arrange(p1, p2, ncol = 2)
```

<img src="Textmining_files/figure-html/unnamed-chunk-15-1.png" width="70%" style="display: block; margin: auto;" />

Die beiden Diagramme vergleichen die trunkierten Wörter mit den nicht trunktierten Wörtern. Mit `reorder` ordnen wir die Spalte `token` nach der Spalte `n`. `coord_flip` dreht die Abbildung um 90°, d.h. die Achsen sind vertauscht. `grid.arrange` packt beide Plots in eine Abbildung, welche 2 Spalten (`ncol`) hat.


## Sentiment-Analyse
Eine weitere interessante Analyse ist, die "Stimmung" oder "Emotionen" (Sentiments) eines Textes auszulesen. Die Anführungszeichen deuten an, dass hier ein Maß an Verständnis suggeriert wird, welches nicht (unbedingt) von der Analyse eingehalten wird. Jedenfalls ist das Prinzip der Sentiment-Analyse im einfachsten Fall so: 

>    Schau dir jeden Token aus dem Text an.  
     Prüfe, ob sich das Wort im Lexikon der Sentiments wiederfindet.  
     Wenn ja, dann addiere den Sentimentswert dieses Tokens zum bestehenden Sentiments-Wert.  
     Wenn nein, dann gehe weiter zum nächsten Wort.  
     Liefere zum Schluss die Summenwerte pro Sentiment zurück.    
     
     
Es gibt Sentiment-Lexika, die lediglich einen Punkt für "positive Konnotation" bzw. "negative Konnotation" geben; andere Lexiko weisen differenzierte Gefühlskonnotationen auf. Wir nutzen hier [dieses](http://asv.informatik.uni-leipzig.de/download/sentiws.html) Lexikon [@remquahey2010]. Der Einfachheit halber gehen wir im Folgenden davon aus, dass das Lexikon schon aufbereitet vorliegt. Die Aufbereitung unten im Abschnitt zur Vertiefung nachgelesen werden.



Unser Sentiment-Lexikon sieht so aus:


```r
library(knitr)

kable(head(sentiment_df))
```



neg_pos   Wort            Wert  Inflektionen                          
--------  -----------  -------  --------------------------------------
neg       Abbau         -0.058  Abbaus,Abbaues,Abbauen,Abbaue         
neg       Abbruch       -0.005  Abbruches,Abbrüche,Abbruchs,Abbrüchen 
neg       Abdankung     -0.005  Abdankungen                           
neg       Abdämpfung    -0.005  Abdämpfungen                          
neg       Abfall        -0.005  Abfalles,Abfälle,Abfalls,Abfällen     
neg       Abfuhr        -0.337  Abfuhren                              

### Ungewichtete Sentiment-Analyse
Nun können wir jedes Token des Textes mit dem Sentiment-Lexikon abgleichen; dabei zählen wir die Treffer für positive bzw. negative Terme. Besser wäre noch: Wir könnten die Sentiment-Werte pro Treffer addieren (und nicht für jeden Term 1 addieren). Aber das heben wir uns für später auf.


```r
sentiment_neg <- match(afd_df$token, filter(sentiment_df, neg_pos == "neg")$Wort)
neg_score <- sum(!is.na(sentiment_neg))

sentiment_pos <- match(afd_df$token, filter(sentiment_df, neg_pos == "pos")$Wort)
pos_score <- sum(!is.na(sentiment_pos))

round(pos_score/neg_score, 1)
#> [1] 2.7
```

Hier schauen wir für jedes negative (positive) Token, ob es einen "Match" im Sentiment-Lexikon (`sentiment_df$Wort`) gibt; das geht mit `match`. `match` liefert `NA` zurück, wenn es keinen Match gibt (ansonsten die Nummer des Sentiment-Worts). Wir brauchen also nur die Anzahl der Nicht-Nas (`!is.na`) auszuzählen, um die Anzahl der Matches zu bekommen.


Entgegen dem, was man vielleicht erwarten würde, ist der Text offenbar positiv geprägt. Der "Positiv-Wert" ist ca. 2.6 mal so groß wie der "Negativ-Wert". Fragt sich, wie sich dieser Wert mit anderen vergleichbaren Texten (z.B. andere Parteien) misst. Hier sei noch einmal betont, dass die Sentiment-Analyse bestenfalls grobe Abschätzungen liefern kann und keinesfalls sich zu einem hermeneutischen Verständnis aufschwingt.


Welche negativen Wörter und welche positiven Wörter wurden wohl verwendet? Schauen wir uns ein paar an.





```r
afd_df %>% 
  mutate(sentiment_neg = sentiment_neg,
         sentiment_pos = sentiment_pos) -> afd_df

afd_df %>% 
  filter(!is.na(sentiment_neg)) %>% 
  select(token) -> negative_sentiments
  
head(negative_sentiments$token,50)
#>  [1] "mindern"       "verbieten"     "unmöglich"     "töten"        
#>  [5] "träge"         "schädlich"     "unangemessen"  "unterlassen"  
#>  [9] "kalt"          "schwächen"     "ausfallen"     "verringern"   
#> [13] "verringern"    "verringern"    "verringern"    "belasten"     
#> [17] "belasten"      "fremd"         "schädigenden"  "klein"        
#> [21] "klein"         "klein"         "klein"         "eingeschränkt"
#> [25] "eingeschränkt" "entziehen"     "schwer"        "schwer"       
#> [29] "schwer"        "schwer"        "verharmlosen"  "unerwünscht"  
#> [33] "abgleiten"     "wirkungslos"   "schwach"       "verschleppen" 
#> [37] "vermindern"    "vermindern"    "ungleich"      "widersprechen"
#> [41] "zerstört"      "zerstört"      "erschweren"    "auffallen"    
#> [45] "unvereinbar"   "unvereinbar"   "unvereinbar"   "abhängig"     
#> [49] "abhängig"      "abhängig"


afd_df %>% 
  filter(!is.na(sentiment_pos)) %>% 
  select(token) -> positive_sentiments

head(positive_sentiments$token, 50)
#>  [1] "optimal"         "aufstocken"      "locker"         
#>  [4] "zulässig"        "gleichwertig"    "wiederbeleben"  
#>  [7] "beauftragen"     "wertvoll"        "nah"            
#> [10] "nah"             "nah"             "überzeugt"      
#> [13] "genehmigen"      "genehmigen"      "überleben"      
#> [16] "überleben"       "genau"           "verständlich"   
#> [19] "erlauben"        "aufbereiten"     "zugänglich"     
#> [22] "messbar"         "erzeugen"        "erzeugen"       
#> [25] "ausgleichen"     "ausreichen"      "mögen"          
#> [28] "kostengünstig"   "gestiegen"       "gestiegen"      
#> [31] "bedeuten"        "massiv"          "massiv"         
#> [34] "massiv"          "massiv"          "einfach"        
#> [37] "finanzieren"     "vertraulich"     "steigen"        
#> [40] "erweitern"       "verstehen"       "schnell"        
#> [43] "zugreifen"       "tätig"           "unternehmerisch"
#> [46] "entlasten"       "entlasten"       "entlasten"      
#> [49] "entlasten"       "helfen"
```

### Anzahl der unterschiedlichen negativen bzw. positiven Wörter

Allerdings müssen wir unterscheiden zwischen der *Anzahl* der negativen bzw. positiven Wörtern und der Anzahl der *unterschiedlichen* Wörter.

Zählen wir noch die Anzahl der unterschiedlichen Wörter im negativen und positiven Fall.


```r
afd_df %>% 
  filter(!is.na(sentiment_neg)) %>% 
  summarise(n_distinct_neg = n_distinct(token))
#> # A tibble: 1 × 1
#>   n_distinct_neg
#>            <int>
#> 1             96


afd_df %>% 
  filter(!is.na(sentiment_pos)) %>% 
    summarise(n_distinct_pos = n_distinct(token))
#> # A tibble: 1 × 1
#>   n_distinct_pos
#>            <int>
#> 1            187
```

Dieses Ergebnis passt zum vorherigen: Die Anzahl der positiven Wörter (187) ist ca. doppelt so groß wie die Anzahl der negativen Wörter (96).


### Gewichtete Sentiment-Analyse

Oben haben wir nur ausgezählt, *ob* ein Term der Sentiment-Liste im Corpus vorkam. Genauer ist es, diesen Term mit seinem Sentiment-Wert zu gewichten, also eine gewichtete Summe zu erstellen.


```r
sentiment_df %>% 
  rename(token = Wort) -> sentiment_df

afd_df %>% 
  left_join(sentiment_df, by = "token") -> afd_df 



afd_df %>% 
  filter(!is.na(Wert)) %>% 
  summarise(Sentimentwert = sum(Wert, na.rm = TRUE)) -> afd_sentiment_summe


afd_sentiment_summe$Sentimentwert
#> [1] -23.9
```





Zuerst bennenen wir `Wort` in `token` um, damit es beiden Dataframes (`sentiment_df` und `afd_df`) eine Spalte mit gleichen Namen gibt. Diese Spalte können wir dann zum "Verheiraten" (`left_join`) der beiden Spalten nutzen. Dann summieren wir den Sentiment-Wert jeder nicht-leeren Zeile auf. 

Siehe da: Nun ist der Duktus deutlich negativer als positiver. Offebar werden mehr positive Wörter als negative verwendet, *aber* die negativen sind viel intensiver.


### Tokens mit den extremsten Sentimentwerten

Schauen wir uns die intensivesten Wörter mal an.


```r
afd_df %>% 
  filter(neg_pos == "pos") %>% 
  distinct(token, .keep_all = TRUE) %>% 
  arrange(-Wert) %>% 
  filter(row_number() < 11) %>% 
  select(token, Wert) %>% 
  kable()
```



token           Wert
------------  ------
besonders      0.539
genießen       0.498
wichtig        0.382
sicher         0.373
helfen         0.373
miteinander    0.370
groß           0.369
wertvoll       0.357
motiviert      0.354
gepflegt       0.350

```r

afd_df %>% 
  filter(neg_pos == "neg") %>% 
  distinct(token, .keep_all = TRUE) %>% 
  arrange(Wert) %>% 
  filter(row_number() < 11) %>% 
  select(token, Wert) %>% 
  kable()
```



token           Wert
-----------  -------
schädlich     -0.927
schwach       -0.921
brechen       -0.799
ungerecht     -0.784
behindern     -0.775
falsch        -0.762
gemein        -0.720
gefährlich    -0.637
verbieten     -0.629
vermeiden     -0.526

Tatsächlich erscheinen die negativen Wörter "dampfender" und "fauchender" als die positiven.

Die Syntax kann hier so übersetzt werden:

>    Nehmen den Dataframe adf_df UND DANN   
     filtere die Token mit negativen Sentiment UND DANN    
     lösche doppelte Zeilen UND DANN    
     sortiere (absteigend) UND DANN    
     filtere nur die Top 10 UND DANN    
     zeige nur die Saplten token und Wert UND DANN   
     zeige eine schöne Tabelle.
     
     
### Relativer Sentiments-Wert
Nun könnte man noch den erzielten "Netto-Sentimentswert" des Corpus ins Verhältnis setzen Sentimentswert des Lexikons: Wenn es insgesamt im Sentiment-Lexikon sehr negativ zuginge, wäre ein negativer Sentimentwer in einem beliebigen Corpus nicht überraschend.  
     


```r

sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  ggplot() +
  aes(x = Wert) +
  geom_histogram()
```

<img src="Textmining_files/figure-html/unnamed-chunk-25-1.png" width="70%" style="display: block; margin: auto;" />

Es scheint einen (leichten) Überhang an negativen Wörtern zu geben. Schauen wir auf die genauen Zahlen.


```r
sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  count(neg_pos)
#> # A tibble: 2 × 2
#>   neg_pos     n
#>     <chr> <int>
#> 1     neg  1818
#> 2     pos  1650
```

Tatsächlich ist die Zahl negativ konnotierter Terme etwas größer als die Zahl der positiv konnotierten. Jetzt gewichten wir die Zahl mit dem Sentimentswert der Terme, in dem wir die Sentimentswerte (die ein negatives bzw. ein positives Vorzeichen aufweisen) aufaddieren.


```r
sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  summarise(sentiment_summe = sum(Wert)) -> sentiment_lexikon_sum

sentiment_lexikon_sum$sentiment_summe
#> [1] -187
```

Im Vergleich zum Sentiment der Lexikons ist unser Corpus deutlich negativer. Um genau zu sein, um diesen Faktor:


```r
sentiment_lexikon_sum$sentiment_summe / afd_sentiment_summe$Sentimentwert
#> [1] 7.83
```

Der *relative Sentimentswert* (relativ zum Sentiment-Lexikon) beträgt also ~7.8.


## Verknüpfung mit anderen Variablen
Kann man die Textdaten mit anderen Daten verknüpfen, so wird die Analyse reichhaltiger. So könnte man überprüfen, ob sich zwischen Sentiment-Gehalt und Zeit oder Autor ein Muster findet/bestätigt. Uns liegen in diesem Beispiel keine andere Daten vor, so dass wir dieses Beispiel nicht weiter verfolgen.



--- 

## Vertiefung 

### Erstellung des Sentiment-Lexikons

Der Zweck dieses Abschnitts ist es, eine Sentiment-Lexikon in deutscher Sprache einzulesen.

Dazu wird das Sentiment-Lexikon [dieser Quelle](http://asv.informatik.uni-leipzig.de/download/sentiws.html) verwendet (CC-BY-NC-SA 3.0). In [diesem Paper](http://asv.informatik.uni-leipzig.de/publication/file/155/490_Paper.pdf) finden sich Hintergründe. Von dort lassen sich die Daten herunter laden. Im folgenden gehe ich davon aus, dass die Daten herunter geladen sind und sich im Working Directory befinden.


Wir benötigen diese Pakete (es ginge auch über base):

```r
library(stringr)
library(readr)
library(dplyr)
```

Dann lesen wir die Daten ein, zuerst die Datei mit den negativen Konnotationen:

```r
neg_df <- read_tsv("SentiWS_v1.8c_Negative.txt", col_names = FALSE)
names(neg_df) <- c("Wort_POS", "Wert", "Inflektionen")

glimpse(neg_df)

```

Dann parsen wir aus der ersten Spalte (`Wort_POS`) zum einen den entsprechenden Begriff (z.B. "Abbau") und zum anderen die Wortarten-Tags (eine Erläuterung zu den Wortarten-Tags findet sich [hier](http://www.jlcl.org/2013_Heft1/H2013-1.pdf)).


```r

neg_df %>% 
  mutate(Wort = str_sub(Wort_POS, 1, regexpr("\\|", .$Wort_POS)-1),
         POS = str_sub(Wort_POS, start = regexpr("\\|", .$Wort_POS)+1)) -> neg_df

```

`str_sub` parst zuerst das Wort. Dazu nehmen wir den Wort-Vektor `Wort_POS`, und für jedes Element wird der Text von Position 1 bis vor dem Zeichen `|` geparst; da der Querstrich ein Steuerzeichen in Regex muss er escaped werden. Für `POS` passiert das gleiche von Position `|`+1 bis zum Ende des Text-Elements.

Das gleiche wiederholen wir für positiv konnotierte Wörter.


```r
pos_df <- read_tsv("SentiWS_v1.8c_Positive.txt", col_names = FALSE)
names(pos_df) <- c("Wort_POS", "Wert", "Inflektionen")
pos_df %>% 
  mutate(Wort = str_sub(Wort_POS, 1, regexpr("\\|", .$Wort_POS)-1),
         POS = str_sub(Wort_POS, start = regexpr("\\|", .$Wort_POS)+1)) -> pos_df
```


Schließlich schweißen wir beide Dataframes in einen:


```r
bind_rows("neg" = neg_df, "pos" = pos_df, .id = "neg_pos") -> sentiment_df
sentiment_df %>% select(neg_pos, Wort, Wert, Inflektionen, -Wort_POS) -> sentiment_df
```


```r
knitr::kable(head(sentiment_df))
```



neg_pos   token           Wert  Inflektionen                          
--------  -----------  -------  --------------------------------------
neg       Abbau         -0.058  Abbaus,Abbaues,Abbauen,Abbaue         
neg       Abbruch       -0.005  Abbruches,Abbrüche,Abbruchs,Abbrüchen 
neg       Abdankung     -0.005  Abdankungen                           
neg       Abdämpfung    -0.005  Abdämpfungen                          
neg       Abfall        -0.005  Abfalles,Abfälle,Abfalls,Abfällen     
neg       Abfuhr        -0.337  Abfuhren                              

