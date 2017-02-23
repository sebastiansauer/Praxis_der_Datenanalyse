




# Clusteranalyse



Wir werden einen *simulierten* Datensatz  aus *Chapman & Feit (2015): R for Marketing Research and Analytics. Springer* analysieren ([http://r-marketing.r-forge.r-project.org](http://r-marketing.r-forge.r-project.org)). Näheres dazu siehe Kapitel 5 dort.

Sie können ihn von [hier](https://goo.gl/eUm8PI) als `csv`-Datei herunterladen:

```r
#download.file("https://goo.gl/eUm8PI", destfile = "segment.csv")
```

Das Einlesen erfolgt, sofern die Daten im Arbeitsverzeichnis liegen, wieder über:

```r
segment <- read.csv2("https://goo.gl/eUm8PI")
```

Ein Überblick über die Daten:

```r
str(segment)
#> 'data.frame':	300 obs. of  7 variables:
#>  $ Alter         : num  50.2 40.7 43 40.3 41.1 ...
#>  $ Geschlecht    : Factor w/ 2 levels "Frau","Mann": 2 2 1 2 1 2 1 2 1 1 ...
#>  $ Einkommen     : num  51356 64411 71615 42728 71641 ...
#>  $ Kinder        : int  0 3 2 1 4 2 5 1 1 0 ...
#>  $ Eigenheim     : Factor w/ 2 levels "Ja","Nein": 2 2 1 2 2 1 2 2 2 2 ...
#>  $ Mitgliedschaft: Factor w/ 2 levels "Ja","Nein": 2 2 2 2 2 2 1 1 2 2 ...
#>  $ Segment       : Factor w/ 4 levels "Aufsteiger","Gemischte Vorstadt",..: 2 2 2 2 2 2 2 2 2 2 ...
head(segment)
#>   Alter Geschlecht Einkommen Kinder Eigenheim Mitgliedschaft
#> 1  50.2       Mann     51356      0      Nein           Nein
#> 2  40.7       Mann     64411      3      Nein           Nein
#> 3  43.0       Frau     71615      2        Ja           Nein
#> 4  40.3       Mann     42728      1      Nein           Nein
#> 5  41.1       Frau     71641      4      Nein           Nein
#> 6  40.2       Mann     60325      2        Ja           Nein
#>              Segment
#> 1 Gemischte Vorstadt
#> 2 Gemischte Vorstadt
#> 3 Gemischte Vorstadt
#> 4 Gemischte Vorstadt
#> 5 Gemischte Vorstadt
#> 6 Gemischte Vorstadt
```

Zur Unterstützung der Analyse wird (wieder) `mosaic` und `tidyverse` verwendet:

```r
library(tidyverse)
library(mosaic)
```

Das Ziel einer Clusteranalyse ist es, Gruppen von Beobachtungen (d. h. *Cluster*) zu finden, die innerhalb der Cluster möglichst homogen, zwischen den Clustern möglichst heterogen sind. Um die Ähnlichkeit von Beobachtungen zu bestimmen, können verschiedene Distanzmaße herangezogen werden. Für metrische Merkmale wird z. B. häufig die euklidische Metrik verwendet, d. h., Ähnlichkeit und Distanz werden auf Basis des euklidischen Abstands bestimmt. Aber auch andere Abstände wie Manhatten oder Gower sind möglich. Letztere haben den Vorteil, dass sie nicht nur für metrische Daten sondern auch für gemischte Variablentypen verwendet werden können.

Auf Basis der drei metrischen Merkmale (d. h. `Alter`, `Einkommen` und `Kinder`) ergeben sich für die ersten sechs Beobachtungen folgende Abstände:

```r
dist(head(segment))
#>         1       2       3       4       5
#> 2 19941.8                                
#> 3 30946.1 11004.3                        
#> 4 13179.5 33121.3 44125.6                
#> 5 30985.9 11044.0    39.9 44165.3        
#> 6 13700.4  6241.5 17245.8 26879.9 17285.5
```

Sie können erkennen, dass die Beobachtungen `5` und `3` den kleinsten Abstand haben, während `5` und `4` den größten haben. Allerdings zeigen die Rohdaten auch, dass die euklidischen Abstände von der Skalierung der Variablen abhängen (`Einkommen` streut stärker als `Kinder`). Daher kann es evt. sinnvoll sein, die Variablen vor der Analyse zu standardisieren (z. B. über `scale()`). Die Funktion `daisy()` aus dem Paket `cluster` bietet hier nützliche Möglichkeiten.


```r
library(cluster)

daisy(head(segment))
#> Dissimilarities :
#>       1     2     3     4     5
#> 2 0.307                        
#> 3 0.560 0.390                  
#> 4 0.219 0.184 0.502            
#> 5 0.516 0.220 0.242 0.404      
#> 6 0.401 0.206 0.239 0.268 0.426
#> 
#> Metric :  mixed ;  Types = I, N, I, I, N, N, N 
#> Number of objects : 6
```


### Hierarchische Clusteranalyse

Bei hierarchischen Clusterverfahren werden Beobachtungen sukzessiv zusammengefasst (agglomerativ). Zunächst ist jede Beobachtung ein eigener Cluster, die dann je nach Ähnlichkeitsmaß zusammengefasst werden. 

Fassen wir die Beobachtungen *ohne* die Segmentvariable `Segment`, Variable 7, zusammen:

```r
seg.dist <- daisy(segment[,-7]) # Abstände
seg.hc <- hclust(seg.dist) # Hierarchische Clusterung
```

Das Ergebnis lässt sich schön im Dendrogramm darstellen:

```r
plot(seg.hc)
```

<img src="082_Clusteranalyse_files/figure-html/unnamed-chunk-9-1.png" width="70%" style="display: block; margin: auto;" />

Je höher (`Height`) die Stelle ist, an der zwei Beobachtungen oder Cluster zusammengefasst werden, desto größer ist die Distanz. D. h., Beobachtungen bzw. Cluster, die unten zusammengefasst werden, sind sich ähnlich, die, die oben zusammengefasst werden unähnlich.

Hier wurde übrigens die Standardeinstellung für die Berechnung des Abstands von Clustern verwendet: Complete Linkage bedeutet, dass die Distanz zwischen zwei Clustern auf Basis des maximalen Abstands der Beobachtungen innerhalb des Clusters gebildet wird.

Es ist nicht immer einfach zu entscheiden, wie viele Cluster es gibt. In der Praxis und Literatur finden sich häufig Zahlen zwischen 3 und 10. Evt. gibt es im Dendrogramm eine Stelle, an der der Baum gut geteilt werden kann. In unserem Fall vielleicht bei einer Höhe von $0.6$, da sich dann 3 Cluster ergeben:

```r
plot(seg.hc)
rect.hclust(seg.hc, h=0.6, border="red")
```

<img src="082_Clusteranalyse_files/figure-html/unnamed-chunk-10-1.png" width="70%" style="display: block; margin: auto;" />

Das Ergebnis, d. h. die Clusterzuordnung, kann durch den Befehl `cutree()` den Beobachtungen zugeordnet werden.

```r
segment$hc.clust <- cutree(seg.hc, k=3)
```

Z. B. haben wir folgende Anzahlen für Beobachtungen je Cluster:

```r
mosaic::tally(~hc.clust, data=segment)
#> hc.clust
#>   1   2   3 
#> 140 122  38
```
Cluster 3  ist also mit Abstand der kleinste Cluster (mit 38 Beobachtungen).

Für den Mittelwert des Alters je Cluster gilt:

```r

segment %>% 
  group_by(hc.clust) %>% 
  summarise(Alter_nach_Cluster = mean(Alter))
#> # A tibble: 3 × 2
#>   hc.clust Alter_nach_Cluster
#>      <int>              <dbl>
#> 1        1               38.5
#> 2        2               46.4
#> 3        3               34.5
```
D. h. die Durchschnittsalter ist in Cluster der Cluster unterscheiden sich.

Das spiegelt sich auch im Einkommen wieder:

```r
segment %>% 
  group_by(hc.clust) %>% 
  summarise(Einkommen_nach_Cluster = mean(Einkommen))
#> # A tibble: 3 × 2
#>   hc.clust Einkommen_nach_Cluster
#>      <int>                  <dbl>
#> 1        1                  49452
#> 2        2                  54355
#> 3        3                  44113
```

Allerdings sind die Unterschiede in der Geschlechtsverteilung eher gering:

```r
mosaic::tally(Geschlecht~hc.clust, data=segment, format="proportion")
#>           hc.clust
#> Geschlecht     1     2     3
#>       Frau 0.543 0.549 0.526
#>       Mann 0.457 0.451 0.474
```


### k-Means Clusteranalyse

Beim k-Means Clusterverfahren handelt es sich im Gegensatz zur hierarchischen Clusteranalyse um ein partitionierendes Verfahren. Die Daten werde in k Cluster aufgeteilt -- dabei muss die Anzahl der Cluster im vorhinein feststehen. Ziel ist es, dass die Quadratsumme der Abweichungen der Beobachtungen im Cluster zum Clusterzentrum minimiert wird. 

Der Ablauf des Verfahrens ist wie folgt:

1.  Zufällige Beobachtungen als Clusterzentrum
2.  Zuordnung der Beobachtungen zum nächsten Clusterzentrum (Ähnlichkeit, z. B. über die euklidische Distanz)
3.  Neuberechnung der Clusterzentren als Mittelwert der dem Cluster zugeordneten Beobachtungen

Dabei werden die Schritte 2. und 3. solange wiederholt, bis sich keine Änderung der Zuordnung mehr ergibt -- oder eine maximale Anzahl an Iterationen erreicht wurde.

*Hinweis:* Die (robuste) Funktion `pam()` aus dem Paket `cluster` kann auch mit allgemeinen Distanzen umgehen. Außerdem für gemischte Variablentypen gut geeignet: Das Paket [`clustMixType`](https://cran.r-project.org/web/packages/clustMixType/index.html).


Zur Vorbereitung überführen wir die nominalen Merkmale in logische, d. h. binäre Merkmale, und löschen die Segmente sowie das Ergebnis der hierarchischen Clusteranalyse:

```r
segment.num <- segment %>%
  mutate(Frau = Geschlecht=="Frau") %>%
  mutate(Eigenheim = Eigenheim=="Ja") %>%
  mutate(Mitgliedschaft = Mitgliedschaft=="Ja") %>%
  dplyr::select(-Geschlecht, -Segment, -hc.clust)
```

Über die Funktion `mutate()` werden Variablen im Datensatz erzeugt oder verändert. Über `select()` werden einzene Variablen ausgewählt. Die "Pfeife" `%>%` übergeben das Ergebnis der vorherigen Funktion an die folgende.

Aufgrund von (1.) hängt das Ergebnis einer k-Means Clusteranalyse vom Zufall ab. Aus Gründen der Reproduzierbarkeit sollte daher der Zufallszahlengenerator gesetzt werden. Außerdem bietet es sich an verschiedene Startkonfigurationen zu versuchen. in der Funktion `kmeans()` erfolgt dies durch die Option `nstart=`. Hier mit `k=4` Clustern:


```r
set.seed(1896)

seg.k <- kmeans(segment.num, centers = 4, nstart = 10)
seg.k
#> K-means clustering with 4 clusters of sizes 111, 26, 58, 105
#> 
#> Cluster means:
#>   Alter Einkommen Kinder Eigenheim Mitgliedschaft  Frau
#> 1  42.9     46049  1.649     0.505         0.1081 0.568
#> 2  56.4     85973  0.385     0.538         0.0385 0.538
#> 3  27.0     22608  1.224     0.276         0.2069 0.414
#> 4  43.6     62600  1.505     0.457         0.1238 0.590
#> 
#> Clustering vector:
#>   [1] 1 4 4 1 4 4 4 1 2 4 1 1 4 4 1 1 1 1 1 4 4 4 1 4 1 1 1 1 4 1 4 4 1 1 2
#>  [36] 1 4 1 1 4 4 4 1 4 4 4 4 1 1 1 1 1 2 1 1 4 4 4 4 1 4 1 4 1 1 1 1 4 4 4
#>  [71] 4 1 1 4 1 1 4 4 4 4 1 4 1 3 1 4 1 1 1 1 4 4 4 1 1 4 1 4 4 4 3 3 3 3 3
#> [106] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
#> [141] 3 3 3 3 3 3 3 3 3 3 1 2 4 2 2 4 1 1 2 2 4 4 1 1 4 2 4 4 1 2 2 3 4 1 2
#> [176] 2 4 2 3 4 4 4 1 1 1 1 1 1 4 3 1 4 4 4 4 1 1 1 2 4 4 1 2 4 4 1 4 2 1 2
#> [211] 4 3 4 2 2 4 2 1 4 3 1 2 2 4 2 4 4 1 4 4 1 1 1 1 1 3 1 1 4 1 4 3 1 4 1
#> [246] 4 1 4 1 4 4 4 4 1 1 1 4 4 1 1 1 1 1 1 4 1 1 1 1 1 2 4 4 1 4 1 1 1 1 2
#> [281] 4 4 4 4 1 4 1 4 4 4 1 4 1 4 1 4 1 1 4 1
#> 
#> Within cluster sum of squares by cluster:
#> [1] 3.18e+09 2.22e+09 1.69e+09 2.81e+09
#>  (between_SS / total_SS =  90.6 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"    
#> [5] "tot.withinss" "betweenss"    "size"         "iter"        
#> [9] "ifault"
```
Neben der Anzahl Beobachtungen im Cluster (z. B. 26 in Cluster 2) werden auch die Clusterzentren ausgegeben. Diese können dann direkt verglichen werden. Sie sehen z. B., dass das Durchschnittsalter in Cluster 3 mit 27 am geringsten ist. Der Anteil der Eigenheimbesitzer ist mit 54 \% in Cluster 2 am höchsten.

Einen Plot der Scores auf den beiden ersten Hauptkomponenten können Sie über die Funktion `clusplot()` aus dem Paket `cluster` erhalten.

```r
clusplot(segment.num, seg.k$cluster, 
         color = TRUE, shade = TRUE, labels = 4)
```

<img src="082_Clusteranalyse_files/figure-html/unnamed-chunk-18-1.png" width="70%" style="display: block; margin: auto;" />
Wie schon im deskriptiven Ergebnis: Die Cluster `1` und `4` unterscheiden sich (in den ersten beiden Hauptkomponenten) nicht wirklich. Vielleicht sollten dies noch zusammengefasst werden, d. h., mit `centers=3` die Analyse wiederholt werden?^[Das Paket `NbClust`, siehe Malika Charrad, Nadia Ghazzali, Veronique Boiteau, Azam Niknafs (2014) *NbClust: An R Package for Determining the Relevant Number of Clusters in a Data Set*, Journal of Statistical Software, 61(6), 1-36. [http://dx.doi.org/10.18637/jss.v061.i06](http://dx.doi.org/10.18637/jss.v061.i06), bietet viele Möglichkeiten die Anzahl der Cluster optimal zu bestimmen.]

***

### Übung: B3 Datensatz

Der B3 Datensatz *Heilemann, U. and Münch, H.J. (1996): West German Business Cycles 1963-1994: A Multivariate Discriminant Analysis. CIRET–Conference in Singapore, CIRET–Studien 50.* enthält Quartalsweise Konjunkturdaten aus (West-)Deutschland.

Er kann von [https://goo.gl/0YCEHf](https://goo.gl/0YCEHf) heruntergeladen werden.

1. Wenn die Konjunkturphase `PHASEN` nicht berücksichtigt wird, wie viele Cluster könnte es geben? Ändert sich das Ergebnis, wenn die Variablen standardisiert werden?
2. Führen Sie eine k-Means Clusteranalyse mit 4 Clustern durch. Worin unterscheiden sich die gefundenen Segmente?


### Literatur

- Chris Chapman, Elea McDonnell Feit (2015): *R for Marketing Research and Analytics*, Kapitel 11.3
- Reinhold Hatzinger, Kurt Hornik, Herbert Nagel (2011): *R -- Einführung durch angewandte Statistik*. Kapitel 12
- Gareth James, Daniela Witten, Trevor Hastie, Robert Tibshirani (2013): *An Introduction to Statistical Learning -- with Applications in R*, [http://www-bcf.usc.edu/~gareth/ISL/](http://www-bcf.usc.edu/~gareth/ISL/), Kapitel 10.3, 10.5


***
Diese Übung orientiert sich am Beispiel aus Kapitel 11.3 aus Chapman und Feit (2015) und steht unter der Lizenz [Creative Commons Attribution-ShareAlike 3.0 Unported](http://creativecommons.org/licenses/by-sa/3.0). Der Code steht unter der [Apache Lizenz 2.0](http://www.apache.org/licenses/LICENSE-2.0)

