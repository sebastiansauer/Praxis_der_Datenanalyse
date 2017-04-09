

\pagenumbering{arabic}

# I EXPLORIEREN {-}



# Rahmen

In diesem Skript geht es um die Praxis der Datenanalyse. Mit Rahmen ist das 
"Drumherum" oder der Kontext der eigentlichen Datenanalyse gemeint. Dazu gehören
einige praktische Vorbereitungen und ein paar Überlegungen. Zum Beispiel 
brauchen wir einen Überblick über das Thema. Voilà:

<img src="images/Prozess_Datenanalyse.pdf" width="70%" style="display: block; margin: auto;" />


Datenanalyse, praktisch betrachtet, kann man in fünf Schritte einteilen [@r4ds].
Zuerst muss man die Daten *einlesen*, die Daten also in R (oder einer anderen 
Software) verfügbar machen (laden). Fügen wir hinzu: In *schöner Form* verfügbar
machen; man nennt dies auch *tidy data*[hört sich cooler an.]. Sobald die Daten in geeigneter 
Form in R geladen sind, folgt das *Aufbereiten*. Das beinhaltet Zusammenfassen, 
Umformen oder Anreichern je nach Bedarf. Ein nächster wesentlicher Schritt ist 
das *Visualisieren* der Daten. Ein Bild sagt bekanntlich mehr als viele Worte. 
Schließlich folgt das *Modellieren* oder das Hypothesen prüfen: Man überlegt 
sich, wie sich die Daten erklären lassen könnten. Zu beachten ist, dass diese 
drei Schritte - Aufbereiten, Visualisieren, Modellieren - keine starre Abfolge 
sind, sondern eher ein munteres Hin-und-Her-Springen, ein aufbauendes 
Abwechseln. Der letzte Schritt ist das *Kommunizieren* der Ergebnisse der 
Analyse - nicht der Daten. Niemand ist an Zahlenwüsten interessiert; es gilt, 
spannende Einblicke zu vermitteln.

Der Prozess der Datenanalyse vollzieht sich nicht im luftleeren Raum, sondern 
ist in einem *Rahmen* eingebettet. Dieser beinhaltet praktische Aspekte - wie 
Software, Datensätze - und grundsätzliche Überlegungen - wie Ziele und 
Grundannahmen.




## Software installieren


Als Haupt-Analysewerkzeug nutzen wir R; daneben wird uns die sog. 
"Entwicklungsumgebung" RStudio einiges an komfortabler Funktionalität bescheren.
Eine Reihe von R-Paketen ("Packages"; d.h. Erweiterungen) werden wir auch 
nutzen. R ist eine recht alte Sprache; viele Neuerungen finden in Paketen 
Niederschlag, da der "harte Kern" von R lieber nicht so stark geändert wird. 
Stellen Sie sich vor: Seit 29 Jahren nutzen Sie eine Befehl, der Ihnen einen 
Mittelwert ausrechnet, sagen wir die mittlere Anzahl von Tassen Kaffee am Tag. 
Und auf einmal wird der Mittelwert anders berechnet?! Eine Welt stürzt ein! 
Naja, vielleicht nicht ganz so tragisch in dem Beispiel, aber grundsätzlich sind
Änderungen in viel benutzen Befehlen potenziell problematisch. Das ist wohl ein 
Grund, warum sich am "R-Kern" nicht so viel ändert. Die Innovationen in R 
passieren in den Paketen. Und es gibt viele davon; als ich diese Zeilen 
schreibe, sind es fast schon 10.000! Genauer: 9937 nach dieser Quelle: 
<https://cran.r-project.org/web/packages/>.


### R und RStudio installieren


Setzt natürlich voraus, dass R installiert ist. Sie können R unter 
<https://cran.r-project.org> herunterladen und installieren (für Windows, Mac 
oder Linux). RStudio finden Sie auf der gleichnamigen Homepage: 
<https://www.rstudio.com>; laden Sie die "Desktop-Version" für Ihr 
Betriebssystem herunter.

Die Oberfläche von R, die "Console", sieht so aus:

<!-- ![](images/R-small.jpg) ![](images/R-Mac-small.png) -->




Die Oberfläche von RStudio sieht (unter allen Betriebssystemen etwa gleich) so 
aus:

<img src="images/RStudio-Screenshot.png" width="70%" style="display: block; margin: auto;" />


