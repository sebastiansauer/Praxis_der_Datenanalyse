



# Fallstudie `nycflights13` 
Schauen wir uns einige Beispiele der Datenaufbereitung mittels `dplyr` anhand einer Fallstudie an. Wir verwenden hier den Datensatz `flights`aus dem Package `nycflights13`. Der Datensatz ist recht groß (~300.000 Zeilen und 19 Spalten); wenn man ihn als Excel importiert, kann eine alte Möhre von Computer schon in die Knie gehen. Beim Import als CSV habe ich noch nie von Problemen gehört; beim Import via Package ebenfalls nicht. Werfen wir einen ersten Blick in die Daten:

Laden wir zuerst `dplyr` and friends. Das geht mit dem Paket `tidyverse`:

```r
library(tidyverse)
library(nycflights13)  # für die Daten
library(knitr)  # für HTML-Tabellen
```


Dann laden wir die Daten aus dem Paket `nycflights13` und werfen eine Blick hinein ("to glimpse").


```r
data(flights)
glimpse(flights)
#> Observations: 336,776
#> Variables: 19
#> $ year           <int> 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013,...
#> $ month          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
#> $ day            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
#> $ dep_time       <int> 517, 533, 542, 544, 554, 554, 555, 557, 557, 55...
#> $ sched_dep_time <int> 515, 529, 540, 545, 600, 558, 600, 600, 600, 60...
#> $ dep_delay      <dbl> 2, 4, 2, -1, -6, -4, -5, -3, -3, -2, -2, -2, -2...
#> $ arr_time       <int> 830, 850, 923, 1004, 812, 740, 913, 709, 838, 7...
#> $ sched_arr_time <int> 819, 830, 850, 1022, 837, 728, 854, 723, 846, 7...
#> $ arr_delay      <dbl> 11, 20, 33, -18, -25, 12, 19, -14, -8, 8, -2, -...
#> $ carrier        <chr> "UA", "UA", "AA", "B6", "DL", "UA", "B6", "EV",...
#> $ flight         <int> 1545, 1714, 1141, 725, 461, 1696, 507, 5708, 79...
#> $ tailnum        <chr> "N14228", "N24211", "N619AA", "N804JB", "N668DN...
#> $ origin         <chr> "EWR", "LGA", "JFK", "JFK", "LGA", "EWR", "EWR"...
#> $ dest           <chr> "IAH", "IAH", "MIA", "BQN", "ATL", "ORD", "FLL"...
#> $ air_time       <dbl> 227, 227, 160, 183, 116, 150, 158, 53, 140, 138...
#> $ distance       <dbl> 1400, 1416, 1089, 1576, 762, 719, 1065, 229, 94...
#> $ hour           <dbl> 5, 5, 5, 5, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5,...
#> $ minute         <dbl> 15, 29, 40, 45, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, ...
#> $ time_hour      <dttm> 2013-01-01 05:00:00, 2013-01-01 05:00:00, 2013...
```

Der Befehl `data` lädt Daten aus einem zuvor gestarteten Paket. 

Achtung, Fallstudie. Sie sind der/die Assistent_in des Chefs der New Yorker Flughäfen. Ihr Chef kommt gut gelaunt ins Büro und sagt, dass er diesen Schnarchnasen einheizen wolle und sagt, sie sollen ihm mal schnell die Flüge mit der größten Verspätung raussuchen. Nix schickes, aber zacki-zacki...


```r
flights %>% 
  arrange(arr_delay)
#> # A tibble: 336,776 × 19
#>     year month   day dep_time sched_dep_time dep_delay arr_time
#>    <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1   2013     5     7     1715           1729       -14     1944
#> 2   2013     5    20      719            735       -16      951
#> 3   2013     5     2     1947           1949        -2     2209
#> 4   2013     5     6     1826           1830        -4     2045
#> 5   2013     5     4     1816           1820        -4     2017
#> 6   2013     5     2     1926           1929        -3     2157
#> 7   2013     5     6     1753           1755        -2     2004
#> 8   2013     5     7     2054           2055        -1     2317
#> 9   2013     5    13      657            700        -3      908
#> 10  2013     1     4     1026           1030        -4     1305
#> # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
#> #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#> #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#> #   minute <dbl>, time_hour <dttm>
```

