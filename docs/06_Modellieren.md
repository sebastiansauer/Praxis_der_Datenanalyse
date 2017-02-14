



# Statistisches Modellieren



```r
library(tidyverse)
require(gridExtra)
```




## Was ist ein Modell? Was ist Modellieren? {#Modellieren}

Das Leben ist schwer... oder sagen wir: komplex. Um einen Ausschnitt der Wirklichkeit zu verstehen, erscheint es sinnvoll, sich einige als wesentlich erachteten Aspekte "herauszugreifen" bzw. auszusuchen und sich nur noch deren Zusammenspiel näher anzuschauen.

Manche Aspekte der Wirklichkeit[^1] sind wirklicher als andere. Interessiert man sich für den Zusammenhang von Temperatur und Grundwasserspiegel, so sind diese Dinge direkt beobachtbar. Interessiert man sich hingegen für Lebensqualität und Zufriedenheit, so muss man diese Untersuchungsgegenstände erst konstruieren. Sprechen wir daher von Wirklichkeit lieber vorsichtiger vom *Gegenstandsbereich*, also den (konstruierten) Auszug der Wirklichkeit, für den sich die forschende Person interessiert.

<div class="figure" style="text-align: center">
<img src="images/Modell.pdf" alt="Modellieren" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-2)Modellieren</p>
</div>


Damit verstehen wir Modellieren als eine typische Aktivität von Menschen [@9783497008957], genauer eines Menschen mit einem bestimmten Ziel. Wir können gar nicht anders, als nur ein Modell unserer Umwelt zu machen. Vielfältige Medien kommen dazu in Frage: Bilder, Geschichten, Logik, Gleichungen. Wir werden uns hier auf *numerische* Modelle konzentrieren, weil es dort am einfachsten ist, die Informationen herauszuziehen.



Schauen wir uns ein Beispiel aus der Datenanalyse an; laden Sie dazu zuerst den Datensatz `wo_men`.



