



## Baumbasierte Verfahren

### Konjunturanalyse
Der B3 Datensatz *Heilemann, U. and Münch, H.J. (1996): West German Business Cycles 1963-1994: A Multivariate Discriminant Analysis. CIRET–Conference in Singapore, CIRET–Studien 50.* enthält Quartalsweise Konjunkturdaten aus (West-)Deutschland.


```r
B3 <- read.csv2("https://goo.gl/0YCEHf")
str(B3) # Datenstruktur
#> 'data.frame':	157 obs. of  14 variables:
#>  $ PHASEN  : int  2 2 3 3 3 3 3 3 3 3 ...
#>  $ BSP91JW : num  10.53 10.6 9.21 5.17 4.93 ...
#>  $ CP91JW  : num  9.31 12.66 6.55 7.87 8.6 ...
#>  $ DEFRATE : num  0.05 0.06 0.05 0.05 0.04 0.04 0.04 0.03 0.03 0 ...
#>  $ EWAJW   : num  5.7 5.2 4.8 3.3 2.1 3.2 2.5 2.7 3 0.3 ...
#>  $ EXIMRATE: num  3.08 1.96 2.82 3.74 4.16 2.9 3.65 4.57 4.37 2.89 ...
#>  $ GM1JW   : num  11.15 11.03 10.04 8.33 7.69 ...
#>  $ IAU91JW : num  23.56 12.72 11.52 0.85 -2.08 ...
#>  $ IB91JW  : num  14.69 24.95 14.9 7.55 3.23 ...
#>  $ LSTKJW  : num  3 2.36 3.39 5.3 6.91 1.03 3.73 6.2 4.12 7.94 ...
#>  $ PBSPJW  : num  2.89 2.59 3.01 3.03 3.46 1.95 3.18 3.98 3.29 5.63 ...
#>  $ PCPJW   : num  1.91 2.2 3.09 2.08 1.48 1.65 1.47 3.29 3.59 4.19 ...
#>  $ ZINSK   : num  6.27 4.6 6.19 6.71 7.1 4.96 5.21 4.83 4.5 3.83 ...
#>  $ ZINSLR  : num  3.21 3.54 3.22 3.37 3.14 4.95 3.82 3.09 3.91 1.47 ...
head(B3); tail(B3)
#>   PHASEN BSP91JW CP91JW DEFRATE EWAJW EXIMRATE GM1JW IAU91JW IB91JW LSTKJW
#> 1      2   10.53   9.31    0.05   5.7     3.08 11.15   23.56  14.69   3.00
#> 2      2   10.60  12.66    0.06   5.2     1.96 11.03   12.72  24.95   2.36
#> 3      3    9.21   6.55    0.05   4.8     2.82 10.04   11.52  14.90   3.39
#> 4      3    5.17   7.87    0.05   3.3     3.74  8.33    0.85   7.55   5.30
#> 5      3    4.93   8.60    0.04   2.1     4.16  7.69   -2.08   3.23   6.91
#> 6      3    8.39   5.62    0.04   3.2     2.90  6.62   -3.76  14.58   1.03
#>   PBSPJW PCPJW ZINSK ZINSLR
#> 1   2.89  1.91  6.27   3.21
#> 2   2.59  2.20  4.60   3.54
#> 3   3.01  3.09  6.19   3.22
#> 4   3.03  2.08  6.71   3.37
#> 5   3.46  1.48  7.10   3.14
#> 6   1.95  1.65  4.96   4.95
#>     PHASEN BSP91JW CP91JW DEFRATE EWAJW EXIMRATE GM1JW IAU91JW IB91JW
#> 152      3   -1.27   1.29   -4.87 -1.97     6.03  9.79  -18.29   1.73
#> 153      3   -2.13  -0.57   -2.98 -2.05     7.59  0.72  -15.82  -3.23
#> 154      3    1.39   2.33   -2.86 -1.84     7.49 11.33  -10.59   4.62
#> 155      4    1.63   0.64    1.20 -1.58     7.75 11.38   -4.90   3.62
#> 156      1    1.40   0.57   -3.56 -1.34     5.58  9.53   -0.76   2.19
#> 157      1    1.83  -0.08   -2.22 -0.93     7.50 15.20    2.75   6.12
#>     LSTKJW PBSPJW PCPJW ZINSK ZINSLR
#> 152   1.08   2.73  2.98  6.83   3.55
#> 153   1.67   2.67  3.31  6.35   3.05
#> 154  -0.12   2.66  2.94  5.88   3.17
#> 155  -1.81   1.77  2.58  5.29   4.82
#> 156  -1.54   1.85  2.60  5.01   5.27
#> 157  -0.92   1.79  2.49  5.28   5.62
```

