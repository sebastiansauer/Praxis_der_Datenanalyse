--- 
title: "Praxis der Datenanalyse ENTWURF"
subtitle: "Skript zum Modul"
author: "Sebastian Sauer. Mit Beiträgen von Oliver Gansser, Matthias Gehrke und Karsten Lübke"
date: "09 June, 2017"
lang: de-De
colorlinks: yes
thanks: "Danke an Norman Markgraf"
cover-image: cover.jpg
favicon: "images/favicon/favicon.ico"
#url: "https\://sebastiansauer.github.io/Praxis_der_Datenanalyse/"
bibliography:
- bib.bib
- libs.bib
description: "Eine Einführung in moderne Statistik für Praktiker"
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





# Vorwort {-}




<img src="images/FOM.jpg" width="30%" style="display: block; margin: auto;" />

<img src="images/licence.png" width="10%" style="display: block; margin: auto;" />


Statistik heute; was ist das? Sicherlich haben sich die Schwerpunkte von "gestern" zu "heute" verschoben. Wenig überraschend spielt der Computer eine immer größere Rolle; die Daten werden vielseitiger und massiger. Entsprechend sind neue Verfahren nötig - und vorhanden, in Teilen - um auf diese neue Situation einzugehen. Einige Verfahren werden daher weniger wichtig, z.B. der p-Wert oder der t-Test. Allerdings wird vielfach, zumeist, noch die Verfahren gelehrt und verwendet, die für die erste Hälfte des 20. Jahrhunderts entwickelt wurden. Eine Zeit, in der kleine Daten, ohne Hilfe von Computern und basierend auf einer kleinen Theoriefamilie im Rampenlicht standen [@cobb2007introductory]. Die Zeiten haben sich geändert!

<img src="images/vorwort/Forschung_frueher_heute.jpg" width="4108" />

Zu Themen, die heute zu den dynamischten Gebieten der Datenanalyse gehören, die aber früher keine große Rolle spielten, gehören [@hardin2015data]: 

- Nutzung von Datenbanken und anderen Data Warehouses
- Daten aus dem Internet automatisch einlesen ("scraping")
- Genanalysen mit Tausenden von Variablen
- Gesichtserkennung


