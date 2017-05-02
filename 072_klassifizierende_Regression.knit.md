

# Klassifizierende Regression


<img src="images/FOM.jpg" width="30%" style="display: block; margin: auto;" />

<img src="images/licence.png" width="10%" style="display: block; margin: auto;" />


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Lernziele:

- Die Idee der logistischen Regression verstehen.
- Die Koeffizienten der logistischen Regression interpretieren können.
- Vertiefungen wie Modellgüte kennen.

</div>\EndKnitrBlock{rmdcaution}



Für dieses Kapitel benötigen Sie folgende Pakete:

```r
library(SDMTools)
library(ROCR)
```




## Vorbereitung
Hier werden wir den Datensatz *Aktienkauf* der Universität Zürich ([Universität Zürich, Methodenberatung](http://www.methodenberatung.uzh.ch/de/datenanalyse/zusammenhaenge/lreg.html)) analysieren. Es handelt es sich  um eine finanzpsychologische Fragestellung. Es wurde untersucht, welche Variablen mit der Wahrscheinlichkeit, dass jemand Aktien erwirbt, zusammenhängen. Insgesamt wurden 700 Personen befragt. Folgende Daten wurden erhoben: 

- Aktienkauf (0 = nein, 1 = ja)
- Jahreseinkommen (in Tausend CHF), 
- Risikobereitschaft (Skala von 0 bis 25) 
- Interesse an der aktuellen Marktlage (Skala von 0 bis 45).

Importieren Sie zunächst die Daten.


```r
Aktien <- read.csv("data/Aktien.csv")
```


## Problemstellung
Können wir anhand der Risikobereitschaft abschätzen, ob die Wahrscheinlichkeit für einen Aktienkauf steigt? Schauen wir uns zunächst ein Streudiagramm an (Abb. \@ref(fig:logist-regr1)).









































