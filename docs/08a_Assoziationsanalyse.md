

## Assoziationsanalyse


### Einführung

Im Rahmen einer Assoziationsanalyse werden Zusammenhänge (Assoziationen) zwischen Ereignissen innerhalb von Datensätzen untersucht, z. B. im Rahmen einer Warenkorbanalyse. Dabei wird eine Menge (*Set*) von *Items* (z. B. gekauften Produkten, $I=\{i_1, i_2, \ldots i_m \}$) innerhalb der *Transaktionen* ($D=\{t_1, t_2 ,\ldots ,t_n\}$) betrachtet. Eine *Regel* ($A \rightarrow B$) ist dann ein Zusammenhang zwischen den *Item Sets*. $A$ und $B$ sind dabei disjunkte, ggfs. leere oder einelementige Teilmengen von Items ($A, B \subseteq I; A\cap B=\emptyset$).

**Achtung:** Eine *Regel* impliziert keinen Kausalzusammenhang!

  Die computationale Herausforderung einer Assoziationsanalyse besteht darin, bei vielen *Items* (und damit sehr, sehr vielen Kombinationsmöglichkeiten) innerhalb von vielen *Transaktionen* diejenigen *Sets* zu finden, die häufig vorkommen.

Eine wichtige Anwendung im (e)CRM ist z. B. die Analyse des *Cross Buying* Verhaltens.

Assoziationsregeln sind eine explorative Analysemethode, die keine (statistische) Inferenz oder Kausalität aussagt. D. h. evt. Schlüsse aus der Analysen sollten vorsichtig schrittweise getestet und verglichen werden.

### Kennzahlen einer Assoziationsanalyse

- *Support($A$)*$=\frac{|\{t\in D; A \subseteq t\}|}{|D|}$: Relative Häufigkeit, d. h. der Anteil der Transaktionen, in denen eine Menge von Items ($A$) vorkommt, bezogen auf alle Transaktionen (vgl. Wahrscheinlichkeit, $P(A)$)
- *Support($A\rightarrow B$)*=Support($A\cup B$)$=\frac{|\{t\in D; (A\cup B) \subseteq t\}|}{|D|}$: Relative Häufigkeit, d. h. der Anteil der Transaktionen, in denen die Vereinigung einer Menge von Items $A$ und $B$ vorkommt, bezogen auf alle Transaktionen (vgl. gemeinsame Wahrscheinlichkeit, $P(A \cap B)$)
- *Confidence*($A \rightarrow B$)$=\frac{support(A \cup B)}{support(A)}$: Relative Häufigkeit von $B$ (rechte Seite), bezogen auf alle Transaktionen mit $A$ (linke Seite; vgl. bedingte Wahrscheinlichkeit, $P(B|A)$)
- *Lift*($A \rightarrow B$)$=\frac{support(A \cup B)}{support(A) \cdot support(B)}$: Steigerung des Supports von $A$ und $B$ im Vergleich zur unter Unabhängigkeit von $A$ und $B$ erwarteten Häufigkeit (vgl. $\frac{P(A\cap B)}{P(A) \cdot P(B)}=\frac{P(B|A)}{P(B)}$)

Hinweis: Support und Lift sind symmetrisch, Confidence nicht. Als Schätzwerte für Wahrscheinlichkeiten etc. können die genannten Kennzahlen ggfs. ungeeignet sein (insbesondere für seltene Items).

### Beispiel

- Support(Chips)$=0.05$, d. h. 5% der Transaktionen enthalten Chips
- Support(Bier)$=0.01$, d. h. 1% der Transaktionen enthalten Bier
- Support(Bier und Chips)$=0.002$, d. h. 0,2% der Transaktionen enthalten Bier und Chips, dann:
  - Confidence(Bier$\rightarrow$Chips)$=\frac{0.002}{0.01}=0.2$, d. h. 20% aller Transaktionen mit Bier enthalten auch Chips