Hm, übersichtlicher wäre es wahrscheinllich, wenn wir weniger Spalten anschauen müssten. Am besten neben der Verspätung nur die Information, die wir zur Identifizierung der Schuldigen... will sagen der gesuchten Flüge benötigen


```r
flights %>% 
  arrange(arr_delay) %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest)
#> # A tibble: 336,776 × 8
#>    arr_delay carrier month   day dep_time tailnum flight  dest
#>        <dbl>   <chr> <int> <int>    <int>   <chr>  <int> <chr>
#> 1        -86      VX     5     7     1715  N843VA    193   SFO
#> 2        -79      VX     5    20      719  N840VA     11   SFO
#> 3        -75      UA     5     2     1947  N851UA    612   LAX
#> 4        -75      AA     5     6     1826  N3KCAA    269   SEA
#> 5        -74      AS     5     4     1816  N551AS      7   SEA
#> 6        -73      UA     5     2     1926  N24212   1628   SFO
#> 7        -71      DL     5     6     1753  N3760C   1394   PDX
#> 8        -71      UA     5     7     2054  N806UA    622   SFO
#> 9        -71      B6     5    13      657  N805JB    671   LAX
#> 10       -70      VX     1     4     1026  N855VA     23   SFO
#> # ... with 336,766 more rows
```

Da Zahlen in ihrer natürlichen Form von klein nach groß sortiert sind, sortiert `arrange` in ebendieser Richtung. Wir können das umdrehen mit einem Minuszeichen vor der zu sortierenden Spalte:


```r
flights %>% 
  arrange(-arr_delay) %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest)
#> # A tibble: 336,776 × 8
#>    arr_delay carrier month   day dep_time tailnum flight  dest
#>        <dbl>   <chr> <int> <int>    <int>   <chr>  <int> <chr>
#> 1       1272      HA     1     9      641  N384HA     51   HNL
#> 2       1127      MQ     6    15     1432  N504MQ   3535   CMH
#> 3       1109      MQ     1    10     1121  N517MQ   3695   ORD
#> 4       1007      AA     9    20     1139  N338AA    177   SFO
#> 5        989      MQ     7    22      845  N665MQ   3075   CVG
#> 6        931      DL     4    10     1100  N959DL   2391   TPA
#> 7        915      DL     3    17     2321  N927DA   2119   MSP
#> 8        895      DL     7    22     2257  N6716C   2047   ATL
#> 9        878      AA    12     5      756  N5DMAA    172   MIA
#> 10       875      MQ     5     3     1133  N523MQ   3744   ORD
#> # ... with 336,766 more rows
```

Eine kleine Zugabe: Mit dem Befehl `knitr::kable` kann man einen Dateframe automatisch in eine (einigermaßen) schöne Tabelle ausgeben lassen. Oh halt, wir wollen keine Tabelle mit 300.000 Zeilen (der Chef ist kein Freund von Details). Also begrenzen wir die Ausgabe auf die ersten 10 Plätze.


```r
flights %>% 
  arrange(-arr_delay) %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest) %>% 
  filter(row_number() < 11) %>% 
  kable()
```



 arr_delay  carrier    month   day   dep_time  tailnum    flight  dest 
----------  --------  ------  ----  ---------  --------  -------  -----
      1272  HA             1     9        641  N384HA         51  HNL  
      1127  MQ             6    15       1432  N504MQ       3535  CMH  
      1109  MQ             1    10       1121  N517MQ       3695  ORD  
      1007  AA             9    20       1139  N338AA        177  SFO  
       989  MQ             7    22        845  N665MQ       3075  CVG  
       931  DL             4    10       1100  N959DL       2391  TPA  
       915  DL             3    17       2321  N927DA       2119  MSP  
       895  DL             7    22       2257  N6716C       2047  ATL  
       878  AA            12     5        756  N5DMAA        172  MIA  
       875  MQ             5     3       1133  N523MQ       3744  ORD  

"Geht doch", war die Antwort des Chefs, als sie die Tabelle rübergeben (er mag auch keine Emails). "Ach ja", raunt der Chef, als Sie das Zimmer verlassen wollen, "hatte ich erwähnt, dass ich die gleiche Auswertung für jeden Carrier brauche? Reicht bis in einer halben Stunde".

Wir gruppieren also den Datensatz nach der Fluggesellschaft (`carrier`) und filtern dann  die ersten 3 Zeilen (damit die Tabelle für den Chef nicht zu groß wird). Wie jeder `dplyr`-Befehl wird die vorherige Gruppierung berücksichtigt und daher die Top-3-Zeilen *pro Gruppe*, d.h. pro Fluggesellschaft, ausgegeben.


```r
flights %>% 
  arrange(-arr_delay) %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest) %>% 
  group_by(carrier) %>% 
  filter(row_number() < 4) 
#> Source: local data frame [48 x 8]
#> Groups: carrier [16]
#> 
#>    arr_delay carrier month   day dep_time tailnum flight  dest
#>        <dbl>   <chr> <int> <int>    <int>   <chr>  <int> <chr>
#> 1       1272      HA     1     9      641  N384HA     51   HNL
#> 2       1127      MQ     6    15     1432  N504MQ   3535   CMH
#> 3       1109      MQ     1    10     1121  N517MQ   3695   ORD
#> 4       1007      AA     9    20     1139  N338AA    177   SFO
#> 5        989      MQ     7    22      845  N665MQ   3075   CVG
#> 6        931      DL     4    10     1100  N959DL   2391   TPA
#> 7        915      DL     3    17     2321  N927DA   2119   MSP
#> 8        895      DL     7    22     2257  N6716C   2047   ATL
#> 9        878      AA    12     5      756  N5DMAA    172   MIA
#> 10       852      AA     5    19      713  N3HEAA    257   LAS
#> # ... with 38 more rows
```

Vielleicht gefällt dem Chef diese Darstellung (sortiert nach `carrier`) besser:


```r
flights %>% 
  arrange(-arr_delay) %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest) %>% 
  group_by(carrier) %>% 
  filter(row_number() < 4) %>% 
  arrange(carrier)
#> Source: local data frame [48 x 8]
#> Groups: carrier [16]
#> 
#>    arr_delay carrier month   day dep_time tailnum flight  dest
#>        <dbl>   <chr> <int> <int>    <int>   <chr>  <int> <chr>
#> 1        744      9E     2    16      757  N8940E   3798   CLT
#> 2        458      9E     7    24     1525  N927XJ   3538   MSP
#> 3        421      9E     7    10     2054  N937XJ   3325   DFW
#> 4       1007      AA     9    20     1139  N338AA    177   SFO
#> 5        878      AA    12     5      756  N5DMAA    172   MIA
#> 6        852      AA     5    19      713  N3HEAA    257   LAS
#> 7        198      AS     3     8     1012  N587AS     11   SEA
#> 8        196      AS     1    20     2157  N305AS      7   SEA
#> 9        188      AS     5    23     2205  N516AS      7   SEA
#> 10       497      B6     1    16     1622  N661JB    517   MCO
#> # ... with 38 more rows
```

Da Sie den Chef gut kennen, berechnen Sie gleich noch die durchschnittliche Verspätung pro Fluggesellschaft.


```r
flights %>% 
  select(arr_delay, carrier, month, day, dep_time, tailnum, flight, dest) %>% 
  group_by(carrier) %>% 
  summarise(delay_mean = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(-delay_mean) %>% 
  kable()
```



carrier    delay_mean
--------  -----------
F9             21.921
FL             20.116
EV             15.796
YV             15.557
OO             11.931
MQ             10.775
WN              9.649
B6              9.458
9E              7.380
UA              3.558
US              2.130
VX              1.764
DL              1.644
AA              0.364
HA             -6.915
AS             -9.931

Der Chef ist zufrieden. Sie können sich wieder wichtigeren Aufgaben zuwenden...