Dabei sind folgende Variablen enthalten:

- Bruttosozialprodukt (real): `BSP91JW`
- Privater Verbrauch (real): `CP91JW`
- Anteil Staatsdefizit am Bruttosozialprodukt (%): `DEFRATE`
- Abhängig Erwerbstätige: `EWAJW`
- Anteil Außenbeitrag am Bruttosozialprodukt (%): `EXIMRATE`
- Geldmenge M1: `GM1JW`
- Investitionen in Ausrüstungsgüter (real): `IAU91JW`
- Investitionen in Bauten (real): `IB91JW`
- Lohnstückkosten: `LSTKJW`
- Preisindex des Bruttosozialprodukts: `PBSPJW`
- Preisindex des privaten Verbrauchs: `PCPJW`
- Kurzfristiger Zinssatz (nominal): `ZINSK`
- Langfristiger Zinssatz (real): `ZINSLR`
- Konjunkturphase: 1. Aufschwung, 2. Oberer Wendepunkt, 3. Abschwung,4. Unterer Wendepunkt: `PHASEN`

Variablen mit der Endung *JW* beziehen sich auf die jährliche Veränderung.

### Regressionsbäume
Um einen Regressionsbaum zu erzeugen, muss zunächst das Zusatzpaket `rpart` geladen werden:

```r
library(rpart)
```

Um z. B. die Veränderung des Bruttosozialprodukt als Funktion von Privater Verbrauch, Investitionen in Ausrüstungsgüter, Investitionen in Bauten und Geldmenge M1 als Regressionsbaum zu modellieren reicht der Befehl

```r
regbaum <- rpart(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=B3)
```


Um das Ergebnis auszugeben genügt:

```r
regbaum
#> n= 157 
#> 
#> node), split, n, deviance, yval
#>       * denotes terminal node
#> 
#>  1) root 157 1380.0  3.5000  
#>    2) CP91JW< 3.71 79  380.0  1.5200  
#>      4) IAU91JW< -0.365 38  120.0 -0.0379  
#>        8) IB91JW< -2.22 20   45.1 -0.9020 *
#>        9) IB91JW>=-2.22 18   43.9  0.9220 *
#>      5) IAU91JW>=-0.365 41   81.6  2.9600  
#>       10) IB91JW< 2.42 22   29.5  2.2100 *
#>       11) IB91JW>=2.42 19   25.0  3.8400 *
#>    3) CP91JW>=3.71 78  378.0  5.5000  
#>      6) IAU91JW< 11.3 50  142.0  4.5700  
#>       12) IB91JW< 3.2 22   40.0  3.5500 *
#>       13) IB91JW>=3.2 28   61.3  5.3700 *
#>      7) IAU91JW>=11.3 28  114.0  7.1700  
#>       14) IB91JW< 7.55 17   51.2  6.2200 *
#>       15) IB91JW>=7.55 11   23.7  8.6400 *
```
*Lesebeispiel:* Wenn CP91JW>=3.705 und IAU91JW>=11.335 und IB91JW>=7.55 liegt, dann liegt die durchschnittliche Veränderung des BSP91JW bei 8.639. 11 Beobachtungen erfüllen die Kriterien der unabhängigen Variablen

