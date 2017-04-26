


# Probeklausur

Aussagen sind entweder als "richtig" oder als "falsch" zu beantworten. Offene Fragen verlangen einen "Text" als Antwort.

## Fragen

1. Bei `install.packages` spielt der Parameter `dependencies = TRUE` in der Praxis keine Rolle.

2. Dateien mit der Endung `.R` sind keine Textdateien.

3. Der Befehl `read.csv` kann auch Dateien einlesen, die nicht lokal, sondern auf einem Server im Internet gespeichert sind.

4. Fehlende Werte werden in R durch `NA` kodiert.

5. Um Variablen einen Wert zuzuweisen, kann man in R den Zuweisungspfeil `<-` verwenden.

6. Die deutsche Version von R verwendet im Standard das Komma als Dezimaltrennzeichen.

7. Statistisches Modellieren verwendet die Abduktion als zentrale Denkfigur.

8. Eine Abduktion führt zu sicheren Schlüssen.

9. Das CSV-Format ist identisch zum Excel-Format, was sich auch darin zeigt, dass Excel CSV-Datein oft problemlos öffnet.

10. Das Arbeitsverzeichnis (engl. *working directory*) ist der Ort, in dem R eine Datei, die Sie aufrufen, vermutet - sofern kein anderer Pfad angegeben ist.

11. In einer Tabelle in Normalform steht in jeder Zeile eine Variable und in jeder Spalte eine Beobachtung.

12. Die Funktion `filter` filtert Spalten aus einer Tabelle.

13. Die Funktion `select` lässt Spalten sowohl anhand ihres Namens als auch ihrer Nummer (Position in der Tabelle) auswählen.

14. Die Funktion `group_by` gruppiert eine Tabelle anhand der Werte einer diskreten Variablen.

15. Die Funktion `group_by` akzeptiert nur Faktorvariablen als Gruppierungsvariablen.

16. Die Funktion `summarise` darf nur für Funktionen verwendet werden, welche genau *einen* Wert zurückliefern.

17. Was sind drei häufige Operationen der Datenaufbereitung?

18. Um Korrelationen mit R zu berechnen, kann man die Funktion `corrr::correlate` verwenden.

19. `corrr::correlate` liefert stets einen Dataframe zurück.

20. Tibbles sind eine spezielle Art von Dataframes.

21. Was zeigt uns "Anscombes Quartett"?

22. `ggplot` unterscheidet drei Bestandtteile eines Diagramms: Daten, Geome und Transformationen.

23. Um eine kontinuierliche Variable zu plotten, wird häufig ein Histrogramm verwendet.

24. Das Geom `tile` zeigt drei Variablen.

25. Geleitetes Modellieren kann unterteilt werden in prädiktives und explikatives Modellieren.

26. Der Befehl `scale` verschiebt den Mittelwert einer Verteilung auf 0 und skaliert die sd auf 1.

27. Mit "binnen" im Sinne der Datenanalyse ist gemeint, eine kategoriale Variable in eine kontinuierliche zu überführen.

28. Die Gleichung `y = ax + b` lässt sich in R darstellen als `y ~ ax + b`.

29. $R^2$, auch Bestimmtheitsmaß oder Determinationskoeffizient genannt, gibt die Vorhersagegüte im Verhältnis zu einem "Nullmodell" an.

30. Bei der logistischen Regression gilt: Bei  $β0>0$ ist die Wahrscheinlichkeit *kleiner* als 50% gibt, dass das modellierte Ereignis eintritt, wenn alle anderen Prädiktoren Null sind.

31. Die logistische Regression sollte *nicht* verwendet werden, wenn die abhängige Variable dichotom ist.

32.Die logistische Regression stellt den Zusammenhang zwischen Prädiktor und Kriterium nicht mit einer Geraden, sondern mit einer "s-förmigen" Kurve dar.

33. Bevor die Koeffizienten der logistischen Regression als Odds Ration interpretiert werden können, müssen sie "delogarithmiert" werden.

34. Unter "delogarithmieren" versteht man, die Umkehrfunktion der e-Funktion auf eine Gleichung anzuwenden.

35. Wendet man die "normale" Regression an, um eine dichotome Variable als Kriterium zu modellieren, so kann man Wahrscheinlichkeiten größer als 1 und kleiner als 0 bekommen.

36. Eine typische Idee der Clusteranalyse lautet, die Vaerianz innerhalb der Cluster jeweils zu maximieren.

37. Bei einer k-means-Clusteranalyse darf man nicht die Anzahl der Cluster vorab festlegen; vielmehr ermittelt der Algorithmus die richtige Anzahl der Cluster.

38. Für die Wahl der "richtigen" Anzahl der Cluster kann das "Ellbogen-Kriterium" als Entscheidungsgrundlage herangezogen werden.

39. Ein "Screeplot" stellt die Varianz innerhalb der Cluster als Funktion der Anzahl der Cluster dar (im Rahmen der Clusteranalyse).

40. Die euklidische Distanz zwischen zwei Objekten in der Ebene lässt sich mit dem Satz des Pythagoras berechnen.


## Lösungen

1. Falsch
2. Falsch
3. Richtig
4. Richtig
5. Richtig
6. Falsch
7. Richtig
8. Falsch
9. Falsch
10. Richtig
11. Falsch
11. Falsch
12. Falsch
13. Richtig
14. Richtig
15. Falsch
16. Richtig
17. Auf fehlende Werte prüfen, Fälle mit fehlenden Werte löschen, Fehlende Werte ggf. ersetzen,Nach Fehlern suche, Ausreiser identifizieren, Hochkorrelierte Variablen finden, z-Standardisieren, Quasi-Konstante finden, Auf Normalverteilung prüfen, Werte umkodieren und "binnen".
18. Richtig
19. Richtig
20. Richtig
21. Es geht hier um vier Datensätze mit zwei Variablen (Spalten; X und Y). Offenbar sind die Datensätze praktisch identisch: Alle X haben den gleichen Mittelwert und die gleiche Varianz; dasselbe gilt für die Y. Die Korrelation zwischen X und Y ist in allen vier Datensätzen gleich. Allerdings erzählt eine Visualisierung der vier Datensätze eine ganz andere Geschichte.
22. Falsch
23. Richtig
24. Richtig
25. Falsch
26. Richtig
27. Falsch
28. Richtig
29. Richtig
30. Falsch
31. Falsch
32. Richtig
33. Richtig
34. Falsch. Richtig wäre: Die Umkehrfunktion des Logarithmus, also die e-Funktion, auf eine Gleichung anzuwenden.
35. Richtig
36. Falsch
37. Falsch. Richtig wäre: Man gibt die Anzahl der Cluster vor. Dann vergleicht man die Varianz within der verschiedenen Lösungen.
38. Richtig
39. Richtig
40. Richtig






