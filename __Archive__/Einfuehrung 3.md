






```r
library(knitr)
```


# Einführung

## Rahmen

Der "Rahmen" dieses Buches ist der Überblick über wesentliche Schritte der Datenanalyse (aus meiner Sicht). Es gibt viele Ansätze, mit denen der Ablauf von Datenanalyse dargestellt wird. Der im Moment populärste oder bekannteste ist wohl der von Hadley Wickham und Garret Grolemund [@r4ds]. Hadley und Garrett haben einen "technischeren" Fokus als der dieses Buches. Ihr Buch "R for Data Science" ist hervorragend (und frei online verfügbar); nur ist der Schwerpunkt ein anderer; es baut ein viel tieferes Verständnis von R auf. Hier spielen aber statistisch-praktisch und statistisch-philosophische[^1] Aspekte eine größere Rolle.


[^1]: Ich hörte mal, jede Formel halbiert die Leserzahl eines Buches. Wahrsheinlich gilt das gleiche für jede Erwähnung von "philosophisch" und zugehörigen Begriffen. Zumindest zwei Leser hat dieses Buch (den Autor mitgezählt) ...

\begin{figure}

{\centering \includegraphics[width=0.7\linewidth]{./images/Prozess} 

}

\caption{Rahmen}(\#fig:unnamed-chunk-6)
\end{figure}


Das Diagramm \@ref("Rahmen") stellt den Rahmen dieses Buch dar: Die drei Hauptaspekte sind *Umformen*, *Visualisieren* und *Modellieren*. Dies ist vor dem Hintergrund der *Reproduzierbarkeit* eingebettet. Dieser Rahmen spiegelt das hier vertretene Verständnis von Datenanalyse wieder, wobei es sich nicht unbedingt um eine Abfolge von links nach rechts handeln muss. Wilde Sprünge sind erlaubt und nicht unüblich.

Mit *Umformen* ist gemeint, dass Daten in der Praxis häufig nicht so sind, wie man sie gerne hätte. Mal fehlt eine Variable, die den Mittelwert anderer ausdrückt, oder es gibt unschöne "Löcher", wo starrsinnige Versuchspersonen standhaft keine Antwort geben wollten. Die Zahl an Problemen und (Arten von) Fehlern übersteigt sicherlich die Anzahl der Datensätze. Kurz: Wir sehen uns gezwungen, den Daten einige Einblick abzuringen, und dafür müssen wir sie erst in Form bringen, was man als eine Mischung zwischen Artistik und Judo verstehen kann. Ach ja, die deskriptive Statistik fristet (in diesem Buch) eine untergeordnete Rolle in diesem Schritt.

Dann die *Visualisierung*. Ein Bild sagt mehr als 1000 Worte, weiß der Volksmund. Für die Datenanalyse gilt dies auch. Ein gutes Diagramm vermittelt eine Fülle an Informationen "auf einen Blick" und erzielt damit eine Syntheseleistung, die digitalen Darbietungsformen, sprich: Zahlen, verwehrt bleibt Nebenbei sind Diagramme, mit Geschick erstellt, ein Genuss für das Auge, daher kommt der Visualisierung großen Wert zu.

Als letzten, aber wesentlichen Punkt führen wir das *Modellieren* an. Es gibt mehr Definitionen von "Modell" als ich glauben wollte, aber hier ist damit  gemeint, dass wir uns eine Geschichte ausdenken, wie die Daten entstanden sind, oder präziser gesagt: welcher Mechanismus hinter den Daten steht. So könnten wir Klausurnoten und Lernzeit von einigen Studenten[^2] anschauen, und verkünden, wer mehr lerne, habe auch bessere Noten (ein typischer Dozentenauspruch). Unser Modell postuliert damit einen (vielleicht linearen) Anstieg des Klausurerfolgs bei steigender Vorbereitungszeit. Das schönste an solchen Modellen ist, dass wir Vohersagen treffen können. Zum Beispiel: "Joachim, du hast 928 Stunden auf die Klausur gelernt; damit solltest du 93% der Punkte erzielen".

[^2]: hier und überall sind Frauen und Männer gleichermaßen angesprochen; aus Gründen der Lesbarkeit das generische Maskulinum bevorzugt.

Was ist dann mit dem *Reproduzierbarkeitshintergrund* gemeint? Ihre Arbeiten von Umformen, Visualisieren und Modellieren sollten sich nicht ausschließlich im Arbeitsspeicher Ihres Gehirns stattfinden, auch wenn das bei Ihnen, lieber Leser, vielleicht schneller ginge. Stattdessen soll der Mensch sich Mühe machen, seine Gedanken aufzuschreiben, hier insbesondere die Rechnungen bzw. alles, was den Daten angetan wurde, soll protokolliert werden (auch die Ergebnisse, aber wenn der Weg dorthin klar protokolliert ist, kann man die Ergebnisse ja einfach "nachkochen"). Ein Vorteil dieses Vorgehens ist, dass andere (inklusive Ihres zukünftigen Ich) die Ergebnisse bzw. das Vorgehen einfacher nachvollziehen können.


## Was ist Statistik? Wozu ist sie gut?

Zwei Fragen bieten sich sich am Anfang der Beschäftigung mit jedem Thema an: Was ist die Essenz des Themas? Warum ist das Thema (oder die Beschäftigung damit) wichtig?

Was ist Stististik? *Eine* Antwort dazu ist, dass Statistik die Wissenschaft von Sammlung, Analyse, Interpretation und Kommunikation mithilfe mathematischer Verfahren ist und zur Entscheidungshilfe beitragen solle [@oxford; @sep-statistics]. Damit hätten wir auch den Unterschied zur schnöden Datenanalyse (ein Teil der Statistik) herausgemeiselt. Statistik wird häufig in die zwei Gebiete *deskriptive* und *inferierende* Statistik eingeteilt. Erstere fasst viele Zahlen zusammen, so dass wir den Wald statt vieler Bäume sehen. Letztere verallgemeinert von den vorliegenden (sog. "Stichproben-")Daten auf eine zugrunde liegende Grundmenge (Population). Dabei spielt die Wahrscheinlichkeitsrechnung und Zufallsvariablen eine große Rolle.

Auch wenn die gerade genannte Diskussion die häufigste oder eine typische ist, mehren sich doch Stimmen, die Statstik anders akzentuieren. So schreibt Briggs in einem aktuellen Buch [@uncertainty], dass es in der Statistik darum ginge, die Wahrscheinlichkeit zukünftiger Ereignisse vorherzusagen: "Wie wahrscheinlichi ist es, dass - gegeben einem statistischen Modell, allerlei Annahmen und einem Haufen Daten - Kandidat X der neue Präsident wird"[^3]? Das schöne an dieser Idee ist, dass das "Endprodukt" etwas sehr Weltliches und damit praktisches ist: Die Wahrscheinlichkeit einer interessanten (und unbekannten) Aussage. Nebenbei ruht diese Idee auf dem sicheren Fundament der Wahrscheinlichkeitstheorie.

[^3]: Eine Vorhersage, die bei vielen Vorhersagemodellen komplett in die Grütze ging, wenn man sich die US-Präsidentenwahl 2016 anschaut.

Abgesehen von philosophischen Überlegungen zum Wesen der Statistik kann man sagen, dass Vorhersagen von Ereignissen etwas sehr praktisches sind. Sie nehmen daher aus praktischen Überlegungen einen zentralen Platz in diesem Buch an. Die philosophische Relevanz des prädiktiven Ansatzes ist gut bei Briggs [@uncertainty; @breaking] nachzulesen.

Traditionell ist die Statistik stark daran interessiert, Parameter von Populationen vorherzusagen. Ein Beispiel dazu wäre die mittlere Größe (Parameter) aller Deutschen (Population). Leider sind Populationen häufig ziemlich abstrakt. Nehmen wir als Beispiel an, ein Dozent der FOM (Prof. S.) wie sich der Lernerfolg ändert, wenn die Stoffmenge pro Stunde verdoppelt. Zu seiner Überraschung ist der Lernerfolg geringer als in einem Kontrollkurs. Auf welche Population ist jetzt die Studie bzw. die Daten seiner Stichprobe zu verallgemeinern? Alle Menschen? Alle Studierenden? Alle deutschen Studierenden? Alle Studierenden der FOM? Alle Studierenden aller Zeiten?

- Statistik meint Methoden, die das Ziel haben, Ereignisse präzise vorherzusagen
- Statistik soll sich um Dinge dieser Welt drehen, nicht um Parameter
- Statt einer Frage "ist µ_1 größer als µ_2?" besser "Wie viel Umsatz erwarte ich von diesem Kunden?", "Wie viele Saitensprünge hatte er wohl?", "Wie groß ist die Wahrscheinlichkeit für sie zu überleben?" und dergleichen.
- Der Nutzen von Vorhersagen liegt auf der Hand: Vorhersagen sind praktisch; eine nützliche Angelegenheit (wenn auch schwierig).


## Aufbau des Buches
sdkljf


## Datensätze
Name des Datensatzes    | Quelle   | Beschreibung
`profiles` | {okcupiddata} | Daten von einer Online-Singlebörse