Das *Skript-Fenster*\index{Skript-Fenster} ähnelt einem normalem Text-Editor; 
praktischerweise finden Sie aber einen Button "run", der 
die aktuelle Zeile oder die Auswahl "abschickt", d.h. in die 
Konsole gibt, wo die Syntax ausgeführt wird. Wenn Sie ein Skript-Fenster
öffnen möchten, so können Sie das Icon ![new_script](images/new_script.png) 
klicken^[Alternativ: Cntrl-Shift-N oder File > New File > R Script].

Aus dem Fenster der *Konsole*\index{Konsole} spricht R zu uns bzw. 
wir mit ihm (ihr?). Wird ein Befehl hier eingegeben, so führt R ihn aus. 
Es ist aber viel praktischer, Befehle in das Skript-Fenster einzugeben, als in
die Konsole. Behalten Sie dieses Fenster im Blick, wenn Sie Antwort von R erwarten.

Im Fenster *Umgebung*\index{Umgebung} (engl. "environment") zeigt R, 
welche Variablen (Objekte) vorhanden sind. Stellen Sie sich die Umgebung wie einen
Karpfenteich vor, in dem die Datensätze und andere Objekte herumschwimmen. Was nicht
in der Umgebung angezeigt wird, existiert nicht für R.

Im Fenster rechts unten werden mehrere Informationen bereit gestellt, z.B. 
werden Diagramme (Plots) dort ausgegeben. Klicken Sie mal die anderen Reiter im Fenster
rechts unten durch.


Wer Shortcuts mag, wird in RStudio überschwänglich beschenkt; der Shortcut für die Shortcuts ist `Shift-Alt-K`.


### Hilfe! R tut nicht so wie ich das will

>    Manntje, Manntje, Timpe Te,   
    Buttje, Buttje inne See,    
    myne Fru de Ilsebill    
    will nich so, as ik wol will. 


