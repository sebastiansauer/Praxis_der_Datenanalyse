#
# Alle Pakete laden ... (W) by Norman Markgraf
#

# 020_Rahmen_1
#
# dplyr, okcupiddata

inst = c("tidyverse", "bookdown", "kntitr", "dplyr", "okcupiddata")

# 040_Datenjudo
#
# tidyverse, stringr, car, nycflights13
inst = c(inst, "tidyverse", "stringr", "car", "nycflights13")


# 043_Typische_Probleme_Datenanalyse
#
# tidyverse, stringr, car, nycflights13
inst = c(inst, "tidyverse", "corr", "gridExtra", "car")

# 045_Fallstudie_dplyr
inst = c(inst, "nycflights13")

#050_Daten_visualisieren
inst = c(inst,  "car", "gridExtra")

#052_Farben
inst = c(inst, "wesanderson", "RColorBrewer", "gridExtra", "ggthemes", "cowplot")

#054_Vertiefung_ggplot2.Rmd:library(ggplot2)
inst = c(inst, "corrr", "GGally")

#056_Fallstudie_Visualisierung
inst = c(inst, "corrr", "GGally")

# 060_Modellieren
inst = c(inst, "grid", "png")

# 062_Inferenz_Grundlagen.Rmd
inst = c(inst,  "mosaic", "lsr", "methods", "effects")

# 067_Inferenz_kategoria
inst = c(inst, "mosaic")


# 071_Regression
inst = c(inst, "caret", "gridExtra", "modelr")

# 072_klassifizierende_Regression
inst = c(inst, "SDMTools", "ROCR", "ROCR", "lmtest", "BaylorEdPsych")

# 073_baumbasierte_Verfahren
inst = c(inst, "rpart", "rpart.plot", "MASS")

# 075_Fallstudie_Titanic
inst = c(inst, "titanic", "compute.es")

# 076_Fallstudie_Affairs
inst = c(inst, "psych", "corrplot", "MBESS", "dplyr", "broom", "knitr")

#081_Assoziationsanalyse.
inst = c(inst, "arules", "methods", "arulesViz")

# 082_Clusteranalyse
inst = c(inst, "cluster", "ggplot2", "tidyr", "broom")

# 083_Dimensionsreduktion
inst = c(inst , "corrplot", "gplots", "scatterplot3d", "tidyverse", "gplots", "ΩnFactors", "scatterplot3d")

#090_Textmining.Rmd
inst = c(inst, "tidyverse", "stringr", "tidytext", "pdftools", "downloader", "lsa", "SnowballC", "wordcloud", "gridExtra")

# 101_RMarkdown
inst = c(inst, "knitr", "tidyverse")


# And now ... INSTALL ALL! ;-)
install.packages(unique(inst), dependencies = TRUE)





