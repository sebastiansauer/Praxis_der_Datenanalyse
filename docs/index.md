--- 
title: "Praxis der Datenanalyse"
author: "Sebastian Sauer"
date: "2017-02-14"
site: bookdown::bookdown_site
documentclass: book
bibliography: [Statistik_21.bib, book.bib]
biblio-style: apalike
link-citations: yes
colorlinks: yes
lot: yes
lof: yes
fontsize: 12pt
github-repo: sebastiansauer/Praxis_der_Datenanalyse
description: "Eine Einführung in moderne Statistik für Praktiker"
cover-image: images/cover.jpg
---



```r
source("./source/libs.R")
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```


# Vorwort {-}

<img src="images/farb1.jpg" width="440" />


Statistik heute; was ist das? Sicherlich haben sich die Schwerpunkte von gestern zu heute verschoben. Wenig überraschend spielt der Computer eine immer größere Rolle und die Daten werden vielseitiger und massiger. Entsprechend sind neue Verfahren nötig - und vorhanden, in Teilen - um auf diese neue Situation einzugehen. Einige Verfahren werden daher weniger wichtig, z.B. der p-Wert und der t-Test. In diesem Kurs lernen Sie einige praktische Aspekte der modernen Datenanalyse.

R-Pseudo-Syntax
R ist (momentan) die führende Umgebung für Datenanalyse. Entsprechend zentral ist R in diesem Kurs. Zugebenermaßen braucht es etwas Zeit, bis man ein paar Brocken "Errisch" spricht. Um den Einstieg zu erleichern, ist Errisch auf Deutsch übersetzt an einigen Stellen, wo mir dies besonders hilfreich erschien. Diese Stellen sind mit diesem Symbol ![](images/pseudocode.png){ width=5% } gekennzeichnet (für R-Pseudo-Syntax).

*Achtung, Falle*: Schwierige oder fehlerträchtige Stellen sind mit diesem Symbol ![](images/caution.png){ width=5% } markiert.

*Übungsaufgaben*: Das Skript beinhaltet pro Kapitel Übungsaufgaben oder/und Testfragen. Auf diese wird so ![](images/exercises.png){ width=5% } verwiesen.

Ansonsten: Wenn Ihnen R diesen Smiley präsentiert, dann sind Sie am Ziel Ihrer Träume: ![](images/love.png){ width=5% }. 





Dieses Skript wurde mit dem Paket `bookdown` [@xie2015] erstellt, welches wiederum stark auf den Paketen `knitr` [@xie2015] und `rmarkdown` [@rmarkdown] beruht. Diese Pakete stellen verblüffende Funktionalität zur Verfügung als freie Software (frei wie in Bier und frei wie in Freiheit).


- Worum geht es in diesem Kurs
    - Einführung in moderne Verfahren der Statistik
    - Für Praktiker
    - Betonung liegt auf "modern" und "Praktiker"
- Ziel
    - Intuitives, grundlegendes Verständnis zu zentralen Konzepten 
    - Handwerkszeug zum selber Anwenden
- Unterschied zu anderen Kursen
    - Wenig Formeln
    - Keine/weniger "typischen" klassischen Methoden wie ANOVA, Poweranalyse etc.
    - Aufzeigen von Problemen mit klassischen Verfahren
    - Kritik am Status-Quo
- Didaktik
    - Hands-on
    - R
    - Lernfragen
    - Fallstudien
    - Aktuelle Entwicklungen ausgerichtet
