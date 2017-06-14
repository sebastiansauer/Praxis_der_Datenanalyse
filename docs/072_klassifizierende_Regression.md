

# Klassifizierende Regression


<img src="images/FOM.jpg" width="30%" style="display: block; margin: auto;" />

<img src="images/licence.png" width="10%" style="display: block; margin: auto;" />


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Lernziele:

- Die Idee der logistischen Regression verstehen.
- Die Koeffizienten der logistischen Regression interpretieren können.
- Die Modellgüte einer logistischten Regression einschätzen können.
- Klassifikatorische Kennzahlen kennen und beurteilen können.

</div>\EndKnitrBlock{rmdcaution}



Für dieses Kapitel benötigen Sie folgende Pakete:

```r
library(SDMTools)  # Güte von Klassifikationsmodellen
library(pROC)  # für ROC- und AUC-Berechnung
library(tidyverse)  # Datenjudo
library(BaylorEdPsych)  # Pseudo-R-Quadrat
```




## Vorbereitung
Hier werden wir den Datensatz *Aktienkauf* der Universität Zürich ([Universität Zürich, Methodenberatung](http://www.methodenberatung.uzh.ch/de/datenanalyse/zusammenhaenge/lreg.html)) analysieren. Es handelt es sich  um eine finanzpsychologische Fragestellung. Es wurde untersucht, welche Variablen mit der Wahrscheinlichkeit, dass jemand Aktien erwirbt, zusammenhängen. Insgesamt wurden 700 Personen befragt. Folgende Daten wurden erhoben: 

- Aktienkauf (0 = nein, 1 = ja)
- Jahreseinkommen (in Tausend CHF), 
- Risikobereitschaft (Skala von 0 bis 25) 
- Interesse an der aktuellen Marktlage (Skala von 0 bis 45).


Importieren Sie zunächst die Daten.


```r
Aktien <- readr::read_csv("data/Aktien.csv") %>% na.omit
```

Um uns das Leben leichter zu machen, haben wir fehlende Werte (`NA`s) mit `na.omit` gelöscht.


## Problemstellung
Können wir anhand der Risikobereitschaft abschätzen, ob die Wahrscheinlichkeit für einen Aktienkauf steigt? Schauen wir uns zunächst ein Streudiagramm an (Abb. \@ref(fig:fig-logist-regr1)).


```r
p1 <- ggplot(aes(y = Aktienkauf, x = Risikobereitschaft), data = Aktien) + geom_point()
p1
```

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/fig-logist-regr1-1.png" alt="Streudiagramm von Risikobereitschaft und Aktienkauf" width="70%" />
<p class="caption">(\#fig:fig-logist-regr1)Streudiagramm von Risikobereitschaft und Aktienkauf</p>
</div>

Berechnen wir dann eine normale Regression.


```r
lm1 <- lm(Aktienkauf ~ Risikobereitschaft, data = Aktien)
summary(lm1)
#> 
#> Call:
#> lm(formula = Aktienkauf ~ Risikobereitschaft, data = Aktien)
#> 
#> Residuals:
#>    Min     1Q Median     3Q    Max 
#> -0.684 -0.243 -0.204  0.348  0.814 
#> 
#> Coefficients:
#>                    Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         0.18246    0.02001    9.12  < 2e-16 ***
#> Risikobereitschaft  0.05083    0.00762    6.67  5.2e-11 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.427 on 698 degrees of freedom
#> Multiple R-squared:  0.0599,	Adjusted R-squared:  0.0586 
#> F-statistic: 44.5 on 1 and 698 DF,  p-value: 5.25e-11
```


Der Zusammenhang scheint nicht sehr ausgeprägt zu sein. Lassen Sie uns dennoch ein lineare Regression durchführen und das Ergebnis auswerten und graphisch darstellen.


```r

p1 + geom_abline(intercept = .18, slope = .05, color = "red")

```

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/fig-logist-regr2-1.png" alt="Regressionsgerade für Aktien-Modell" width="70%" />
<p class="caption">(\#fig:fig-logist-regr2)Regressionsgerade für Aktien-Modell</p>
</div>

Der Schätzer für die Steigung für `Risikobereitschaft` ist signifikant. Das Bestimmtheitsmaß $R^2$ ist allerdings sehr niedrig, aber wir haben bisher ja auch nur eine unabhängige Variable für die Erklärung der abhängigen Variable herangezogen.

Doch was bedeutet es, dass die Wahrscheinlichkeit ab einer Risikobereitsschaft von ca. 16 über 1 liegt?

Wahrscheinlichkeiten müssen zwischen 0 und 1 liegen. Daher brauchen wir eine Funktion, die das Ergebnis einer linearen Regression in einen Bereich von 0 bis 1 "umbiegt" (die sogenannte *Linkfunktion*). Eine häufig dafür verwendete Funktion ist die *logistische Funktion*\index{logistische Funktion}. Im einfachsten Fall:

$$p(y=1)=\frac{e^x}{1+e^x}$$



Exemplarisch können wir die logistische Funktion für einen Bereich von $\eta=-10$ bis $+10$ darstellen (vgl. \@ref(fig:logist-curve)). Der Graph der  logistischen Funktion ähnelt einem langgestreckten S ("Ogive" genannt).

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/logist-curve-1.png" alt="Die logistische Regression beschreibt eine 's-förmige' Kurve" width="70%" />
<p class="caption">(\#fig:logist-curve)Die logistische Regression beschreibt eine 's-förmige' Kurve</p>
</div>


## Die Idee der logistischen Regression
Die logistische Regression ist eine Anwendung des *Allgemeinen Linearen Modells*\index{Allgemeines Lineares Modells} (general linear model, GLM). Die Modellgleichung lautet:

$p(y_i=1)=L\bigl(\beta_0+\beta_1\cdot x_{i1}+\dots+\beta_K\cdot x_{ik}\bigr)+\epsilon_i$

- $L$ ist die Linkfunktion, in unserer Anwendung die logistische Funktion.  
- $x_{ik}$ sind die beobachten Werte der unabhängigen Variablen $X_k$.  
- $k$ sind die unabhängigen Variablen $1$ bis $K$.

Die Funktion `glm` führt die logistische Regression durch. 

```r
glm1 <- glm(Aktienkauf ~ Risikobereitschaft, 
            family = binomial("logit"),
            data = Aktien)
```

Wir schauen uns zunächst den Plot an (Abb. \@ref(fig:aktien-plot).

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/aktien-plot-1.png" alt="Modelldiagramm für den Aktien-Datensatz" width="70%" />
<p class="caption">(\#fig:aktien-plot)Modelldiagramm für den Aktien-Datensatz</p>
</div>


> Es werden ein Streudiagramm der beobachten Werte sowie die *Regressionslinie* ausgegeben. Wir können so z. B. ablesen, dass ab einer Risikobereitschaft von etwa 7 die Wahrscheinlichkeit für einen Aktienkauf nach unserem Modell bei mehr als 50 % liegt.

Die Zusammenfassung des Modells zeigt folgendes:


```r
summary(glm1)
#> 
#> Call:
#> glm(formula = Aktienkauf ~ Risikobereitschaft, family = binomial("logit"), 
#>     data = Aktien)
#> 
#> Deviance Residuals: 
#>    Min      1Q  Median      3Q     Max  
#> -1.653  -0.738  -0.677   0.825   1.823  
#> 
#> Coefficients:
#>                    Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)         -1.4689     0.1184   -12.4  < 2e-16 ***
#> Risikobereitschaft   0.2573     0.0468     5.5  3.8e-08 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 804.36  on 699  degrees of freedom
#> Residual deviance: 765.86  on 698  degrees of freedom
#> AIC: 769.9
#> 
#> Number of Fisher Scoring iterations: 4
```

Die p-Werte der Koeffizienten können in der Spalte `Pr(>|z|)` abgelesen werden. Der Achsenabschnitt (`intercept`) wird mit -1.47 geschätzt, die Steigung in Richtung `Risikobereitschaft` mit 0.26. Allerdings sind die hier dargestellten Werte sogenannte *Logits*\index{Logit} $\mathfrak{L}$^[ein schnödes L wie in Ludwig]:


$\mathfrak{L} = ln\left( \frac{p}{1-p} \right)$

Zugeben, dass klingt erstmal opaque. Das Praktische ist, dass wir die Koeffizienten in Logistform in gewohnter Manier verrechnen dürfen. Wollen wir zum Beispiel wissen, welche Wahrscheinlichkeit für Aktienkauf eine Person mit einer Risikobereitschaft von 3 hat, können wir einfach rechnen:

`y = intercept + 3*Risikobereitschaft`, also


```r
(y <- -1.469 + 3 * 0.257)
#> [1] -0.698
```


Einfach, oder? Genau wie bei der normalen Regression. Aber beachten Sie, dass das Ergebnis in *Logits*\index{Logit} angegeben ist. Was ein Logit ist? Naja, das ist der Logarithmus der Chancen; unter 'Chancen'\index{Chancen} versteht man den Quotienten von Wahrscheinlichkeit $p$ zur Gegenwahrscheinlichkeit $1-p$; die Chancen werden auch *Odds*\index{Odds} oder *Wettquotient* genant. 

Um zur 'normalen' Wahrscheinlichkeit zu kommen, muss man also erst 'delogarithmieren'. Delogarithmieren bedeutet, die e-Funktion anzuwenden, `exp` auf Errisch:


```r
exp(y)
#> [1] 0.498
```
Jetzt haben wir wir also Chancen. Wie rechnet man Chancen in Wahrscheinlichkeiten um? Ein Beispiel zur Illustration. Bei Prof. Schnaggeldi fallen von 10 Studenten 9 durch. Die Durchfall*chance* ist also 9:1 oder 9. Die Durchfall*wahrscheinlichkeit* 9/10 oder .9. Also kann man so umrechnen:

`wskt = 9 / (9+1) = 9/10 = .9`.

In unserem Fall sind die Chancen 0.322; also lautet die Umrechnung:


```r
(wskt <- .498 / (.498+1))
#> [1] 0.332
```

Diesen Ritt kann man sich merklich kommoder bereiten, wenn man diesen Befehl kennt:


```r
predict(glm1, newdata = data.frame(Risikobereitschaft = 3), type = "response")
#>     1 
#> 0.332
```




## Kein $R^2$, dafür AIC
Es gibt kein $R^2$ im Sinne einer erklärten Streuung der $y$-Werte, da die beobachteten $y$-Werte nur $0$ oder $1$ annehmen können. Das Gütemaß bei der logistischen Regression ist das *Akaike Information Criterion* (*AIC*). Hier gilt allerdings: je *kleiner*, desto *besser*. (Anmerkung: es kann ein Pseudo-$R^2$ berechnet werden -- kommt später.) Richtlinien, was ein "guter" AIC-Wert ist, gibt es nicht. Diese Werte helfen nur beim Vergleichen von Modellen.



## Interpretation der Koeffizienten

Ist ein Logit $\mathfrak{L}$ größer als $0$, so ist die zugehörige Wahrscheinlichkeit größer als 50% (und umgekehrt.)

### y-Achsenabschnitt (`Intercept`) $\beta_0$ 

Für $\beta_0>0$ gilt, dass selbst wenn alle anderen unabhängigen Variablen $0$ sind, es eine Wahrscheinlichkeit von mehr als 50% gibt, dass das modellierte Ereignis eintritt. Für $\beta_0<0$ gilt entsprechend das Umgekehrte.

### Steigung $\beta_i$ mit $i=1,2,...,K$
Für $\beta_i>0$ gilt, dass mit zunehmenden $x_i$ die Wahrscheinlichkeit für das modellierte Ereignis steigt. Bei $\beta_i<0$ nimmt die Wahrscheinlichkeit entsprechend ab.



### Aufgabe

Berechnen Sie den Zuwachs an Wahrscheinlichkeit für unser Beispielmodell, wenn sich die `Risikobereitschaft` von 1 auf 2 erhöht. Vergleichen Sie das Ergebnis mit der Punktprognose für `Risikobereitschaft `$=7$ im Vergleich zu `Risikobereitschaft `$=8$. 


Lösung:



```r
# aus Koeffizient abgeschätzt
wskt1 <- predict(glm1, data.frame(Risikobereitschaft = 1), type = "response")

wskt2 <- predict(glm1, data.frame(Risikobereitschaft = 2), type = "response")

wskt2 - wskt1
#>      1 
#> 0.0486
```

Anders gesagt: "Mit jedem Punkt mehr Risikobereitschaft steigt der Logit (die logarithmierten Chancen) für Aktienkauf um 0.257".



```r

# mit dem vollständigen Modell berechnet
predict(glm1, data.frame(Risikobereitschaft = 1), 
        type = "response")
#>     1 
#> 0.229

predict(glm1, data.frame(Risikobereitschaft = 8), 
        type = "response")
#>     1 
#> 0.643
```

Bei einer Risikobereitschaft von 7 beträgt die Wahrscheinlichkeit für $y=1$, d.h. für das Ereignis "Aktienkauf", 0.58. Bei einer Risikobereitschaft von 8 liegt diese Wahrscheinlichkeit bei 0.64.



## Kategoriale Prädiktoren
Wie in der linearen Regression können auch in der logistschen Regression kategoriale Variablen als unabhängige Variablen genutzt werden. 

Betrachten wir als Beispiel die Frage, ob die kategoriale Variable "Interessiert" (genauer: dichotome Variable) einen Einfluss auf das Bestehen in der Klausur hat, also die Wahrscheinlichkeit für Bestehen erhöht.


```r
stats_test <- read.csv("data/test_inf_short.csv")

stats_test$interessiert <- stats_test$interest > 3
```


Zunächst ein Plot (Abb. \@ref(fig:jitter-stats-logist)).


```r

stats_test %>% 
  na.omit %>% 
  ggplot() +
  aes(x = interessiert, y = bestanden) +
  geom_jitter(width = .1)
```

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/jjitter-stats-logist-1.png" alt="Verwackeltes Streudiagramm ('Jitter')" width="70%" />
<p class="caption">(\#fig:jjitter-stats-logist)Verwackeltes Streudiagramm ('Jitter')</p>
</div>

Eine Sache sollten wir noch ändern: Auf der Y-Achse (`bestanden`) steht unten "ja" und oben "nein". Für unsere logistische Regression macht es aber genau anders herum Sinn: `bestanden=="ja") soll oben stehen. `bestanden` ist eine Variable vom Typ 'Faktor':


```r
str(stats_test$bestanden)
#>  Factor w/ 2 levels "ja","nein": 1 1 1 2 1 1 1 2 1 1 ...
```

Wir sehen, dass `bestanden` offenbar zwei Stufen hat ("ja" und "nein"). Die Reihenfolge der Stufen können wir so ändern:


```r
stats_test$bestanden <- factor(stats_test$bestanden, levels = c("nein", "ja"))
```

Die neue Reihenfolge ist nicht nur optisch ansprechender, sondern auch für die logistische Regression sinnvoll: R berechnet die Wahrscheinlichkeit für die zweite Stufe (also die "obere" auf der Y-Achse); für R entspricht die erste Stufe 0 und die zweite Stufe 1. Außerdem sollten Achsen stets von wenig (nichts/nein) zu viel (ja) gehen.


Los geht's, probieren wir die logistische Regression aus:


```r
log_stats <- glm(bestanden ~ interessiert, 
               family = binomial("logit"),
               data = stats_test)
summary(log_stats)
#> 
#> Call:
#> glm(formula = bestanden ~ interessiert, family = binomial("logit"), 
#>     data = stats_test)
#> 
#> Deviance Residuals: 
#>    Min      1Q  Median      3Q     Max  
#> -2.034   0.520   0.520   0.633   0.633  
#> 
#> Coefficients:
#>                  Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)         1.504      0.217    6.94    4e-12 ***
#> interessiertTRUE    0.430      0.377    1.14     0.25    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 209.02  on 237  degrees of freedom
#> Residual deviance: 207.68  on 236  degrees of freedom
#>   (68 observations deleted due to missingness)
#> AIC: 211.7
#> 
#> Number of Fisher Scoring iterations: 4
```

Der Einflusswert (die Steigung) von `interessiert` ist positiv: Wenn man interessiert ist, steigt die Wahrscheinlichkeit zu bestehen. Gut. Aber wie groß ist die Wahrscheinlichkeit für jede Gruppe? Am einfachsten lässt man sich das von R ausrechnen:


```r
predict(log_stats, newdata = data.frame(interessiert = FALSE), 
        type = "response")
#>     1 
#> 0.818
predict(log_stats, newdata = data.frame(interessiert = TRUE), 
        type = "response")
#>     1 
#> 0.874
```

Also 82% bzw. 87%; kein gewaltig großer Unterschied.





## Multiple logistische Regression
Wir kehren wieder zurück zu dem Datensatz *Aktienkauf*. Können wir unser Model `glm1` mit nur einer erklärenden Variable verbessern, indem weitere unabhängige Variablen hinzugefügt werden?



```r
glm2 <- glm(Aktienkauf ~ Risikobereitschaft + Einkommen + Interesse, 
            family = binomial("logit"), 
            data = Aktien)

summary(glm2)
#> 
#> Call:
#> glm(formula = Aktienkauf ~ Risikobereitschaft + Einkommen + Interesse, 
#>     family = binomial("logit"), data = Aktien)
#> 
#> Deviance Residuals: 
#>    Min      1Q  Median      3Q     Max  
#> -2.130  -0.715  -0.539   0.518   3.214  
#> 
#> Coefficients:
#>                    Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)        -1.66791    0.27903   -5.98  2.3e-09 ***
#> Risikobereitschaft  0.34781    0.08822    3.94  8.1e-05 ***
#> Einkommen          -0.02157    0.00564   -3.83  0.00013 ***
#> Interesse           0.08520    0.01775    4.80  1.6e-06 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 804.36  on 699  degrees of freedom
#> Residual deviance: 679.01  on 696  degrees of freedom
#> AIC: 687
#> 
#> Number of Fisher Scoring iterations: 5
```



Alle Schätzer sind signifkant zum 0.1 %-Niveau (`***` in der Ausgabe). Zunehmende Risikobereitschaft (der Einfluss ist im Vergleich zum einfachen Modell stärker geworden) und zunehmendes Interesse erhöhen die Wahrscheinlichkeit für einen Aktienkauf. Steigendes Einkommen hingegen senkt die Wahrscheinlichkeit.


## Modellgüte

Aber wie gut ist das Modell? Und welches Modell von beiden ist besser? R hat uns kein $R^2$ ausgegeben. R hat uns deswegen kein $R^2$ ausgegeben, weil die Regressionsfunktion nicht über Abweichungsquadrate bestimmt wird. Stattdessen wird das Maximum Likelihood-Verfahren eingesetzt. Man kann also kein $R^2$ ausrechnen, zumindest nicht ohne Tricks. Einige findige Statistiker haben sich aber Umrechungswege einfallen lassen, wie man auch ohne Abweichungsquadrate ein $R^2$ berechnen kann; weil es kein 'echtes' $R^2$ ist, nennt man es auch *Pseudo-*$R^2$.

Eine Reihe von R-Paketen bieten die Berechnung a:


```r
library(BaylorEdPsych)
PseudoR2(glm1)
PseudoR2(glm2)
```

Die Ausgabe zeigt uns, dass `glm2` die Daten besser erklärt als `glm1`.




## Klassifikationskennzahlen

### Vier Arten von Ergebnissen einer Klassifikation
Logistische Regressionsmodelle werden häufig zur *Klassifikation*\index{Klassifikation} verwendet. Das heißt man versucht, Beobachtungen richtig zu zu Klassen zuzuordnen:

- Ein medizinischer Test soll Kranke als krank und Gesunde als gesund klassifizieren.
- Ein statistischer Test sollte wahre Hypothesen als wahr und falsche Hypothesen als falsch klassifizieren.
- Ein Personaler sollte geeignte Bewerber als geeignet und nicht geeignete Bewerber als nicht geeignet einstufen.

Diese beiden Arten von Klassifikationen können unterschiedlich gut sein. Im Extremfall könnte ein Test alle Menschen als krank ('positiv') einstufen. Mit Sicherheit wurden dann alle Kranken korrekt als krank diagnostiziert. Dummerweise würde der Test 'auf der anderen Seite' viele Fehler machen: Gesunde als gesund ('negativ') zu klassifizieren.

>   Ein Test, der alle positiven Fälle korrekt als positiv klassifiziert muss deshalb noch lange nicht alle negativen Fälle als negativ klassifizieren. Die beiden Werte können unterschiedlich sein.

Etwas genauer kann man folgende vier Arten von Ergebnisse aus einem  Test erwarten (s. Tabelle \@ref(tab:class-stats)).


Table: (\#tab:class-stats)Vier Arten von Ergebnisse von Klassfikationen

Wahrheit                  Als negativ (-) vorhergesagt   Als positiv (+) vorhergesagt   Summe 
------------------------  -----------------------------  -----------------------------  ------
In Wahrheit negativ (-)   Richtig negativ (RN)           Falsch positiv (FP)            N     
In Wahrheit positiv (+)   Falsch negativ (FN)            Richtig positiv (RN)           P     
Summe                     N*                             P*                             N+P   


Die logistische Regression gibt uns für jeden Fall eine Wahrscheinlichkeit zurück, dass der Fall zum Ereignis $1$ gehört. Wir müssen dann einen Schwellenwert (threshold) auswählen. Einen Wert also, der bestimmt, ob der Fall zum Ereignis $1$ gehört. Häufigt nimmt man  $0.5$. Liegt die Wahrscheinlichkeit unter dem Schwellenwert, so ordnet man den Fall dem Ereignis $0$ zu. 

Beispiel: Alois' Wahrscheinlichkeit, die Klausur zu bestehen, wird vom Regressionsmodell auf 51% geschätzt. Unser Schwellenwert sei 50%; wir ordnen Alois der Klasse "bestehen" zu. Alois freut sich. Das Modell sagt also "bestehen" ($1$) für Alois voraus. Man sagt auch, der 'geschätzte Wert' (*fitted value*) von Alois sei $1$. 

Die aus dem Modell ermittelten Wahrscheinlichkeiten werden dann in einer sogenannten Konfusionsmatrix\index{Konfusionsmatrix} (*confusion matrix*) mit den beobachteten Häufigkeiten verglichen:


```r
(cm <- confusion.matrix(Aktien$Aktienkauf, glm1$fitted.values)) 
#>     obs
#> pred   0   1
#>    0 509 163
#>    1   8  20
#> attr(,"class")
#> [1] "confusion.matrix"
```

Dabei stehen `obs` (observed) für die wahren, also tatsächlich beobachteten Werte und `pred` (predicted) für die geschätzten (vorhergesagten) Werte.

Wie häufig hat unser Modell richtig geschätzt? Genauer: Wie viele echte $1$ hat unser Modell als $1$ vorausgesagt und wie viele echte $0$ hat unser Modell als $0$ vorausgesagt?

### Klassifikationsgütekennzahlen

In der Literatur und Praxis herrscht eine recht wilde Vielfalt an Begriffen dazu, deswegen stellt Tabelle \@ref(tab:class-stats) einen Überblick vor.


Table: (\#tab:diag-stats)Geläufige Kennwerte der Klassifikation

Name                             Definition        Synonyme                                           
-------------------------------  ----------------  ---------------------------------------------------
Falsch-Positiv-Rate (FP-Rate)    FP/N              Alphafehler, Typ-1-Fehler, 1-Spezifität, Fehlalarm 
Richtig-Positiv-Rate (RP-Rate)   RP/N              Power, Sensitivität, 1-Betafehler, Recall          
Falsch-Negativ-Rate (FN-Rate)    FN/N              Fehlender Alarm, Befafehler                        
Richtig-Negativ-Rate (RN-Rate)   RN/N              Spezifität, 1-Alphafehler                          
Positiver Vorhersagewert         RP/P*             Präzision, Relevanz                                
Negativer Vorhersagewert         RN/N*             Segreganz                                          
Gesamtgenauigkeitsrate           (RP+RN) / (N+P)   Richtigkeit, Korrektklassifikationsrate            

Zu beachten ist, dass die Gesamtgenauigkeit einer Klassifikation an sich wenig aussagekräftig ist: Ist eine Krankheit sehr selten, werde ich durch die einfache Strategie "diagnostiziere alle als gesund" insgesamt kaum Fehler machen. Meine Gesamtgenauigkeit wird beeindruckend genau sein - trotzdem lassen Sie sich davon wohl kaum beeindrucken. Besser ist, die Richtig-Positiv- und die Richtig-Negativ-Raten getrennt zu beurteilen. Aus dieser Kombination leitet sich der *Youden-Index* ab.\index{Youden-Index}. Er berechnet sich als: `RP-Rate + RN-Rate - 1`.

Sie können die Konfusionsmatrix mit dem Paket `confusion.matrix()` aus dem Paket `SDMTools` berechnen.



```r
sensitivity(cm)
#> [1] 0.109
specificity(cm)
#> [1] 0.985
```


Wir haben die Aktienkäufer ($1$) also nur schlecht identifiziert; die Nichtkäufer ($0$) haben wir hingegen fast alle gefunden.

Wir könnten jetzt sagen, dass wir im Zweifel lieber eine Person als Käufer einschätzen (um ja keinen Kunden zu verlieren). Dazu würden wir den Schwellenwert (threshold) von 50% auf z.B. 30%$ herabsetzen:


```r
(cm <- confusion.matrix(Aktien$Aktienkauf, glm1$fitted.values, threshold = .3))
#>     obs
#> pred   0   1
#>    0 440 128
#>    1  77  55
#> attr(,"class")
#> [1] "confusion.matrix"
sensitivity(cm)
#> [1] 0.301
specificity(cm)
#> [1] 0.851
```


### ROC-Kurven
Siehe da! Die Sensitivität ist gestiegen, wir haben mehr Käufer als solche identifiziert. Unsere liberalere Strategie hat aber mehr falsch-positive Fälle produziert. So können wir jetzt viele verschiedene Schwellenwerte vergleichen. 


>   Ein Test ist dann gut, wenn wir für alle möglichen Schwellenwert ingesamt wenig Fehler produziert.




Hierzu wird der Cutpoint zwischen 0 und 1 variiert und die Richtig-Positiv-Rate (Sensitivität) gegen die Falsch-Positiv-Rate ($1-$Spezifität) abgetragen. Das Paket `pROC` hilft uns hier weiter. Zuerst berechnen wir für viele verschiedene Schwellenwerte jeweils die beiden Fehler (Falsch-Positiv-Rate und Falsch-Negativ-Rate). Trägt man diese in ein Daigramm ab, so bekommt man Abbildung \@ref(fig:roc-stats), eine sog. *ROC-Kurve*\index{ROC}.


```r
lets_roc <- roc(Aktien$Aktienkauf, glm1$fitted.values)
```

Da die Sensitivität determiniert ist, wenn die Falsch-Positiv-Rate bekannt ist (1 - FP-Rate), kann man statt Sensitivität auch die FP-Rate abbilden. Für die Spezifität und die Falsch-Negativ-Rate gilt das gleiche. In Abbildung \@ref(fig:roc-stats) steht auf der X-Achse Spezifität, aber die Achse ist 'rückwärts' (absteigend) skaliert, so dass die X-Achse identisch ist mit FP-Rate (normal skaliert; d.h. aufsteigend).



```r
plot(lets_roc)
```

<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/roc-stats-1.png" alt="Eine ROC-Kurve" width="70%" />
<p class="caption">(\#fig:roc-stats)Eine ROC-Kurve</p>
</div>


Die 'Fläche unter der Kurve' (area under curve, AUC) is damit ein Maß für die Güte des Tests. Abbildung \@ref(fig:example-rocs) stellt drei Beispiele von Klassifikationsgüten dar: sehr gute (A), gute (B) und schlechte (C). Ein hohe Klassifikationsgüte zeigt sich daran, dass eine hohe Richtig-Positiv-Rate mit einer kleinen Fehlalarmquote einher geht: Wir finden alle Kranken, aber nur die Kranken. Die AUC-Kurve "hängt oben links an der Decke". Ein schlechter Klassifikator trifft so gut wie ein Münzwurf: Ist das Ereignis selten, hat er eine hohe Falsch-Positiv-Rate und eine geringe Falsch-Negativ-Rate. Ist das Ereignis hingegen häufig, liegen die Fehlerhöhen genau umgekehrt: Eine hohe Richtig-Positiv-Rate wird mit einer hoher Falsch-Positiv-Rate einher.


<div class="figure" style="text-align: center">
<img src="072_klassifizierende_Regression_files/figure-html/example-rocs-1.png" alt="Beispiel für eine sehr gute (A), gute (B) und schlechte (C) Klassifikation" width="70%" />
<p class="caption">(\#fig:example-rocs)Beispiel für eine sehr gute (A), gute (B) und schlechte (C) Klassifikation</p>
</div>


Fragt sich noch, wie man den besten Schwellenwert herausfindet. Den besten Schwellenwert kann man als besten Youden-Index-Wert verstehen. Im Paket `pROC` gibt es dafür den Befehl `coords`, der uns im ROC-Diagramm die Koordinaten des besten Schwellenwert und den Wert dieses besten Schwellenwerts liefert:


```r
coords(lets_roc, "best")
#>   threshold specificity sensitivity 
#>       0.229       0.603       0.623
```




## Aufgaben^[R, R, R, R, F, R, R]


\BeginKnitrBlock{rmdexercises}<div class="rmdexercises">Richtig oder Falsch!?

1. Die logistische Regression ist eine Regression für dichotome Kriterien.

1. Unter einer ~~Olive~~Ogive versteht man eine eine "s-förmige" Kurve.

1. Berechnet man eine "normale" (OLS-)Regression bei einem dichotomen Kriterium, so kann man Wahrscheinlichkeiten < 0 oder > 1 erhalten, was keinen Sinn macht.

1. Ein Logit ist definiert als der Einfluss eines Prädiktors in der logistischen Regression. Der Koeffizient berechnet sich als Logarithmus des Wettquotienten.

1. Das AIC ein Gütemaß, welches man bei der logistischten Regression generell vermeidet.

1. Eine Klassifikation kann 4 Arten von Ergebnissen bringen - gemessen an der Richtigkeit des Ergebnisses.

1. Der 'positive Vorhersagewert'  ist definiert als der Anteil aller richtig-positiven Klassifikationen an allen als positiv klassifizierten Objekten. 
</div>\EndKnitrBlock{rmdexercises}




## Befehlsübersicht


Tabelle \@ref(tab:befehle-logist-regression) stellt die Befehle dieses Kapitels dar. 



-------------------------------------------------------------
Paket..Funktion              Beschreibung                    
---------------------------- --------------------------------
ggplot2::geom_abline         Fügt das Geom "abline"          
                             (normale Gerade) zu einem       
                             ggplot2-Plot hinzu              

glm                          Berechnet ein "generalisiertes  
                             lineares Modell", z.B. eine     
                             logistische Regression          

exp                          Berechnet die e-Funktion für    
                             den angegeben Ausdruck          
                             (synonym: "delogarithmiert"     
                             den Ausdruck)                   

SDMTools::confusion.matrix   Berechnet eine                  
                             Konfusionsmatrix                

SDMTools::sensitivity        Berechnet die Sensitivität      
                             eines Klassifikationsmodells    

SDMTools::specificity        Berechnet die Spezifität eines  
                             Klassifikationsmodells          

ROCR::performance            Erstellt Objekte mit            
                             Gütekennzahlen von              
                             Klassifikationsmodellen         

lmtest::lrtest               Berechnet den                   
                             Likelihood-Ratio-Test           

BaylorEdPsych::PseudoR2      Berechnet                       
                             Pseudo-R-Quadrat-Werte          
-------------------------------------------------------------

Table: Befehle des Kapitels 'Logistische Regression'