- Lift(Bier$\rightarrow$Chips)$=\frac{0.002}{0.01\cdot 0.05}=\frac{0.2}{0.05}=4$, d. h. die Chance, dass eine Transaktion Chips enthält ist 4x größer als zu erwarten wäre, wenn es keinen Zusammenhang zwischen Bier und Chips gäbe


### Assoziationsanalyse mit R

Für eine Assoziationsanalyse kann in R das Zusatzpaket `arules` [https://cran.r-project.org/package=arules](https://cran.r-project.org/package=arules) verwendet werden.

Die (einmalige) Installation erfolgt über:
  
  ```r
  install.packages(c("arules", "arulesViz"))
  ```

Geladen wird das Paket dann über

```r
library(arules)
```

```
## Loading required package: Matrix
```

```
## 
## Attaching package: 'arules'
```

```
## The following objects are masked from 'package:base':
## 
##     abbreviate, write
```




Eine Einführung erhält man über die Paket Vignette

```r
vignette("arules")
```


#### Beispieldaten

Im Paket `arules` sind Point-Of-Sale Daten eines Lebensmittelgeschäftes von einem Monat enthalten.^[Michael Hahsler, Kurt Hornik, und Thomas Reutterer (2006) *Implications of probabilistic data modeling for mining association rules*. In: M. Spiliopoulou, R. Kruse, C. Borgelt, A. Nuernberger, und W. Gaul, Editors, From Data and Information Analysis to Knowledge Engineering, Studies in Classification, Data Analysis, and Knowledge Organization, Seiten 598–605. Springer-Verlag.] Die Lebensmittel wurden zu 169 Kategorien zusammengefasst, und es gibt 9835 Transaktionen:
  
  ```r
  data(Groceries, package = "arules") # Daten laden
  summary(Groceries)
  ```
  
  ```
  ## transactions as itemMatrix in sparse format with
  ##  9835 rows (elements/itemsets/transactions) and
  ##  169 columns (items) and a density of 0.02609146 
  ## 
  ## most frequent items:
  ##       whole milk other vegetables       rolls/buns             soda 
  ##             2513             1903             1809             1715 
  ##           yogurt          (Other) 
  ##             1372            34055 
  ## 
  ## element (itemset/transaction) length distribution:
  ## sizes
  ##    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15 
  ## 2159 1643 1299 1005  855  645  545  438  350  246  182  117   78   77   55 
  ##   16   17   18   19   20   21   22   23   24   26   27   28   29   32 
  ##   46   29   14   14    9   11    4    6    1    1    1    1    3    1 
  ## 
  ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  ##   1.000   2.000   3.000   4.409   6.000  32.000 
  ## 
  ## includes extended item information - examples:
  ##        labels  level2           level1
  ## 1 frankfurter sausage meat and sausage
  ## 2     sausage sausage meat and sausage
  ## 3  liver loaf sausage meat and sausage
  ```

*Hinweis:* Um einen Datensatz als Transaktionsdatensatz zu definieren wird der Befehl

```r
daten.trans <- as(daten, "transactions")
```
verwendet. Siehe auch Hilfeseite zu `transactions-class`.

Über `inspect()` können Transaktionen und Regeln betrachtet werden:
  
  ```r
  inspect(head(Groceries))
  ```
  
  ```
  ##     items                     
  ## [1] {citrus fruit,            
  ##      semi-finished bread,     
  ##      margarine,               
  ##      ready soups}             
  ## [2] {tropical fruit,          
  ##      yogurt,                  
  ##      coffee}                  
  ## [3] {whole milk}              
  ## [4] {pip fruit,               
  ##      yogurt,                  
  ##      cream cheese ,           
  ##      meat spreads}            
  ## [5] {other vegetables,        
  ##      whole milk,              
  ##      condensed milk,          
  ##      long life bakery product}
  ## [6] {whole milk,              
  ##      butter,                  
  ##      yogurt,                  
  ##      rice,                    
  ##      abrasive cleaner}
  ```


#### Regeln finden

Es existieren verschiedene Algorithmen um Assoziationsregeln zu finden. Hier wird der *Apriori* Algorithmus verwendet, wobei verschiedene Parameter (wie z. B. minimalen Support und Confidence) eingestellt werden können:
  
  ```r
  lebensmittel.regeln <- apriori(Groceries, parameter=list(supp=0.02, conf=0.1,
                                                         target="rules"))
  ```
  
  ```
  ## Apriori
  ## 
  ## Parameter specification:
  ##  confidence minval smax arem  aval originalSupport maxtime support minlen
  ##         0.1    0.1    1 none FALSE            TRUE       5    0.02      1
  ##  maxlen target   ext
  ##      10  rules FALSE
  ## 
  ## Algorithmic control:
  ##  filter tree heap memopt load sort verbose
  ##     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
  ## 
  ## Absolute minimum support count: 196 
  ## 
  ## set item appearances ...[0 item(s)] done [0.00s].
  ## set transactions ...[169 item(s), 9835 transaction(s)] done [0.00s].
  ## sorting and recoding items ... [59 item(s)] done [0.00s].
  ## creating transaction tree ... done [0.00s].
  ## checking subsets of size 1 2 3 done [0.00s].
  ## writing ... [128 rule(s)] done [0.00s].
  ## creating S4 object  ... done [0.00s].
  ```


```r
inspect(subset(lebensmittel.regeln, lift>2.5))
```

```
##     lhs                              rhs               support   
## [1] {pip fruit}                   => {tropical fruit}  0.02043721
## [2] {tropical fruit}              => {pip fruit}       0.02043721
## [3] {other vegetables,whole milk} => {root vegetables} 0.02318251
##     confidence lift    
## [1] 0.2701613  2.574648
## [2] 0.1947674  2.574648
## [3] 0.3097826  2.842082
```


Das Ergebnis zeigt, dass in ca. 2% der Transaktionen Kern- ("pip", z. B. Äpfel, Birnen) und Südfrüchte ("tropical", z. B. Zitronen) enthalten waren (*support*). 27% der Transaktionen mit Kernfrüchten (*lhs*) enthielten auch Südfrüchte (*rhs*, *confidence*).  Wenn also eine Transaktion eine Kernfrucht enthält ist ist es 2,57x häufiger, dass die Transaktion auch Südfrüchte enthält unter unabhängigen Häufigkeiten (*lift*).

Um die "Top" Regeln zu betrachten müssen die Regeln nach dem gewünschten Kriterium sortiert werden:
  
  ```r
  topregeln <- head(sort(lebensmittel.regeln, by="confidence"), 20)
  inspect(topregeln)
  ```
  
  ```
  ##      lhs                                   rhs                support   
  ## [1]  {other vegetables,yogurt}          => {whole milk}       0.02226741
  ## [2]  {butter}                           => {whole milk}       0.02755465
  ## [3]  {curd}                             => {whole milk}       0.02613116
  ## [4]  {root vegetables,other vegetables} => {whole milk}       0.02318251
  ## [5]  {root vegetables,whole milk}       => {other vegetables} 0.02318251
  ## [6]  {domestic eggs}                    => {whole milk}       0.02999492
  ## [7]  {whipped/sour cream}               => {whole milk}       0.03223183
  ## [8]  {root vegetables}                  => {whole milk}       0.04890696
  ## [9]  {root vegetables}                  => {other vegetables} 0.04738180
  ## [10] {frozen vegetables}                => {whole milk}       0.02043721
  ## [11] {margarine}                        => {whole milk}       0.02419929
  ## [12] {beef}                             => {whole milk}       0.02125064
  ## [13] {tropical fruit}                   => {whole milk}       0.04229792
  ## [14] {whipped/sour cream}               => {other vegetables} 0.02887646
  ## [15] {yogurt}                           => {whole milk}       0.05602440
  ## [16] {pip fruit}                        => {whole milk}       0.03009659
  ## [17] {whole milk,yogurt}                => {other vegetables} 0.02226741
  ## [18] {brown bread}                      => {whole milk}       0.02521607
  ## [19] {other vegetables}                 => {whole milk}       0.07483477
  ## [20] {pork}                             => {whole milk}       0.02216573
  ##      confidence lift    
  ## [1]  0.5128806  2.007235
  ## [2]  0.4972477  1.946053
  ## [3]  0.4904580  1.919481
  ## [4]  0.4892704  1.914833
  ## [5]  0.4740125  2.449770
  ## [6]  0.4727564  1.850203
  ## [7]  0.4496454  1.759754
  ## [8]  0.4486940  1.756031
  ## [9]  0.4347015  2.246605
  ## [10] 0.4249471  1.663094
  ## [11] 0.4131944  1.617098
  ## [12] 0.4050388  1.585180
  ## [13] 0.4031008  1.577595
  ## [14] 0.4028369  2.081924
  ## [15] 0.4016035  1.571735
  ## [16] 0.3978495  1.557043
  ## [17] 0.3974592  2.054131
  ## [18] 0.3887147  1.521293
  ## [19] 0.3867578  1.513634
  ## [20] 0.3844797  1.504719
  ```



### Visualisierung

Eine mögliche Visualisierung ist ein Streudiagramm von Support und Confidence

```r
library(arulesViz)
plot(lebensmittel.regeln)
```

<img src="08a_Assoziationsanalyse_files/figure-html/unnamed-chunk-10-1.png" width="672" />

Mit Hilfe der Option `interactive=TRUE` kann in Bereiche gezoomt werden -- und Regeln ausgewählt:
  
  ```r
  plot(lebensmittel.regeln, interactive=TRUE)
  ```

Aber auch z. B. ein Graph eines entsprechenden Netzwerks ist möglich:
  
  ```r
  plot(topregeln, method="graph")
  ```
  
  <img src="08a_Assoziationsanalyse_files/figure-html/unnamed-chunk-12-1.png" width="672" />


#### Literatur

- [Chris Chapman und Elea McDonnell Feit (2015), *R for Marketing Research and Analytics*, Springer](http://r-marketing.r-forge.r-project.org)
- [Michael Hahsler (2015), A Probabilistic Comparison of Commonly Used Interest Measures for Association Rules, URL: http://michael.hahsler.net/research/association_rules/measures.html](http://michael.hahsler.net/research/association_rules/measures.html)
- [Michael Hahsler, Sudheer Chelluboina, Kurt Hornik, und Christian Buchta (2011), *The arules R-package ecosystem: Analyzing interesting patterns from large transaction datasets*.  Journal of Machine Learning Research, 12:1977--1981](http://jmlr.csail.mit.edu/papers/v12/hahsler11a.html)
- [Michael Hahsler, Bettina Gruen und Kurt Hornik (2005), *arules - A Computational Environment for Mining Association Rules and Frequent Item Sets*.  Journal of Statistical Software 14/15.](http://dx.doi.org/10.18637/jss.v014.i15)
- Michael Hahsler, Kurt Hornik, und Thomas Reutterer (2006), *Implications of probabilistic data modeling for mining association rules.* In: M. Spiliopoulou, R. Kruse, C. Borgelt, A. Nuernberger, und W. Gaul, Editors, From Data and Information Analysis to Knowledge Engineering, Studies in Classification, Data Analysis, and Knowledge Organization, Seiten 598–605. Springer-Verlag.


#### Versionshinweise:
Die Darstellung orientiert sich an den Folienunterlagen von Chapman & Feit zum Buch *R for Marketing Research and Analytics*, Springer, 2015, siehe [http://r-marketing.r-forge.r-project.org/Instructor/slides-index.html](http://r-marketing.r-forge.r-project.org/Instructor/slides-index.html)