Sie werden in diesem Kurs einige praktische Aspekte der modernen Datenanalyse lernen. Ziel ist es, Sie - in Grundzügen - mit der Art und Weise vertraut zu machen, wie angewandte Statistik bei führenden Organisationen und Praktikern verwendet wird^[Statistiker, die dabei als Vorbild Pate standen sind: Roger D. Peng: <http://www.biostat.jhsph.edu/~rpeng/>, Hadley Wickham: <http://hadley.nz>, Jennifer Bryan: <https://github.com/jennybc>].


Es ist ein Grundlagenkurs; das didaktische Konzept beruht auf einem induktiven, intuitiven Lehr-Lern-Ansatz. Formeln und mathematische Hintergründe such man meist vergebens (tja).

Im Gegensatz zu anderen Statistik-Büchern steht hier die Umsetzung mit R stark im Vordergrund. Dies hat pragmatische Gründe: Möchte man Daten einer statistischen Analyse unterziehen, so muss man sie zumeist erst aufbereiten; oft mühselig aufbereiten. Selten kann man den Luxus genießen, einfach "nur", nach Herzenslust sozusagen, ein Feuerwerk an multivariater Statistik abzubrennen. Zuvor gilt es, die Daten aufzubereiten, umzuformen, zu prüfen und zusammenzufassen. Diesem Teil ist hier recht ausführlich Rechnung getragen. 


"Statistical thinking" sollte, so eine verbreitete Idee, im Zentrum oder als Ziel einer Statistik-Ausbildung stehen [@wild1999statistical]. Es ist die Hoffnung der Autoren dieses Skripts, dass das praktische Arbeiten (im Gegensatz zu einer theoretischen Fokus) zur Entwicklung einer Kompetenz im statistischen Denken beiträgt.

Außerdem spielt in diesem Kurs die Visualisierung von Daten eine große Rolle. Zum einen könnte der Grund einfach sein, dass Diagramme ansprechen und gefallen (einigen Menschen). Zum anderen bieten Diagramme bei umfangreichen Daten Einsichten, die sonst leicht wortwörtlich überersehen würden.

>   Dieser Kurs zielt auf die praktischen Aspekte der Analyse von Daten ab: "wie mache ich es?"; mathematische und philosophische Hintergründe werden vernachlässigt bzw. auf einschlägige Literatur verwiesen.

**Icons**

R spricht zu Ihnen; sie versucht es jedenfalls, mit einigen Items [@ladyofhats_smileys_2017].

*R-Pseudo-Syntax*: R ist (momentan) die führende Umgebung für Datenanalyse. Entsprechend zentral ist R in diesem Kurs. Zugebenermaßen braucht es etwas Zeit, bis man ein paar Brocken "Errisch" spricht. Um den Einstieg zu erleichern, ist Errisch auf Deutsch übersetzt an einigen Stellen, wo mir dies besonders hilfreich erschien. Diese Stellen sind mit diesem Symbol ![](images/pseudocode.png){ width=5% } gekennzeichnet (für R-Pseudo-Syntax).

*Achtung, Falle*: Schwierige oder fehlerträchtige Stellen sind mit diesem Symbol ![](images/caution.png){ width=5% } markiert.

*Übungsaufgaben*: Das Skript beinhaltet in jedem Kapitel Übungsaufgaben oder/und Testfragen. Auf diese wird mit diesem Icon ![](images/exercises.png){ width=5% } verwiesen oder die Übungen sind in einem Abschnitt mit einsichtigem Titel zu finden.

*Love*: Wenn Ihnen R diesen Smiley präsentiert, dann sind Sie am Ziel Ihrer Träume: ![](images/love.png){ width=5% }. 


**Voraussetzungen**

Dieses Skript hat einige *Voraussetzungen*, was das Vorwissen der Leser angeht; folgende Themengebiete werden vorausgsetzt:

- Deskriptive Statistik
- Grundlagen der Inferenzstatistik
- Grundagen der Regressionsanalyse
- Skalenniveaus
- Grundlagen von R


**Zitationen von Kunstwerken (Bildern), Daten, Software und sonstigen Werken**

Kunstwerke (Bilder) sind genau wie Standard-Literatur im Text zitiert. Alle Werke finden sich im Literaturverzeichnis.



**Lizenz**

Dieses Skript ist publiziert unter [CC-BY-NC-SA 3.0 DE](https://creativecommons.org/licenses/by-nc-sa/3.0/de/).


<img src="images/licence.png" width="10%" style="display: block; margin: auto;" />


**Autoren**

*Sebastian Sauer* schrieb den Hauptteil dieses Skripts. *Oliver Gansser* schrieb das Kapitel zur Dimensionsreduktion.
*Karsten Lübke* schrieb den Großteil des Kapitels zur Regression und zur Clusteranalyse sowie Teile des Kapitels 'Rahmen'. *Matthias Gehrke* schrieb den Großteil des Kapitels zur logistischen Regression.


**Danke**

Norman Markgraf hat umfangreich Fehler gejagt und Verbesserungen ~~angemahnt~~ vorgenommen. Der Austausch mit den ifes-Mitgliedern hielt die Flamme am Köcheln. Eine Reihe weiterer Kollegen standen mit Rat und Tat zur Seite. Die Hochschulleitung sowie das Dekanat für Wirtschaftspsychologie hat dieses Projekt unterstützt. Die Abteilung  Medienentwicklung der FOM hat bei Fragen rund um die Veröffentlichung geholfen. Last but not least: Viele Studierenden wiesen auf Inkonsistenzen, Fehler und Unklarheiten hin. Ihnen allen: Vielen Dank!

**Zitation dieses Skripts**

Bitte zitieren Sie das Skript so:

Sauer, S. (2017). *Praxis der Datenanalyse*. Skript zum Modul im MSc.-Studiengang "Wirtschaftspsychologie & Consulting" an der FOM. FOM Nürnberg. DOI: 10.5281/zenodo.580649.

![](https://zenodo.org/badge/81811975.svg)



Mehr Infos zum DOI hier: <https://zenodo.org/badge/latestdoi/81811975>

Ein Bib-File um dieses Skript zu zitieren finden Sie hier: <https://raw.githubusercontent.com/sebastiansauer/Praxis_der_Datenanalyse/master/Praxis_der_Datenanalyse.bib>.



**Kontakt**

Wenn Sie einen Fehler oder Verbesserungshinweise berichten möchten, können Sie unter <https://github.com/sebastiansauer/Praxis_der_Datenanalyse/issues> einen "Issue" einreichen (Button "New Issue"). Alternativ können Sie Sebastian Sauer und die anderen Autoren über den Online Campus der FOM kontaktieren (eine Nachricht schreiben). Sebastian Sauer können Sie via Twitter folgen (<https://twitter.com/sauer_sebastian>) oder seinen Blog lesen (<https://sebastiansauer.github.io>).


**Technische Details**

Dieses Skript wurde mit dem Paket `bookdown` [@xie2015] erstellt, welches wiederum stark auf den Paketen `knitr` [@xie2015] und `rmarkdown` [@rmarkdown] beruht. Diese Pakete stellen verblüffende Funktionalität zur Verfügung als freie Software (frei wie in Bier und frei wie in Freiheit).

Informationen zu den verwendeten Paketen etc. (`sessionInfo()`) finden Sie hier: <https://raw.githubusercontent.com/sebastiansauer/Praxis_der_Datenanalyse/master/includes/sessionInfo_PraDa.html>.


**Sonstiges**

Aus Gründen der Lesbarkeit wird das männliche Generikum verwendet, welches Frauen und Männer in gleichen Maßen ansprechen soll.


Sebastian Sauer

---




**Herausgeber: FOM Hochschule für Oekonomie & Management gemeinnützige GmbH**
 
Dieses Skript dient als Begleitmaterial zum Modul "Praxis der Datenanalyse" des Masterstudiengangs "Wirtschaftspsychologie & Consulting" der FOM Hochschule für Oekonomie & Management.
 
FOM. Die Hochschule. Für Berufstätige.
Die mit bundesweit über 42.000 Studierenden größte private Hochschule Deutschlands führt seit 1993 Studiengang für Berufstätige durch, die einen staatlich und international anerkannten Hochschulabschluss (Bachelor/Master) erlangen wollen.
Weitere Informationen finden Sie unter <www.fom.de>



