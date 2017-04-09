--- 
title: "Praxis der Datenanalyse"
author: "Sebastian Sauer"
date: '2017-04-10'
colorlinks: yes
cover-image: cover.jpg
bibliography:
- Praxis_der_Datenanalyse.bib
- libs.bib
description: Eine Einführung in moderne Statistik für Praktiker
documentclass: book
fontsize: 12pt
github-repo: sebastiansauer/Praxis_der_Datenanalyse
link-citations: yes
lof: yes
lot: yes
nocite: |
  @*
site: bookdown::bookdown_site
biblio-style: apalike
---





# Vorwort

<img src="images/farb1.jpg" width="100%" />


Statistik heute; was ist das? Sicherlich haben sich die Schwerpunkte von gestern zu heute verschoben. Wenig überraschend spielt der Computer eine immer größere Rolle und die Daten werden vielseitiger und massiger. Entsprechend sind neue Verfahren nötig - und vorhanden, in Teilen - um auf diese neue Situation einzugehen. Einige Verfahren werden daher weniger wichtig, z.B. der p-Wert und der t-Test. Allerdings wird vielfach, zumeist, noch die Verfahren gelehrt und verwendet, die für die erste Hälfte des 20. Jahrhunderts entwickelt wurden. Eine Zeit, in der kleine Daten, ohne Hilfe von Computern und basierend auf einer kleinen Theoriefamilie im Rampenlicht standen [@cobb2007introductory]. Die Zeiten haben sich geändert!

<img src="images/Forschung_frueher_heute.jpg" width="4108" />

Zu Themen, die heute zu den dynamischten Gebieten der Datenanalyse gehören, die aber früher keine große Rolle spielten, gehören [@hardin2015data]: 

- Nutzung von Datenbanken und anderen Data Warehouses
- Daten aus dem Internet automatisch einlesen ("scraping")
- Genanalysen mit Tausenden von Variablen
- Gesichtserkennung




Es gibt bisher noch relativ wenig *deutschsprachige* Bücher für moderne Datenanalyse; es ist zu erwarten, dass sich dies bald ändert. Dieses Buch soll beitragen, diese Lücke zu füllen. Sie werden einige praktische Aspekte der modernen Datenanalyse lernen. Es ist ein Grundlagenkurs; dieses Buch ist nicht für Experten geschrieben und durch das Lesen wird man auch kein Experte. Aber man erwirbt Grundkenntnisse. Das didaktische Konzept beruht auf einem induktiven, intuitiven Lehr-Lern-Ansatz. Auf Formeln und mathematische Hintergründe wurde weitestgehend verzichtet. 

Im Gegensatz zu anderen Statistik-Büchern steht hier die Umsetzung mit R deutlich stärker im Vordergrund. Dies hat pragmatische Gründe: Möchte man Daten einer statistischen Analyse unterziehen, so muss man sie zumeist erst aufbereiten; oft mühselig aufbereiten. Selten kann man den Luxus genießen, einfach "nur", nach Herzenslust sozusagen, ein Feuerwerk an multivariater Statistik abzubrennen. Zuvor gilt es, die Daten aufzubereiten, umzuformen, zu prüfen und zusammenzufassen. Diesem Teil ist hier recht ausführlich Rechnung getragen. 

Dieses Buch versteht sich als "Kursbuch", weniger als "Lehrbuch". Es soll neben Inhalt auch Übungen bieten, um den Inhalt zu erarbeiten (Arbeitsbuch wäre auch treffend).

"Statistical thinking" sollte, so eine verbreitete Idee, im Zentrum oder als Ziel einer Statistik-Ausbildung stehen [@wild1999statistical]. Es ist die Hoffnung der Autoren dieses Buches, dass das praktische Arbeiten (im Gegensatz zu einer theoretischen Fokus) zur Entwicklung einer Kompetenz im statistischen Denken beiträgt.‹

Außerdem spielt die Visualisierung von Daten eine große Rolle. Zum einen könnte der Grund einfach sein, dass Diagramme ansprechen und gefallen (einigen Menschen). Zum anderen bieten Diagramme bei umfangreichen Daten Einsichten, die sonst leicht wortwörtlich überersehen würden.

*R-Pseudo-Syntax*: R ist (momentan) die führende Umgebung für Datenanalyse. Entsprechend zentral ist R in diesem Kurs. Zugebenermaßen braucht es etwas Zeit, bis man ein paar Brocken "Errisch" spricht. Um den Einstieg zu erleichern, ist Errisch auf Deutsch übersetzt an einigen Stellen, wo mir dies besonders hilfreich erschien. Diese Stellen sind mit diesem Symbol ![](images/pseudocode.png){ width=5% } gekennzeichnet (für R-Pseudo-Syntax).

*Achtung, Falle*: Schwierige oder fehlerträchtige Stellen sind mit diesem Symbol ![](images/caution.png){ width=5% } markiert.

*Übungsaufgaben*: Das Skript beinhaltet in jedem Kapitel Übungsaufgaben oder/und Testfragen. Auf diese wird mit diesem Icon ![](images/exercises.png){ width=5% } verwiesen oder die Übungen sind in einem Abschnitt mit einsichtigem Titel zu finden.

Ansonsten: Wenn Ihnen R diesen Smiley präsentiert, dann sind Sie am Ziel Ihrer Träume: ![](images/love.png){ width=5% }. 


Dieses Skript wurde mit dem Paket `bookdown` [@xie2015] erstellt, welches wiederum stark auf den Paketen `knitr` [@xie2015] und `rmarkdown` [@rmarkdown] beruht. Diese Pakete stellen verblüffende Funktionalität zur Verfügung als freie Software (frei wie in Bier und frei wie in Freiheit).

Aus Gründen des Lesbarkeit wird das männliche Generikum verwendet, welches Frauen und Männer in gleichen Maßen ansprechen soll.


Die Bildnachweise sind in folgenden Muster aufgebaut:
Nummer (Verweis) des Bildes, Names des Autors, Titel, Quelle (URL), Lizenz, Abrufdatum.


- \@ref(fig:modellieren_plot), Sebastian Unrau, ohne Titel, https://unsplash.com/photos/CoD2Q92UaEg, CC0, 2017-02-12
 

Alle verwendeten Datensätze und R-Pakete finden sich im Literaturverzeichnis; im Text werden Pakete nicht zitiert.