Bzw. um den Baum zu zeichnen


```r
par(xpd = TRUE) # Grafikparameter der sicherstellt, dass alles ins Bild passt
plot(regbaum, compress = TRUE) # Baum zeichnen
text(regbaum) # Baum beschriften
```

<img src="073_baumbasierte_Verfahren_files/figure-html/unnamed-chunk-6-1.png" width="70%" style="display: block; margin: auto;" />


Eine deutlich schönere Ausgabe erhält man z. B. mit dem Zusatzpaket `rpart.plot`, welches man *einmalig* über

```r
install.packages("rpart.plot")
```
installieren muss und dann benutzen kann.

Zunächst laden

```r
library(rpart.plot)
```
und dann zeichnen:

```r
rpart.plot(regbaum)
```

<img src="073_baumbasierte_Verfahren_files/figure-html/unnamed-chunk-9-1.png" width="70%" style="display: block; margin: auto;" />



#### Kreuzvalidierung

##### Anpassungsgüte
Wie gut ist das Modell? Über `predict` können die Punktprognosen berechnet werden:

```r
head(predict(regbaum))
#>    1    2    3    4    5    6 
#> 8.64 8.64 8.64 5.37 5.37 5.37
```
Diese werden mit den beobachteten Werten verglichen:

```r
head(B3$BSP91JW)
#> [1] 10.53 10.60  9.21  5.17  4.93  8.39
```

Der **Mean Squared Error** ist dann

```r
baummse <- mean( (predict(regbaum) - B3$BSP91JW)^2 )
baummse
#> [1] 2.04
```

Vergleichen wir das Ergebnis mit dem einer linearen Regression

```r
reglm <- lm(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=B3)
summary(reglm)
#> 
#> Call:
#> lm(formula = BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data = B3)
#> 
#> Residuals:
#>    Min     1Q Median     3Q    Max 
#> -3.048 -0.880 -0.057  0.801  3.674 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.22442    0.26280    4.66  6.9e-06 ***
#> CP91JW       0.38729    0.05846    6.63  5.7e-10 ***
#> IAU91JW      0.12752    0.01634    7.80  9.0e-13 ***
#> IB91JW       0.13880    0.01719    8.08  1.9e-13 ***
#> GM1JW       -0.00996    0.02676   -0.37     0.71    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 1.37 on 152 degrees of freedom
#> Multiple R-squared:  0.792,	Adjusted R-squared:  0.786 
#> F-statistic:  145 on 4 and 152 DF,  p-value: <2e-16
```

Der MSE der Linearen Regression liegt bei

```r
lmmse <- mean( (predict(reglm) - B3$BSP91JW)^2 )
lmmse
#> [1] 1.83
```

Der Baum ist einfacher und weniger flexibel, aber auch schlechter im Bezug auf die Anpassungsgüte.

##### Prognosegüte
Für eine k=3 fache Kreuzvalidierung müssen 3 Testdatensätze erzeugt werden.

Zunächst wird dafür ein Aufteilungsvektor gebildet:

```r
aufteilung <- rep(1:3, length.out=nrow(B3))
```
und dann wird aufgeteilt:

```r
test1 <- B3[aufteilung==1,]
train1 <- B3[aufteilung!=1,]

test2 <- B3[aufteilung==2,]
train2 <- B3[aufteilung!=2,]

test3 <- B3[aufteilung==3,]
train3 <- B3[aufteilung!=3,]
```

Anschließend werden die Modelle auf den Trainingsdaten geschätzt, und auf den Testdaten überprüft:

```r
# Runde 1
b1 <- rpart(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train1)
l1 <- lm(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train1)
mseb1 <- mean( (predict(b1, newdata = test1) - test1$BSP91JW)^2 )
msel1 <- mean( (predict(l1, newdata = test1) - test1$BSP91JW)^2 )

# Runde 2
b2 <- rpart(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train2)
l2 <- lm(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train2)
mseb2 <- mean( (predict(b2, newdata = test2) - test2$BSP91JW)^2 )
msel2 <- mean( (predict(l2, newdata = test2) - test2$BSP91JW)^2 )

# Runde 3
b3 <- rpart(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train3)
l3 <- lm(BSP91JW ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train3)
mseb3 <- mean( (predict(b3, newdata = test3) - test3$BSP91JW)^2 )
msel3 <- mean( (predict(l3, newdata = test3) - test3$BSP91JW)^2 )

# Ergebnisse zusammenfassen
msecvb <- c(mseb1, mseb2, mseb3)
msecvl <- c(msel1, msel2, msel3)

# Mittelwert des Prognose MSE
mean(msecvb)
#> [1] 3.62
mean(msecvl)
#> [1] 1.99
```

Bei den vorliegenden Daten ist also ein *lineares* Modell dem Baummodell im Bezug auf den *MSE* überlegen.

**Hinweis:** In der Praxis führt man die Aufteilung nicht manuell sondern innerhalb von Schleifen durch.

### Klassifikationbäume
Untersuchen wir, ob makroökonomische Kennzahlen geeignet sind, die Konjunkturphasen zu unterscheiden. 
Zunächst stellen wir fest, dass die eigentlich kategorielle Variable `PHASEN` hier numerisch kodiert wurde, was aber schnell verwirren würde.

```r
typeof(B3$PHASEN)
#> [1] "integer"
```
Typänderung zu `factor` geht einfach:

```r
B3$PHASEN <- as.factor(B3$PHASEN)
```
Wenn wir die einzelnen `levels` des Faktors als numerische Werte verwenden wollen würde man den Befehl `as.numeric()` verwenden. Aber sicherheitshalber vorher über `levels()` gucken, ob die Reihenfolge auch stimmt.

Um die Interpretation zu erleichtern können wir hier einfach die Faktorstufe umbenennen.

```r
levels(B3$PHASEN) <- c("Aufschwung", "Oberer Wendepunkt", 
                       "Abschwung", "Unterer Wendepunkt")
```

Um z. B. die Konjunkturphase als Funktion von Privater Verbrauch, Investitionen in Ausrüstungsgüter, Investitionen in Bauten und Geldmenge M1 als Regressionsbaum zu modellieren reicht jetzt der Befehl

```r
klassbaum <- rpart(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=B3)
```


Um das Ergebnis auszugeben genügt:

```r
klassbaum
#> n= 157 
#> 
#> node), split, n, loss, yval, (yprob)
#>       * denotes terminal node
#> 
#>  1) root 157 98 Aufschwung (0.3758 0.1529 0.2994 0.1720)  
#>    2) IAU91JW>=-0.09 109 55 Aufschwung (0.4954 0.2110 0.2110 0.0826)  
#>      4) CP91JW< 5.19 68 20 Aufschwung (0.7059 0.1029 0.1324 0.0588)  
#>        8) IB91JW>=3.32 29  7 Aufschwung (0.7586 0.2069 0.0345 0.0000) *
#>        9) IB91JW< 3.32 39 13 Aufschwung (0.6667 0.0256 0.2051 0.1026)  
#>         18) GM1JW< 11 32  7 Aufschwung (0.7813 0.0312 0.1250 0.0625)  
#>           36) IAU91JW>=3.25 25  3 Aufschwung (0.8800 0.0400 0.0000 0.0800) *
#>           37) IAU91JW< 3.25 7  3 Abschwung (0.4286 0.0000 0.5714 0.0000) *
#>         19) GM1JW>=11 7  3 Abschwung (0.1429 0.0000 0.5714 0.2857) *
#>      5) CP91JW>=5.19 41 25 Oberer Wendepunkt (0.1463 0.3902 0.3415 0.1220)  
#>       10) IAU91JW>=7.49 31 15 Oberer Wendepunkt (0.1613 0.5161 0.2581 0.0645)  
#>         20) CP91JW>=7.69 10  2 Oberer Wendepunkt (0.1000 0.8000 0.1000 0.0000) *
#>         21) CP91JW< 7.69 21 13 Oberer Wendepunkt (0.1905 0.3810 0.3333 0.0952)  
#>           42) CP91JW< 6.2 8  3 Oberer Wendepunkt (0.2500 0.6250 0.1250 0.0000) *
#>           43) CP91JW>=6.2 13  7 Abschwung (0.1538 0.2308 0.4615 0.1538) *
#>       11) IAU91JW< 7.49 10  4 Abschwung (0.1000 0.0000 0.6000 0.3000) *
#>    3) IAU91JW< -0.09 48 24 Abschwung (0.1042 0.0208 0.5000 0.3750)  
#>      6) GM1JW< 11.4 38 14 Abschwung (0.0789 0.0000 0.6316 0.2895)  
#>       12) IB91JW>=-4.08 23  5 Abschwung (0.1304 0.0000 0.7826 0.0870) *
#>       13) IB91JW< -4.08 15  6 Unterer Wendepunkt (0.0000 0.0000 0.4000 0.6000) *
#>      7) GM1JW>=11.4 10  3 Unterer Wendepunkt (0.2000 0.1000 0.0000 0.7000) *
```
*Lesebeispiel:* Wenn IAU91JW< -0.09 und GM1JW>=11.355 liegt, dann ist der Untere Wendepunkt die häufigste Merkmalsausprägung von PHASEN (relative Häufigkeit von PHASEN=4 hier: 0.7) 10 Beobachtungen erfüllen die Kriterien der unabhängigen Variablen.



```r
par(xpd = TRUE) # Grafikparameter der sicherstellt, dass alles ins Bild passt
plot(klassbaum, compress = TRUE) # Baum zeichnen
text(klassbaum) # Baum beschriften
```

<img src="073_baumbasierte_Verfahren_files/figure-html/unnamed-chunk-23-1.png" width="70%" style="display: block; margin: auto;" />

Bzw. "schöner":

```r
rpart.plot(klassbaum)
```

<img src="073_baumbasierte_Verfahren_files/figure-html/unnamed-chunk-24-1.png" width="70%" style="display: block; margin: auto;" />


#### Kreuzvalidierung

Wie gut ist das Modell? Auch hier können über `predict` die Punktprognosen bestimmt werden:

```r
head(predict(klassbaum, type="class"))
#>                 1                 2                 3                 4 
#> Oberer Wendepunkt Oberer Wendepunkt         Abschwung         Abschwung 
#>                 5                 6 
#>         Abschwung         Abschwung 
#> Levels: Aufschwung Oberer Wendepunkt Abschwung Unterer Wendepunkt
```
Diese werden mit den beobachteten Werten verglichen:

```r
head(B3$PHASEN)
#> [1] Oberer Wendepunkt Oberer Wendepunkt Abschwung         Abschwung        
#> [5] Abschwung         Abschwung        
#> Levels: Aufschwung Oberer Wendepunkt Abschwung Unterer Wendepunkt
```

Die **Fehlklassifikationsrate** ist dann

```r
baumer <- mean( (predict(klassbaum, type="class") != B3$PHASEN) )
baumer
#> [1] 0.293
```
also knapp 30%.

Vergleichen kann man den Klassifikationsbaum z. B. mit der *Linearen Diskriminanzanalyse*. Diese ist im Paket `MASS` implementiert.

```r
library(MASS)
```


