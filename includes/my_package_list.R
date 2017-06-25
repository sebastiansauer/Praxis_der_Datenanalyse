# Diese Datei wird automatisch erzeugt! Bitte nicht von Hand ändern!
# (w) in 2017 by Norman Markgraf
packages <- c()
#  010_Organisatorisches.Rmd
packages <- c(packages,  "gridExtra", "grid" )
#  020_Rahmen.Rmd
packages <- c(packages,  "dplyr", "name_des_pakets", "dplyr", "dplyr" )
#  030_Tidy_Data.Rmd
packages <- c(packages,  "readr", "tidyr" )
#  040_Datenjudo.Rmd
packages <- c(packages,  "tidyverse", "stringr", "car", "desctable", "lsr", "methods" )
#  043_Typische_Probleme_Datenanalyse.Rmd
packages <- c(packages,  "tidyverse", "corrr", "gridExtra", "car" )
#  045_Fallstudie_dplyr.Rmd
packages <- c(packages,  "tidyverse", "nycflights13" )
#  046_Fallstudie_movies.Rmd
packages <- c(packages,  "tidyverse", "corrr" )
#  050_Daten_visualisieren.Rmd
packages <- c(packages,  "tidyverse", "gridExtra", "pander", "gridExtra" )
#  056_Fallstudie_Visualisierung.Rmd
packages <- c(packages,  "tidyverse", "corrr", "GGally" )
#  060_Modellieren.Rmd
packages <- c(packages,  "tidyverse", "grid", "png" )
#  061_Inferenzstatistik.Rmd
packages <- c(packages,  "pwr", "tidyverse", "broom", "BayesFactor" )
#  071_Regression.Rmd
packages <- c(packages,  "caret", "tidyverse", "gridExtra", "modelr", "broom", "viridis" )
#  072_klassifizierende_Regression.Rmd
packages <- c(packages,  "SDMTools", "pROC", "tidyverse", "BaylorEdPsych", "broom", "BaylorEdPsych", "plotROC", "gridExtra", "pander" )
#  075_Fallstudien_Titanic_Affairs.Rmd
packages <- c(packages,  "tidyverse", "psych", "broom", "corrplot", "psych", "ggplot2", "dplyr", "MBESS", "pander" )
#  082_Clusteranalyse.Rmd
packages <- c(packages,  "tidyverse", "cluster", "broom" )
#  083_Dimensionsreduktion.Rmd
packages <- c(packages,  "corrplot", "gplots", "nFactors", "tidyverse", "psych", "MASS", "plot3D" )
#  090_Textmining.Rmd
packages <- c(packages,  "tidyverse", "stringr", "tidytext", "pdftools", "downloader", "lsa", "SnowballC", "wordcloud", "gridExtra", "pander" )
#  100_Anhang.Rmd
packages <- c(packages,  "" )
#  116_Probeklausur.Rmd
packages <- c(packages,  "" )
#  117_Hinweise.Rmd
packages <- c(packages,  "" )
#  120_Literatur.Rmd
packages <- c(packages,  "" )
packages <- sort(unique(packages)[-1])

packages <- packages[packages != ""]
packages <- packages[packages != "name_des_pakets"]
