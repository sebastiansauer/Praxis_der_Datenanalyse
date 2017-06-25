---
title: "Folien für das Modul \\newline 'Praxis der Datenanalyse'"
#author: "ses"
institute: "FOM" 
date: "WS17"
linkcolor: blue
urlcolor: blue
lang: de-De
output:
  beamer_presentation:
    fig_caption: no
    highlight: tango
    keep_tex: yes
    pandoc_args:
    - -V
    - papersize=A4
    - -V
    - fontsize=10pt
    - -V
    - lang=de
    - -V
    - linkcolor=blue
    - -V
    - urlcolor=blue
    - -V
    - theme=NPBT
    - -V
    - colortheme=FOM
---









# Orga

## R-Befehl zur logistischen Regression


Die Funktion `glm` führt die logistische Regression durch. 

```r
glm1 <- glm(Aktienkauf ~ Risikobereitschaft, 
            family = binomial("logit"),
            data = Aktien)
```


# Kap sdjlfk

## Themen pro Termin (insgesamt 44UE Lehre)





| Termin|Thema / Kapitel                              |
|------:|:--------------------------------------------|
|      1|Organisatorisches                            |
|      1|Einführung                                   |
|      1|Rahmen                                       |
|      1|Daten einlesen                               |
|      2|Datenjudo                                    |
|      3|Daten visualisieren                          |
|      4|Fallstudie (z.B. zu 'movies')                |
|      5|Daten modellieren                            |
|      5|Der p-Wert                                   |
|      6|Lineare Regression - metrisch                |
|      7|Lineare Regression - kategorial              |
|      8|Fallstudie (z.B. zu 'titanic' und 'affairs') |
|      9|Vertiefung 1: Textmining oder Clusteranalyse |
|     10|Vertiefung 2: Dimensionsreduktion            |
|     11|Wiederholung                                 |



## Prüfung - Allgemeine Hinweise


- Die Prüfung besteht aus zwei Teilen
    - einer Klausur (50% der Teilnote)
    - einer Datenanalyse (50% der Teilnote).
   
   
   
*Prüfungsrelevant* ist der gesamte Stoff aus dem Skript und dem Unterricht mit [einigen Ausnahmen](https://sebastiansauer.github.io/Praxis_der_Datenanalyse/organisatorisches.html#prufung)


Alle Hinweise zur Prüfung gelten nur insoweit nicht anders vom Dozenten festgelegt. 



## Lernziele

- Einen Überblick über die fünf wesentliche Schritte der Datenanalyse gewinnen.
- R und RStudio installieren können.
- Einige häufige technische Probleme zu lösen wissen.
- R-Pakete installieren können.
- Einige grundlegende R-Funktionalitäten verstehen.
- Auf die Frage "Was ist Statistik?" eine Antwort geben können.


## Datensätze {#daten}


Alle Datensätze liegen im Ordner `data/`, den Sie vom [Github-Repositorium](https://github.com/sebastiansauer/Praxis_der_Datenanalyse) herunterladen können.



## R und RStudio installieren

![](../images/Rahmen/Rlogo.png){ width=10% } ![](../images/Rahmen/rstudiologo.png){ width=10% }




<img src="../images/Rahmen/RStudio-Screenshot.png" title="RStudio" alt="RStudio" width="50%" style="display: block; margin: auto;" />



## Zeilen zählen mit `n` und `count`


<img src="../images/Datenjudo/count-crop.png" title="Sinnbild für 'count'" alt="Sinnbild für 'count'" width="80%" style="display: block; margin: auto;" />