```r
klasslda <- lda(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=B3)
klasslda
#> Call:
#> lda(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data = B3)
#> 
#> Prior probabilities of groups:
#>         Aufschwung  Oberer Wendepunkt          Abschwung 
#>              0.376              0.153              0.299 
#> Unterer Wendepunkt 
#>              0.172 
#> 
#> Group means:
#>                    CP91JW IAU91JW IB91JW GM1JW
#> Aufschwung           3.55  6.8936   3.40  8.61
#> Oberer Wendepunkt    6.43 11.3604   6.83 11.02
#> Abschwung            3.66 -0.0034   1.67  6.84
#> Unterer Wendepunkt   2.62 -1.9393  -1.49  9.61
#> 
#> Coefficients of linear discriminants:
#>             LD1      LD2     LD3
#> CP91JW   0.1583 -0.52094  0.0758
#> IAU91JW -0.1409  0.06865 -0.0275
#> IB91JW  -0.0478  0.00242 -0.0457
#> GM1JW   -0.0203  0.08559  0.2245
#> 
#> Proportion of trace:
#>   LD1   LD2   LD3 
#> 0.645 0.230 0.125

ldaer <- mean( (predict(klasslda)$class != B3$PHASEN) )
ldaer
#> [1] 0.414
```
Im Bezug auf die *Klassifikation* scheint der Baum in der Anpassungsgüte besser als die Lineare Diskriminanzanalyse zu sein. Aber wie sieht es kreuzvalidiert, d. h. in der Prognose aus?


Zunächst wird wieder dafür ein Aufteilungsvektor gebildet:

```r
aufteilung <- rep(1:3, length.out=nrow(B3))
```
und dann wird aufgeteilt:

```r
test1 <- B3[aufteilung==1,]
train1 <- B3[aufteilung!=1,]

test2 <- B3[aufteilung==2,]
train2 <- B3[aufteilung!=2,]

test3 <- B3[aufteilung==3,]
train3 <- B3[aufteilung!=3,]
```


```r
# Runde 1
b1 <- rpart(PHASEN  ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train1)
l1 <- lda(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train1)
erb1 <- mean( (predict(b1, newdata = test1, type = "class") != test1$PHASEN) )
erl1 <- mean( (predict(l1, newdata = test1)$class  != test1$PHASEN) )

# Runde 2
b2 <- rpart(PHASEN  ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train2)
l2 <- lda(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train2)
erb2 <- mean( (predict(b2, newdata = test2, type = "class") != test2$PHASEN) )
erl2 <- mean( (predict(l2, newdata = test2)$class  != test2$PHASEN) )

# Runde 3
b3 <- rpart(PHASEN  ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train3)
l3 <- lda(PHASEN ~ CP91JW + IAU91JW + IB91JW + GM1JW, data=train3)
erb3 <- mean( (predict(b3, newdata = test3, type = "class") != test3$PHASEN) )
erl3 <- mean( (predict(l3, newdata = test3)$class  != test3$PHASEN) )

# Ergebnisse zusammenfassen
ercvb <- c(erb1, erb2, erb3)
ercvl <- c(erl1, erl2, erl3)

# Mittelwert des Prognose MSE
mean(ercvb)
#> [1] 0.49
mean(ercvl)
#> [1] 0.44
```
In der *Prognosegüte* ist hier -- anders als in der Anpassungsgüte -- die Lineare Diskriminanzanalyse besser.



### Parameter `rpart` 
Neben dem Splitkrierium können verschiedene Parameter des Algorithmus eingestellt werden (siehe `?rpart.control`), u. a.:

- minsplit: Minimale Anzahl Beobachtungen im Knoten damit Aufteilung versucht wird
- minbucket: Minimale Anzahl Beobachtungen im Blatt
- cp: Komplexitätsparameter (pruning)
- xval: Anzahl Kreuzvaliderungen (pruning)
- maxdepth: Maximale Tiefe eines Blattes

Diese können mit der Funktion `train` aus dem Paket [`caret`](https://topepo.github.io/caret/index.html) automatisch optimiert werden.

Alternativen/ Ergänzungen zu `rpart`: 

- [`tree`](https://cran.r-project.org/web/packages/tree/)
- [`partykit`](http://partykit.r-forge.r-project.org/partykit/)
- Erweiterung: Viele Bäume: [`randomForest`](https://cran.r-project.org/web/packages/randomForest/) 