<div class="figure" style="text-align: center">
<img src="06_Modellieren_files/figure-html/unnamed-chunk-4-1.png" alt="Ein Beispiel für Modellieren" width="90%" />
<p class="caption">(\#fig:unnamed-chunk-4)Ein Beispiel für Modellieren</p>
</div>


Im ersten Plot sehen wir - schon übersetzt in eine Datenvisualisierung - den Gegenstandsbereich. Dort sind einige Objekte zusammen mit ihren Relationen abgebildet (Gewicht vs. Körpergröße). Im zweiten Plot sehen wir ein (graphisches) Modell dazu. Noch ist das Modell recht unspezifisch; es wird nur postuliert, dass Körpergröße auf Schuhgröße einen Einfluss hat. Der rechte Plot spezifiziert nun diesen Einfluss: Es wird ein linearer Einfluss (eine Gerade) zwischen Größe und Schuhgröße unterstellt. 

>   Bei einem linearen Modell ist der Zuwachs der Ausgabevariablen konstant. Steigt eine Eingabevariable X um k, so steigt die Ausgabevariable ebenfalls um einen b*k, unabhängig vom Wert von X.



Ein etwas aufwändigeres Modell könnte so aussehen:

<div class="figure" style="text-align: center">
<img src="images/Modellieren_Bsp2.pdf" alt="Ein etwas aufwändigeres Modell" width="70%" />
<p class="caption">(\#fig:modell-bsp2)Ein etwas aufwändigeres Modell</p>
</div>


Allgemeiner formuliert, haben wir einen oder mehrere *Eingabegrößen*\index{Einflussgrößen} bzw. *Prädiktoren*\{Prädiktoren}, von denen wir annehmen, dass sie einen Einfluss haben auf genau eine *Zielgröße* (*Ausgabegröße*) bzw. *Kriterium*\index{Kriterium}. Modelle, wie wir sie betrachten werden, postulieren eine quantifizierbaren Zusammenhang zwischen diesen beiden Arten von Größen. Wir gehen dabei nicht davon aus, dass unsere Modelle perfekt sind, sondern dass Fehler passieren. Damit lassen sich unsere Modelle in drei Aspekte gliedern.

<div class="figure" style="text-align: center">
<img src="images/Modell_Blackbox.pdf" alt="Modelle mit schwarzer Kiste" width="70%" />
<p class="caption">(\#fig:fig-blackbox)Modelle mit schwarzer Kiste</p>
</div>


Die Einflussgrößen werden in einer "schwarzen Kiste", die wir hier noch nicht näher benennen, irgendwie verwurstet, will sagen, verrechnet, so dass ein *geschätzter* Wert für das Kriterium, eine *Vorhersage*  "hinten bei rauskommt". Mathematischer ausgedrückt:

$$Y = f(X) + \epsilon$$

Hier stehen $Y$ für das Kriterium, $X$ für den oder die Prädiktoren, $f$ für die "schwarze Kiste" und $\epsilon$ für den Fehler, den wir bei unserer Vorhersage begehen. Die schwarze Kiste könnte man auch als die "datengenerierende Maschine" bezeichnen.

Übrigens: Auf das Skalenniveau der Eingabe- bzw. Ausgabegrößen (qualitativ vs. quantitativ) kommt es hier nicht grundsätzlich an; es gibt Modelle für verschiedene Skalenniveaus bzw. Modelle, die recht anspruchslos sind hinsichtlich des Skalenniveaus (sowohl für Eingabe- als auch Ausgabegrößen). Was die Ausgabegröße (das Kriterium) betrifft, so "fühlen" qualitative Variablen von quantitativen Variablen anders an. Ein Beispiel zur Verdeutlichung: "Gehört Herr Bussi-Ness zur Gruppe der Verweigerer oder der Wichtigmacher?" (qualitatives Kriterium); "Wie hoch ist der Wichtigmacher-Score von Herrn Bussi-Ness?" (quantitatives Kriterium). Ein Modell mit qualitativem Kriterium bezeichnet man auch als *Klassifikation*\index{Klassifikation}; ein Modell mit quantitativem Kriterium bezeichnet man auch als *Regression*\index{Klassifikation}. Bei letzterem Begriff ist zu beachten, dass er *doppelt* verwendet wird. Neben der gerade genannten Bedeutung steht er auch für ein häufig verwendetes Modell - eigentlich das prototypische Modell - für quantitative Kriterien.


### Ziele des Modellierens
Man kann drei Arten von Zielen abgrenzen: Vorhersagen, Erklären und Reduzieren.

- *Vorhersagen*\index{Vorhersagen} hat das Ziel, eine geschickte Black Box zu wählen (oder eine Black Box geschickt zu wählen), so dass der Vohersagefehler möglichst klein ist. Sicherlich wird der Vorhersagefehler nie Null sein. Das Innenleben der "schwarzen Kiste" interessiert uns hier nicht.

- *Erklären*\index{Erklären} bedeutet, zu verstehen, *wie* oder *warum* sich der Kriteriumswert so verändert, wie er es tut. Auf *welche Art* werden die Prädiktoren verrechnet, so dass eine bestimmter Kriteriumswert resultiert? Welche Präditkoren sind dabei (besonders) wichtig?  Ist die Art der Verrechnung abhängig von den Werten der Prädiktoren? Hierbei interessiert uns vor allem die Beschaffenheit der schwarzen Kiste.

- *Reduzieren*\index{Reduzieren} meint, dass man die Fülle des Materials verringert, in dem man ähnliche Dinge zusammenfasst. Dabei kann man sowohl Observationen zusammen fassen ("Britta", "Carla" und "Dina" zu "Frau" und "Joachim", "Alois" und "Casper" zu "Mann") oder auch Variablen zusammen fassen ("Frage 1", "Frage 2" und "Frage 3" zu "Markentreue" etc.).


Vorhersagen und Erklären haben gemein, dass Eingabegrößen genutzt werden, um Aussagen über einen Ausgabegröße zu treffen. Hat man einen Datensatz, so kann man prüfen, *wie gut* das Modell funktionert, also wie genau man die Ausgabewerte vorhergesagt hat. Das ist also eine Art "Lernen mit Anleitung" oder *angeleitetes Lernen* oder *geleitetes Modellieren* (engl. *supervised learning*). Abbildung \@ref(fig: fig-blackbox) gibt diesen Fall wieder. Soll dem gegenüber das Ziel aber sein, die Daten zu reduzieren, also z.B. Kunden nach Persönlichkeit zu gruppieren, so ist die Lage anders. Es gibt keine Zielgröße. Wir wissen nicht, was die "wahre Kundengruppe" von Herrn Casper Bussi-Ness ist. Wir sagen eher, "OK, die drei Typen sind sich irgendwie ähnlich, sie werden wohl zum selben Typen von Kunden gehören". Wir tappen in Dunkeln, was die "Warheit" ist. Unser Modell muss ohne Hinweise darauf, was richtig ist auskommen. Man spricht daher in diesem Fall von *Lernen ohne Anleitung*\index{Lernen ohne Anleitung} oder *ungeleitetes Modellieren* (engl. *unsupervised learning*\index{unsupervised learning}).


### Parametrische Modelle vs. non-parametrische Modelle
Erklären wir das Innenleben der schwarzen Kiste genau, so spricht man von einem *parametrischen Modell*\index{parametrisches Modell}; spezifieren wir das Innenleben der schwarzen Kiste weniger genau, spricht man von einem *non-parametrischen Modell*\index{non-parametrischen Modell}[^2].


Ein Beispiel für ein einfaches parametrisches Modell ist:

>    Für je 5kg Körpergewicht steigt die Schuhgröße um 1 Nummer, wobei 50kg bei Schuhgröße 36 aufgehangen ist.

Warum spricht man hier von Parametern? Die Vorhersage der Schuhgröße kann anhand von einer Einflussgröße, die klar benannt ist (Körpergewicht), berechnet werden. Wie gut das Modell ist (wie präzise die Vorhersage ist), ist jetzt erstmal egal. Das Modell ist *sparsam*, sagt man, in seiner Formulierung.

Ein Beispiel für ein nicht-parametrisches Modell ist:

>    Wenn Körpergewicht 50.00-50.01 dann Schuhgröße 36.01  
     Wenn Körpergewicht 50.02-50.03 dann Schuhgröße 36.02  
     Wenn Körpergewicht 50.04-50.05 dann Schuhgröße 36.03  
     Wenn ...

Dieses Modell ist in gewisser Weise auch recht einfach aufgebaut (wenig Hirnschmalz ist zum Verstehen nötig), aber andererseits recht komplex, da viel Platz nötig ist, dass Modell komplett aufzuschreiben. Außerdem: das Modell müsste jede seiner Zeilen mal anhand von Daten ausprobiert haben, um zu der jeweiligen Vorhersage zu kommen. Dafür sind viele Daten nötig.



### Wann welches Modell?

Tja, mit dieser Frage lässt sich ein Gutteil des Kopfzerbrechens in diesem Metier erfassen. Die einfache Antwort lautet: Es gibt kein "bestes Modell", aber es mag für *einen bestimmten Gegenstandsbereich*, in *einem bestimmten (historisch-kulturellen) Kontext*, für *ein bestimmtes Ziel* und mit *einer bestimmten Stichprobe* ein best mögliches Modell geben. Dazu einige Eckpfeiler:

- Paramatrische Modelle sind häufig *sparsamer* als non-parametrische Modelle - hinsichtlich der Formulierung bzw. der Parameter und des Datenverbrauchs.

- Auch innerhalb der parametrischen bzw. non-parametrischen Modelle gibt es Unterschiede in der Sparsamkeit des Modells.

- Modelle mit weniger Parametern, also sparsame Modelle, sind grundsätzlich besser geeignet, wenn das Ziel *Erklären* ist. Wenn das Ziel *Vorhersagen* ist, so sollte man auch kompliziertere/ komplexe Modelle in Betracht ziehen.

- Man sollte stets mehrere Modelle vergleichen, um abzuschätzen, welches Modell in der aktuellen Situation geeigneter ist.



### Einfache vs. komplexe Modelle
Je komplexer ein Modell, desto besser passt sie meistens auf den Gegenstandsbereich. Eine grobe, holzschnittsartige Theorie ist doch schlechter als eine, die feine Nuancen berücksichtigt, oder nicht? Einiges spricht dafür; aber auch einiges dagegen. Schauen wir uns ein Problem mit komplexen Modellen an.



<div class="figure" style="text-align: center">
<img src="06_Modellieren_files/figure-html/unnamed-chunk-5-1.png" alt="Welches Modell passt am besten zu diesen Daten?" width="90%" />
<p class="caption">(\#fig:unnamed-chunk-5)Welches Modell passt am besten zu diesen Daten?</p>
</div>

Der 1. Plot (links) zeigt den Datensatz ohne Modell; der 2. Plot legt ein lineares Modell (Gerade) in die Daten. Der 3. Plot zeigt ein Modell, welches die Daten exakt erklärt - die Linie geht durch alle Punkte. Der 4. Plot zeigt ein Modell, welches die Punkte gut beschreibt, aber nicht exakt trifft.

Welchem Modell würden Sie (am meisten) vertrauen? Das "blaue" Modell beschreibt die Daten sehr gut, aber hat das Modell überhaupt eine "Idee" vom Gegenstandsbereich, eine "Ahnung", wie Y und X zusammenhängen, bzw. wie X einen Einfluss auf Y ausübt? Offenbar nicht. Das Modell ist "übergenau" oder zu komplex. Man spricht von *Überanpassung*\index{Überanpassung} (engl. *overfitting*\index{overfitting}). Das Modell scheint zufälliges, bedeutungsloses Rauschen zu ernst zu nehmen. Das Resultat ist eine zu wackelige Linie - ein schlechtes Modell, da wir wenig Anleitung haben, auf welche Y-Werte wir tippen müssten, wenn wir neue, unbekannte X-Werte bekämen.

Was das "blaue Modell" zu detailverliebt ist, ist das "rote Modell" zu simpel. Die Gerade beschreibt die Y-Werte nur sehr schlecht. Man hätte gleich den Mittelwert von Y als Schätzwert für jedes einzelne $Y_i$ hernehmen können. Dieses lineare Modell ist *unterangepasst*\index{Unteranpassung}, könnte man sagen (engl. *underfittting*\index{underfitting}). Auch dieses Modell wird uns wenig helfen können, wenn es darum geht, zukünftige Y-Werte vorherzusagen (gegeben jeweils einen bestimmten X-Wert).

Ah! Das *grüne Modell* scheint das Wesentliche, die "Essenz" der "Punktebewegung" zu erfassen. Nicht die Details, die kleinen Abweichungen, aber die "große Linie" scheint gut getroffen. Dieses Modell erscheint geeignet, zukünftige Werte gut zu beschreiben. Das grüne Modell ist damit ein Kompromiss aus Einfachheit und Komplexität und würde besonders passen, wenn es darum gehen sollte, zyklische Veränderungen zu erklären[^3].


### Training- vs. Test-Stichprobe
Wie wir gerade gesehen haben, kann man *immer* ein Modell finden, welches die *vorhandenen* Daten sehr gut beschreibt. Das gleicht der Tatsache, dass man im Nachhinein (also bei vorhandenen Daten) leicht eine Erklärung findet. Ob diese Erklärung sich in der Zukunft, bei unbekannten Daten bewahrheitet, steht auf einem ganz anderen Blatt. 

Daher sollte man *immer* sein Modell an einer Stichprobe *entwickeln* ("trainieren" oder "üben2) und an einer zweiten Stichprobe *testen*. Die erste Stichrpobe nennt man auch *training sample* (Training-Stichprobe) und die zweite *test sample* (Test-Stichprobe). Entscheidend ist, dass das Test-Sample beim Entwickeln des Modells unbekannt war.

>    Die Güte des Modells sollte nur anhand eines - bislang nicht verwendeten - Test-Samples überprüft werden. Das Test-Sample darf bis zur Modellüberprüfung nicht analysiert werden.


Die Modellgüte ist im Trainings-Sample meist deutlich besser als im Test-Sample.


```r
set.seed(42)
train <- wo_men %>% 
  sample_frac(.8, replace = FALSE)  # Stichprobe von 80%, ohne Zurücklegen

test <- wo_men %>% 
  anti_join(train)  # Alle Zeilen von "wo_men", die nicht in "train" vorkommen
```

Damit haben wir ein Trainings-Sample (`train`), in dem wir ein oder besser mehrere Modelle entwickeln können. Zur Beurteilung "wie gut" ein Modell ist, nehmen wir dann das Test-Sample (`test`). Dieses Vorgehen nennt man auch *Kreuz-Validierung*\index{Kreuz-Validierung} (engl. *cross validation*\index{cross validation}).

So schön wie dieses Vorgehen auch ist, es ist nicht perfekt. Ein Nachteil ist, dass unsere Modellgüte wohl *anders* wäre, hätten wir andere Fälle im Test-Sample erwischt. Würden wir also ein neues Trainings-Sample und ein neues Test-Sample aus diesen Datensatz ziehen, so hätten wir wohl andere Ergebnisse. Was wenn diese Ergebnisse nun deutlich von den ersten abweichen? Dann würde unser Vertrauen in die die Modellgüte sinken. Wir bräuchten also noch ein Verfahren, welches *Variabilität* in der Modellgüte widerspiegelt.












## Der p-Wert


<div class="figure" style="text-align: center">
<img src="images/Ronald_Fisher.jpg" alt="Der größte Statistiker des 20. Jahrhunderts (p &lt; .05)" width="10%" />
<p class="caption">(\#fig:unnamed-chunk-7)Der größte Statistiker des 20. Jahrhunderts (p < .05)</p>
</div>



Der p-Wert ist die heilige Kuh der Forschung. Das ist nicht normativ, sondern deskriptiv gemeint. Der p-Wert entscheidet (häufig) darüber, was publiziert wird, und damit, was als Wissenschaft sichtbar ist - und damit, was Wissenschaft ist (wiederum deskriptiv, nicht normativ gemeint). Kurz: Dem p-Wert wird viel Bedeutung zugemessen. 


<div class="figure" style="text-align: center">
<img src="./images/p_value_who_said.png" alt="Der p-Wert wird oft als wichtig erachtet" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-8)Der p-Wert wird oft als wichtig erachtet</p>
</div>


Was sagt uns der p-Wert? Eine gute intuitive Definition ist:

>    Der p-Wert sagt, wie gut die Daten zur Nullhypothese passen.


Je größer p, desto besser passen die Daten zur Nullhypothese.

Allerdings hat der p-Wert seine Probleme. Vor allem: Er wird missverstanden. Jetzt kann man sagen, dass es dem p-Wert (dem armen) nicht anzulasten, dass andere/ einige ihm missverstehen. Auf der anderen Seite finde ich, dass sich Technologien dem Nutzer anpassen sollten (soweit als möglich) und nicht umgekehrt. Die (genaue) Definition des p-Werts ist aber auch so kompliziert, man kann sie leicht missverstehen:

> Der p-Wert gibt die Wahrscheinlichkeit P unserer Daten D an (und noch extremerer), unter der Annahme, dass die getestete Hypothese H wahr ist (und wenn wir den Versuch unendlich oft wiederholen würden, unter identischen Bedingungen und ansonsten zufällig).
p = P(D|H)

Viele Menschen - inkl. Professoren und Statistik-Dozenten - haben Probleme mit dieser Definition [@Gigerenzer2004]. Das ist nicht deren Schuld: Die Definition ist kompliziert. Vielleicht denken viele, der p-Wert sage das, was tatsächlich interessant ist: die Wahrscheinlichkeit der (getesteten) Hypothese H, gegeben der Tatsache, dass bestimmte Daten D vorliegen. Leider ist das *nicht* die Definition des p-Werts. Also:

$$ P(D|H) \ne P(H|D) $$

Der p-Wert ist für weitere Dinge kritisiert worden [@Wagenmakers2007, @uncertainty]; z.B. dass die "5%-Hürde" einen zu schwachen Test für die getestete Hypothese bedeutet. Letzterer Kritikpunkt ist aber nicht dem p-Wert anzulasten, denn dieses Kriterium ist beliebig, könnte konservativer gesetzt werden und jegliche mechanisierte Entscheidungsmethode kann ausgenutzt werden. Ähnliches kann man zum Thema "P-Hacking" argumentieren [@Head2015, @Wicherts2016]; andere statistische Verfahren können auch gehackt werden.

Ein wichtiger Anklagepunkt lautet, dass der p-Wert nicht nur eine Funktion der Effektgröße ist, sondern auch der Stichprobengröße. Sprich: Bei großen Stichproben wird jede Hypothese signifikant. Damit verliert der p-Wert an Nützlichkeit. Die Verteitigung argumentiert hier, dass das "kein Bug, sondern ein Feature" sei: Wenn man z.B. die Hypothese prüfe, dass der Gewichtsunteschied zwischen Männern und Frauen 0,000000000kg sei und man findet 0,000000123kg Unterschied, ist die getestete Hypothese falsch. Punkt. Der p-Wert gibt demnach das korrekte Ergebnis. Meiner Ansicht nach ist die Antwort zwar richtig, geht aber an den Anforderungen der Praxis vorbei.

Meine Meinung ist, dass der p-Wert ein problematisch ist (und ein Dinosaurier) und nicht oder weniger benutzt werden sollte (das ist eine normative Aussage). Da der p-Wert aber immer noch der Platzhirsch auf vielen Forschungsauen ist, führt kein Weg um ihn herum. Er muss genau verstanden werden: Was er sagt und - wichtiger noch - was er nicht sagt.


<img src="images/meme_pwert_1iw22a_pvalue_dino.jpg" width="70%" style="display: block; margin: auto;" />





## Überanpassung

## Prädiktion vs. Explanation


## Numerische vs. klassifizierende Modelle

## Geleitete vs. ungeleitete Modelle

## Parametrische vs. nichtparametrische Modelle

## Fehler- vs. Varianzreduktion

## Modellgüte


[^1]: Unter "Wirklichkeit" sei hier ein beliebiges empirisches System vorhanden, mit einer Menge von Objekten *O* und einer Menge von Beziehungen (Relationen) *R* zwischen den Objekten.
[^2]: Der Übergang ist fließend.

[^3]: Tatsächlich wurden die Y-Werte als Sinus-Funktion plus etwas normalverteiltes Rauschen simuliert.