*Gebrüder Grimm, Märchen vom Fischer und seiner Frau^[<https://de.wikipedia.org/wiki/Vom_Fischer_und_seiner_Frau>]*




Ihr R startet nicht oder nicht richtig? Die drei wichtigsten Heilmittel sind:

1. Schließen Sie die Augen für eine Minute. Denken Sie an etwas Schönes und was 
Rs Problem sein könnte. 
2. Schalten Sie den Rechner aus und probieren Sie es 
morgen noch einmal. 
3. Googeln.

Sorry für die schnoddrigen Tipps. Aber: Es passiert allzu leicht, dass man 
Fehler wie diese macht:

- `install.packages(dplyr)` 
- `install.packages("dliar")`
- `install.packages("derpyler")` 
- `install.packages("dplyr")  # dependencies vergessen` 
- Keine Internet-Verbindung 
- `library(dplyr)  # ohne vorher zu installieren`


Wenn R oder RStudio dann immer noch nicht starten oder nicht richtig laufen, 
probieren Sie dieses:


- Sehen Sie eine Fehlermeldung, die von einem fehlenden Paket spricht (z.B. 
"Package 'Rcpp' not available") oder davon spricht, dass ein Paket nicht 
installiert werden konnte (z.B. "Package 'Rcpp' could not be installed" oder "es
gibt kein Paket namens ‘Rcpp’" oder "unable to move temporary installation XXX 
to YYY"), dann tun Sie folgendes:

    - Schließen Sie R und starten Sie es neu. 
    - Installieren Sie das oder die angesprochenen Pakete mit `install.packages("name_des_pakets", dependencies = TRUE)` oder mit dem entsprechenden Klick in RStudio. 
    - Starten Sie das entsprechende Paket mit `library(paket_name)`.


- Gerade bei Windows 10 scheinen die Schreibrechte für R (und damit RStudio oder
RCommander) eingeschränkt zu sein. Ohne Schreibrechte kann R aber nicht die 
Pakete ("packages") installieren, die Sie für bestimmte R-Funktionen benötigen. 
Daher schließen Sie R bzw. RStudio und suchen Sie das Icon von R oder wenn Sie 
RStudio verwenden von RStudio. Rechtsklicken Sie das Icon und wählen Sie "als 
Administrator ausführen". Damit geben Sie dem Programm Schreibrechte. Jetzt 
können Sie etwaige fehlende Pakete installieren.

- Ein weiterer Grund, warum R bzw. RStudio die Schreibrechte verwehrt werden 
könnten (und damit die Installation von Paketen), ist ein Virenscanner. Der 
Virenscanner sagt, nicht ganz zu Unrecht: "Moment, einfach hier Software zu 
installieren, das geht nicht, zu gefährlich". Grundsätzlich gut, in diesem Fall 
unnötig. Schließen Sie R/RStudio und schalten Sie dann den Virenscanner 
*komplett* (!) aus. Öffnen Sie dann R/RStudio wieder und versuchen Sie fehlende 
Pakete zu installieren.



### Hier werden Sie geholfen

Es ist keine Schande, nicht alle Befehle der ca. 10,000 R-Pakete auswendig zu 
wissen. Schlauer ist, zu wissen, wo man Antworten findet. Hier eine Auswahl:

- Zu diesen Paketen gibt es gute "Spickzettel" (cheatsheets): ggplot2, 
RMarkdown, dplyr, tidyr. Klicken Sie dazu in RStudio auf *Help > Cheatsheets > 
...* oder gehen Sie auf <https://www.rstudio.com/resources/cheatsheets/>.

- In RStudio gibt es eine Reihe (viele) von Tastaturkürzeln (Shortcuts), die Sie
hier finden: *Tools > Keyboard Shortcuts Help*.

- Für jeden Befehl (d.i. Funktion) können Sie mit `?` Hilfe erhalten; probieren 
Sie z.B. `?mean`.

- Im Internet finden sich zuhauf Tutorials.

- Die bekannteste Seite, um Fragen rund um R zu diskutieren ist: 
http://stackoverflow.com.





### Die Denk- und Gefühlswelt von R

- Wenn Sie RStudio starten, startet R automatisch auch. Starten Sie daher, wenn 
Sie RStudio gestartet haben, *nicht* noch extra R. Damit hätten Sie sonst zwei 
Instanzen von R laufen, was zu Verwirrungen (bei R und beim Nutzer) führen kann.

#### R-Skript-Dateien

- Ein neues *R-Skript*\index{R-Skript} im RStudio können Sie z.B. öffnen mit `File-New File-R Script`. Schreiben Sie dort Ihre R-Befehle; Sie können die Skriptdatei speichern, öffnen, ausdrucken, übers Bett hängen...

- R-Skripte können Sie speichern (`File-Save`) und öffnen.

- R-Skripte sind einfache Textdateien, die jeder Texteditor verarbeiten kann. 
Nur statt der Endung `.txt`, sind R-Skripte stolzer Träger der Endung `.R`. Es 
bleibt aber eine schnöde Textdatei. Geben Sie Ihren R-Skript-Dateien die Endung ".R",
damit erkennt RStudio, dass es sich um ein R-Skript handelt und bietet ein paar 
praktische Funktionen wie den "Run-Button".


#### Stolpersteine beim Errisch lernen

>    I Errr, therefore I am...


Verwenden Sie möglichst die neueste Version von R, RStudio und Ihres 
Betriebssystems. Ältere Versionen führen u.U. zu Problemen; je älter, desto 
Problem... Updaten Sie Ihre Packages regelmäßig z.B. mit `update.packages()` 
oder dem Button "Update" bei RStudio (Reiter `Packages`).

R zu lernen kann hart sein. Ich weiß, wovon ich spreche. Wahrscheinlich eine 
spirituelle Prüfung in Geduld und Hartnäckigkeit... Tolle Gelegenheit, sich in 
diesen Tugenden zu trainieren :-)





### Pakete installieren

Ein R-Paket, welches für die praktische Datenanalyse praktisch ist, heißt 
`dplyr`. Wir werden viel mit diesem Paket arbeiten. Bitte installieren Sie es 
schon einmal, sofern noch nicht geschehen:


```r
install.packages("dplyr", dependencies = TRUE) 
```




\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Beim Installieren von 
R-Paketen könnten Sie gefragt werden, welchen "Mirror" Sie verwenden möchten. 
Das hat folgenden Hintergrund: R-Pakete sind in einer Art "App-Store", mit Namen
CRAN (Comprehense R Archive Network) gespeichert. Damit nicht ein armer, kleiner
Server überlastet wird, wenn alle Studis dieser Welt just gerade beschließen, 
ein Paket herunterzuladen, gibt es viele Kopien dieses Servers - die "Mirrors", 
Spiegelbilder. Suchen Sie sich einfach einen aus, der in der Nähe ist.
</div>\EndKnitrBlock{rmdcaution}


Bei der Installation von Paketen mit `install.packages("name_des_pakets")` 
sollte stets der Parameter `dependencies = TRUE` angefügt werden. Also 
`install.packages("name_des_pakets", dependencies = TRUE)`. Hintergrund ist: 
Falls das zu installierende Paket seinerseits Pakete benötigt, die noch nicht 
installiert sind (gut möglich), dann werden diese sog. "dependencies" gleich 
mitinstalliert (wenn Sie  `dependencies = TRUE` setzen).


Sie müssen online sein, um Packages zu installieren.

Nicht vergessen: Installieren muss man eine Software *nur einmal*; *starten* 
(laden) muss man sie jedes Mal, wenn man sie vorher geschlossen hat und wieder 
nutzen möchte:


```r
library(dplyr) 
```

Der Befehl bedeutet sinngemäß: "Hey R, geh in die Bücherei (library) und hole 
das Buch (package) dplyr!".


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Wann benutzt man bei R Anführungszeichen? Das ist etwas verwirrend im Detail, aber die Grundegel 
lautet: wenn man Text anspricht. Im Beispiel oben "library(dplyr)" ist "dplyr" 
hier erst mal für R nichts Bekanntes, weil noch nicht geladen. Demnach müssten 
*eigentlich* Anführungsstriche stehen. Allerdings meinte ein Programmierer, dass
es doch so bequemer ist. Hat er Recht. Aber bedenken Sie, dass es sich um die 
Ausnahme einer Regel handelt. Sie können also auch schreiben: library("dplyr") 
oder library('dplyr'); geht beides.
</div>\EndKnitrBlock{rmdcaution}



Das Installieren und Starten anderer Pakete läuft genauso ab. Am besten 
installieren Sie alle Pakete, die wir in diesem Buch benötigen auf einmal, dann 
haben Sie Ruhe.



### R-Pakete für dieses Buch 

In diesem Buch verwenden wir die folgenden 
R-Pakete; diese müssen installiert^[Ggf. benötigen Sie Administrator-Rechte, um Pakete zu installieren. Virenscanner müssen evtl. ausgestaltet sein.] sein und geladen:





```r
Pakete 
#>  [1] "tidyverse"     "readr"         "knitr"         "stringr"      
#>  [5] "car"           "nycflights13"  "ISLR"          "pdftools"     
#>  [9] "downloader"    "ggdendro"      "gridExtra"     "tm"           
#> [13] "tidytext"      "lsa"           "SnowballC"     "wordcloud"    
#> [17] "RColorBrewer"  "okcupiddata"   "reshape2"      "wesanderson"  
#> [21] "GGally"        "titanic"       "compute.es"    "corrr"        
#> [25] "rpart"         "rpart.plot"    "MASS"          "titanic"      
#> [29] "arules"        "arulesViz"     "SDMTools"      "corrplot"     
#> [33] "gplots"        "corrplot"      "scatterplot3d" "BaylorEdPsych"
#> [37] "nFactors"      "rmarkdown"     "methods"
```

Anstelle alle einzeln zu laden (`library` verdaut nur ein Paket auf einmal), 
können wir mit etwas R-Judo alle auf einen Haps laden:


```r
lapply(Pakete, require, character.only = TRUE) 
```







Der Befehl heißt auf Deutsch: "Wende auf jedes Element von `Pakete` den Befehl 
`library` an"^[http://stackoverflow.com/questions/8175912/load-multiple-packages-at-once].

Hin und wieder ist es sinnvoll, die Pakete auf den neuesten Stand zu bringen; 
das geht mit `update.packages()`.





### Datensätze


- Datensatz `profiles` aus dem R-Paket {okcupiddata} [@kim2015okcupid]; es handelt sich um Daten von einer Online-Singlebörse 
- Datensatz `Wage` aus dem R-Paket {ISLR} [@introstatlearning]; es handelt sich um Gehaltsdaten von US-amerikanischen Männern 
- Datensatz `inf_test_short`, hier herunterzuladen: <osf.io/sjhu> [@Sauer_2017]; es handelt sich um Ergebnisse einer Statistikklausur 
- Datensatz `flights` aus dem R-Paket {nycflights13} [@nycflights13]; es handelt sich um Abflüge von den New Yorker Flughäfen 
- Datensatz 'wo_men`, hier herunterzuladen: <osf.io/ja9dw> [@Sauer_2017a]; es handelt sich um Körper- und Schuhgröße von Studierenden
- Datensatz `tips` aus dem R-Paket {reshape2} [@bryant1995practical]; es handelt sich um Trinkgelder in einem Restaurant 
- Datensatz `extra`, hier herunterzuladen: <osf.io/4kgzh> [@Sauer_2016]; es handelt sich die Ergebnisse einer Umfrage zu Extraversion


Wir verwenden zwei Methoden, um Datensätze in R zu laden.

- Zum einen laden wir Datensätze aus R-Paketen, z.B. aus dem Paket 
`okcupiddata`. Dazu muss das entsprechende Paket installiert und geladen sein. 
Mit dem Befehl `data(name_des_datensatzes, package = "name_des_paketes")`, kann 
man dann die Daten laden. Das Laden eines Pakets lädt noch *nicht* die Daten des
Paketes; dafür ist der Befehl `data` zuständig.


```r
library(okcupiddata) data(profiles, package = "okcupiddata")
```


- Alternativ kann man die Daten als CSV- oder als XLS(X)-Datei importieren. Die 
Datei darf dabei sowohl auf einer Webseite als auch lokal (Festplatte, Stick...) 
liegen.


```r
Daten <- read.csv("https://sebastiansauer.github.io/data/tips.csv") 
```

Wir werden mit beiden Methoden arbeiten und "on the job" Details besprechen.






### Übungen

1. Öffnen Sie das Cheatsheet für RStudio und machen Sie sich mit dem Cheatsheet vertraut.

2. Sichten Sie kurz die übrigen Cheatsheets; später werden die Ihnen vielleicht von Nutzen sein.






## ERRRstkontakt


### Hinweise


Unser erster Kontakt mit R! Ein paar Anmerkungen vorweg:

- R unterscheidet zwischen Groß- und Kleinbuchstaben, d.h. `Oma` und `oma` sind 
zwei verschiedene Dinge für R!
- R verwendet den Punkt `.` als 
Dezimaltrennzeichen.
- Fehlende Werte werden in R durch `NA` kodiert.
- Kommentare werden mit dem Rautezeichen `#` eingeleitet; der Rest der Zeile von von R dann ignoriert. 
- Hilfe zu einem Befehl erhält man über ein vorgestelltes Fragezeichen `?`.
- Zusätzliche Funktionalität kann über Zusatzpakete hinzugeladen werden. Diese 
müssen ggf. zunächst installiert werden.
- *Variablennamen*\index{Variablen} (synonym: *Objekte*\index{Objekte}) in R müssen mit Buchstaben beginnen; ansonsten dürfen nur Zahlen, Unterstriche `-` und Minuszeichen `-` enthalten sein. Leerzeichen sind nicht erlaubt.
- Variablen einen Namen zu geben, ist nicht leicht, aber wichtig. Namen sollten knapp, aber aussagekräftig sein.

```
# so nicht:
var
x
dummy
objekt
dieser_name_ist_etwas_lang_vielleicht

# gut:
tips_mw
lm1
```

Um den Inhalt einer Variablen auszulesen, geben wir einfach den Namen des Objekts ein (und schicken den Befehl ab).

### R als Taschenrechner

Auch wenn Statistik nicht Mathe ist, so kann man mit R 
auch rechnen. Geben Sie zum Üben die Befehle in der R Konsole hinter der 
Eingabeaufforderung `>` ein und beenden Sie die Eingabe mit `Return` bzw. 
`Enter`. 


```r
4+2 
#> [1] 6
```
Das Ergebnis wird direkt angezeigt. Bei 

```r
x <- 4+2 
```

erscheint zunächst kein Ergebnis. Über `<-` wird der Variable `x` der Wert 
`4+2` zugewiesen. Wenn Sie jetzt 

```r
x 
```

eingeben, wird das 
Ergebnis 

```
#> [1] 6
```

angezeigt. Sie können jetzt auch mit `x` 
weiterrechnen, z.B.: 


```r
x/4 
#> [1] 1.5
```

Vielleicht fragen Sie sich was die `[1]` vor dem 
Ergebnis bedeutet. R arbeitet vektororientiert, und die `[1]` zeigt an, dass es 
sich um das erste (und hier auch letzte) Element des Vektors handelt.


### Text und Variablen zuweisen

Man kann einer Variablen auch Text zuweisen (im Gegensatz zu Zahlen):


```r
y <- "Hallo R!"
```


Man kann auch einer Variablen eine andere zuweisen:


```r
y <- x
```

Wird jetzt y mit dem Inhalt von x überschrieben oder umgekehrt? Der Zuweisungspfeil `<-` macht die Richtung der Zuweisung ganz klar. Zwar ist in R das Gleichheitszeichen synonym zum Zuweisungspfeil erlaubt, aber der Zuweisungspfeil macht die Sache glasklar und sollte daher bevorzugt werden.


### Funktionen aufrufen


Um einen "Befehl" (präziser: eine Funktion) aufzurufen, geben wir ihren Namen an
und definieren sog. "Parameter" in einer runden Klammer, z.B. so:


```r
wo_men <- read.csv("data/wo_men.csv")
```

Allgemein gesprochen:

```
funktionsname(parametername1 = wert1, parametername2 = wert2, ...)
```

Die drei Punkte `...` sollen andeuten, dass evtl. weitere Parameter zu übergeben wären. 
Die Reihenfolge der Parameter ist egal - wenn man die Parameternamen anführt. 
Ansonsten muss man sich an die Standard-Reihenfolge, die eine Funktion vorgibt halten:


```r
#ok:
wo_men <- read.csv(file = "data/wo_men.csv", header = TRUE, sep = ",")
wo_men <- read.csv("data/wo_men.csv", TRUE, ",")
wo_men <- read.csv(header = TRUE, sep = ",", file = "data/wo_men.csv")


# ohno:
wo_men <- read.csv(TRUE, "data/wo_men.csv", ",")
```


### Übungen 

3. Führen Sie diese Syntax aus:


```r
meine_coole_variable <- 10
meine_coole_var1able 
```

Woher rührt der Fehler?

4. Korrigieren Sie die Syntax:


```r
install.packages(dplyer)
```


`y <- Hallo R!`


`Hallo R <- 1`



```r
Hallo_R < - 1
```


## Was ist Statistik? Wozu ist sie gut?

Zwei Fragen bieten sich sich am Anfang der Beschäftigung mit jedem Thema an: Was
ist die Essenz des Themas? Warum ist das Thema (oder die Beschäftigung damit) 
wichtig?

Was ist Statistik? *Eine* Antwort dazu ist, dass Statistik die Wissenschaft von
Sammlung, Analyse, Interpretation und Kommunikation von Daten ist mithilfe 
mathematischer Verfahren ist und zur Entscheidungshilfe beitragen solle 
[@oxford; @sep-statistics]. Damit hätten wir auch den Unterschied zur schnöden 
Datenanalyse (ein Teil der Statistik) herausgemeißelt. Statistik wird häufig in 
die zwei Gebiete *deskriptive* und *inferierende* Statistik eingeteilt. Erstere 
fasst viele Zahlen zusammen, so dass wir den Wald statt vieler Bäume sehen. 
Letztere verallgemeinert von den vorliegenden (sog. "Stichproben-")Daten auf 
eine zugrunde liegende Grundmenge (Population). Dabei spielt die 
Wahrscheinlichkeitsrechnung (Stochastik) eine große 
Rolle.


Aufgabe der deskriptiven Statistik ist es primär, Daten prägnant 
zusammenzufassen. Aufgabe der Inferenzstatistik ist es, zu prüfen, ob Daten 
einer Stichprobe auf eine Grundgesamtheit verallgemeinert werden können.


Dabei lässt sich der Begriff "Statistik" als Überbegriff von "Datenanalyse" 
verstehen, wenn diese Sicht auch nicht von allen geteilt wird 
[@grolemund2014cognitive]. In diesem Buch steht die Aufbereitung, Analyse, 
Interpretation und Kommunikation von Daten im Vordergrund. Liegt der Schwerpunkt
dieser Aktivitäten bei computerintensiven Methoden, so wird auch von *Data 
Science* gesprochen, wobei der Begriff nicht einheitlich verwendet wird [@r4ds;
@hardin2015data]

*Daten* kann man definieren als *Informationen, die in einem Kontext stehen*
[@moore1990uncertainty], wobei eine numerische Konnotation mitschwingt.

*Modellieren* kann man als *zentrale Aufgabe von Statistik* begreifen 
[@cobb2007introductory; @grolemund2014cognitive]. Einfach gesprochen, bedeutet 
Modellieren in diesem Sinne, ein mathematisches Narrativ ("Geschichte") zu 
finden, welches als Erklärung für gewisse Muster in den Daten fungiert; vgl. 
Kap. \@ref{mod1}.

Statistisches Modellieren läuft gewöhnlich nach folgendem Muster ab [@grolemund2014cognitive]:


```
Prämisse 1: Wenn Modell M wahr ist, dann sollten die Daten das Muster D aufweisen.
Prämisse 2: Die Daten weisen das Muster D auf.

---

Konklusion: Daher muss das Modell M wahr sein.
```

Die Konklusion ist *nicht* zwangsläufig richtig. Es ist falsch zu sagen, dass dieses Argumentationsmuster - Abduktion [@peirce1955abduction] genannt - wahre, sichere Schlüsse (Konklusionen) liefert. Die Konklusion *kann, muss aber nicht*, zutreffen.

Ein Beispiel: Auf dem Nachhauseweg eines langen Arbeitstags wartet, in einer dunklen Ecke, ein Mann, der sich als Statistik-Professor vorstellt und Sie zu einem Glücksspiel einlädt. Sofort sagen Sie zu. Der Statistiker will 10 Mal eine Münze werfen, er setzt auf Zahl (versteht sich). Wenn er gewinnt, bekommt er 10€ von Ihnen; gewinnen Sie, bekommen Sie 11€ von ihm. Hört sich gut an, oder? Nun wirft er die Münze zehn Mal. Was passiert? Er gewinnt 10 Mal, natürlich (so will es die Geschichte). Sollten wir glauben, dass er ein Betrüger ist?

Ein Modell, welches wir hier verwenden könnten, lautet: Wenn die Münze gezinkt ist (Modell M zutrifft), dann wäre diese Datenlage D (10 von 10 Treffern) wahrscheinlich - Prämisse 1. Datenlage D ist tatsächlich der Fall; der Statistiker hat 10 von 10 Treffer erzielt - Prämisse 2. Die Daten D "passen" also zum Modell M; man entscheidet sich, dass der Professor ein Falschspieler ist. 

Wichtig zu erkennen ist, dass Abduktion mit dem Wörtchen *wenn* beginnt. Also davon *ausgeht*, dass ein Modell M der Fall ist (der Professor also tatsächlich ein Betrüger ist). Dass, worüber wir entscheiden wollen, wird also bereits vorausgesetzt. Gilt also M, wie gut passen dann die Daten dazu? 

>    Wie gut passen die Daten D zum Modell M?

Das ist die Frage, die hier tatsächlich gestellt bzw. beantwortet wird.

Natürlich ist es keineswegs sicher, *dass* das Modell gilt. Darüber macht die Abduktion auch keine Aussage. Es könnte also sein, dass ein anderes Modell zutrifft: Der Professor könnte ein Heiliger sein, der uns auf etwas merkwürdige Art versucht, Geld zuzuschanzen... Oder er hat einfach Glück gehabt.

>   Statistische Modelle beantworten i.d.R. nicht, wie wahrsheinlich es ist, dass ein Modell gilt. Statistische Modelle beurteilen, wie gut Daten zu einem Modell passen.

Häufig trifft ein Modell eine Reihe von Annahmen, die nicht immer explizit gemacht werden, aber die klar sein sollten. Z.B. sind die Münzwürfe unabhängig voneinander? Oder kann es sein, dass sich die Münze "einschießt" auf eine Seite? Dann wären die Münzwürfe nicht unabhängig voneinander. In diesem Fall klingt das reichlich unplausibel; in anderen Fällen kann dies eher der Fall sein[^447]. Auch wenn die Münzwürfe unabhängig voneinander sind, ist die Wahrscheinlichkeit für Zahl jedes Mal gleich? Hier ist es wiederum unwahrscheinlich, dass sich die Münze verändert, ihre Masse verlagert, so dass eine Seite Unwucht bekommt. In anderen Situationen können sich Untersuchungsobjekte verändern (Menschen lernen manchmal etwas, sagt man), so dass die Wahrscheinlichkeiten für ein Ereignis unterschiedlich sein können, man dies aber nicht berücksichtigt. 


## Verweise

- Chester Ismay erläutert einige Grundlagen von R und RStudio, die für 
Datenanalyse hilfreich sind: https://bookdown.org/chesterismay/rbasics/.

- Roger Peng und Kollegen bieten hier einen Einstieg in Data Science mit R: 
https://bookdown.org/rdpeng/artofdatascience/

- Wickam und Grolemund [-@r4ds] geben einen hervorragenden Überblick in das 
Thema dieses Buches; ihr Buch ist sehr zu empfehlen.

- Wer einen stärker an der Statistik orientierten Zugang sucht, aber 
"mathematisch sanft" behandelt werden möchte, wird bei James et al. 
[-@introstatlearning] glücklich oder zumindest fündig werden.




## Versionshinweise


```r
sessionInfo() 
#> R version 3.3.2 (2016-10-31)
#> Platform: x86_64-apple-darwin13.4.0 (64-bit)
#> Running under: macOS Sierra 10.12.3
#> 
#> locale:
#> [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#> 
#> attached base packages:
#> [1] grid      methods   stats     graphics  grDevices utils     datasets 
#> [8] base     
#> 
#> other attached packages:
#>  [1] rmarkdown_1.3        nFactors_2.3.3       lattice_0.20-34     
#>  [4] boot_1.3-18          psych_1.6.12         BaylorEdPsych_0.5   
#>  [7] scatterplot3d_0.3-38 gplots_3.0.1         corrplot_0.77       
#> [10] SDMTools_1.1-221     arulesViz_1.2-0      arules_1.5-0        
#> [13] Matrix_1.2-8         MASS_7.3-45          rpart.plot_2.1.1    
#> [16] rpart_4.1-10         corrr_0.2.1          compute.es_0.2-4    
#> [19] titanic_0.1.0        GGally_1.3.0         wesanderson_0.3.2   
#> [22] reshape2_1.4.2       okcupiddata_0.1.0    wordcloud_2.5       
#> [25] RColorBrewer_1.1-2   lsa_0.73.1           SnowballC_0.5.1     
#> [28] tidytext_0.1.2       tm_0.6-2             NLP_0.1-10          
#> [31] gridExtra_2.2.1      ggdendro_0.1-20      downloader_0.4      
#> [34] pdftools_1.0         ISLR_1.0             nycflights13_0.2.2  
#> [37] car_2.1-4            stringr_1.2.0        knitr_1.15.1        
#> [40] dplyr_0.5.0          purrr_0.2.2.9000     readr_1.0.0         
#> [43] tidyr_0.6.1          tibble_1.2           ggplot2_2.2.1       
#> [46] tidyverse_1.1.1     
#> 
#> loaded via a namespace (and not attached):
#>  [1] minqa_1.2.4         colorspace_1.3-2    class_7.3-14       
#>  [4] modeltools_0.2-21   mclust_5.2.2        rprojroot_1.2      
#>  [7] base64enc_0.1-3     MatrixModels_0.4-1  DT_0.2             
#> [10] flexmix_2.3-13      mvtnorm_1.0-5       lubridate_1.6.0    
#> [13] xml2_1.1.1          R.methodsS3_1.7.1   codetools_0.2-15   
#> [16] splines_3.3.2       mnormt_1.5-5        robustbase_0.92-7  
#> [19] jsonlite_1.3        nloptr_1.0.4        pbkrtest_0.4-6     
#> [22] broom_0.4.2         kernlab_0.9-25      cluster_2.0.5      
#> [25] R.oo_1.21.0         httr_1.2.1          backports_1.0.5    
#> [28] assertthat_0.1      lazyeval_0.2.0.9000 htmltools_0.3.5    
#> [31] quantreg_5.29       tools_3.3.2         gtable_0.2.0       
#> [34] Rcpp_0.12.9         slam_0.1-40         trimcluster_0.1-2  
#> [37] gdata_2.17.0        nlme_3.1-130        iterators_1.0.8    
#> [40] fpc_2.1-10          lmtest_0.9-35       lme4_1.1-12        
#> [43] rvest_0.3.2         gtools_3.5.0        dendextend_1.4.0   
#> [46] DEoptimR_1.0-8      zoo_1.7-14          scales_0.4.1       
#> [49] TSP_1.1-5           hms_0.3             parallel_3.3.2     
#> [52] SparseM_1.74        yaml_2.1.14         reshape_0.8.6      
#> [55] stringi_1.1.2       gclus_1.3.1         tokenizers_0.1.4   
#> [58] foreach_1.4.3       seriation_1.2-1     caTools_1.17.1     
#> [61] prabclus_2.2-6      bitops_1.0-6        evaluate_0.10      
#> [64] htmlwidgets_0.8     plyr_1.8.4          magrittr_1.5       
#> [67] bookdown_0.3        R6_2.2.0            DBI_0.5-1          
#> [70] haven_1.0.0         whisker_0.3-2       foreign_0.8-67     
#> [73] mgcv_1.8-16         nnet_7.3-12         janeaustenr_0.1.4  
#> [76] modelr_0.1.0        KernSmooth_2.23-15  plotly_4.5.6       
#> [79] viridis_0.3.4       readxl_0.1.1        forcats_0.2.0      
#> [82] vcd_1.4-3           digest_0.6.12       diptest_0.75-7     
#> [85] R.utils_2.5.0       stats4_3.3.2        munsell_0.4.3      
#> [88] viridisLite_0.1.3   registry_0.3
```




[^447]: Sind z.B. die Prüfungsergebnisse von Schülern unabhängig voneinander? Möglicherweise haben sie von einem "Superschüler" abgeschrieben. Wenn der Superschüler viel weiß, dann zeigen die Abschreiber auch gute Leistung.
