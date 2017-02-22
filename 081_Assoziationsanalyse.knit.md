


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
install.packages(c("arules", "arulesViz"), dep = TRUE)
```

Geladen wird das Paket dann über

```r
library(arules)
```

Eine Einführung erhält man über die Paket-Vignette

```r
vignette("arules")
```


#### Beispieldaten

Im Paket `arules` sind Point-Of-Sale Daten eines Lebensmittelgeschäftes von einem Monat enthalten.^[Michael Hahsler, Kurt Hornik, und Thomas Reutterer (2006) *Implications of probabilistic data modeling for mining association rules*. In: M. Spiliopoulou, R. Kruse, C. Borgelt, A. Nuernberger, und W. Gaul, Editors, From Data and Information Analysis to Knowledge Engineering, Studies in Classification, Data Analysis, and Knowledge Organization, Seiten 598–605. Springer-Verlag.] Die Lebensmittel wurden zu 169 Kategorien zusammengefasst, und es gibt 9835 Transaktionen:


```r
#data(Groceries, package = "arules") # Daten laden
load(file = "data/Groceries.Rda")
summary(Groceries)
#> transactions as itemMatrix in sparse format with
#>  9835 rows (elements/itemsets/transactions) and
#>  169 columns (items) and a density of 0.0261 
#> 
#> most frequent items:
#>       whole milk other vegetables       rolls/buns             soda 
#>             2513             1903             1809             1715 
#>           yogurt          (Other) 
#>             1372            34055 
#> 
#> element (itemset/transaction) length distribution:
#> sizes
#>    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15 
#> 2159 1643 1299 1005  855  645  545  438  350  246  182  117   78   77   55 
#>   16   17   18   19   20   21   22   23   24   26   27   28   29   32 
#>   46   29   14   14    9   11    4    6    1    1    1    1    3    1 
#> 
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>     1.0     2.0     3.0     4.4     6.0    32.0 
#> 
#> includes extended item information - examples:
#>        labels  level2           level1
#> 1 frankfurter sausage meat and sausage
#> 2     sausage sausage meat and sausage
#> 3  liver loaf sausage meat and sausage
```

*Hinweis:* Um einen Datensatz als Transaktionsdatensatz zu definieren wird der Befehl

```r
library(methods)
daten.trans <- as(daten, "transactions")
```
verwendet. Siehe auch Hilfeseite zu `transactions-class`.

Über `inspect()` können Transaktionen und Regeln betrachtet werden:














