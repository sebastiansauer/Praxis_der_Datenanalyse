# Textmining


## Lernziele



- Sie kennen zentrale Ziele und Begriffe des Textminings.
- Sie wissen, was ein 'tidy text dataframe' ist.
- Sie können Worthäufigkeiten auszählen.
- Sie können Worthäufigkeiten anhand einer Wordcloud visualisieren.


## Zentrale Begriffe



- Ein *Corpus* bezeichnet die Menge der zu analyisierenden Dokumente-

  - Ein *Token* (*Term*) ist ein elementarer Baustein eines Texts, die kleinste Analyseeinheit, häufig ein Wort.

- Unter *tidy text* versteht man einen Dataframe, in dem pro Zeile nur ein Term steht.


## Tidytext -- Input

```{r}
text <- c("Wir haben die Frauen zu Bett gebracht,",
          "als die Männer in Frankreich standen.",
          "Wir hatten uns das viel schöner gedacht.",
          "Wir waren nur Konfirmanden.")
text_df <- data_frame(Zeile = 1:4,
                      text = text)
```

## Tidytext -- Output

```{r}
text_df %>%
  unnest_tokens(output = wort, input = text) -> tidytext_df

tidytext_df %>% head
```

>   In einem 'tidy text Dataframe'  steht in jeder Zeile ein Wort (token) und die Häufigkeit des Worts
im Dokument.


```{r echo = FALSE}
afd_url <- paste0("https://www.alternativefuer.de",
                  "/wp-content/uploads/sites/7/2016/05/",
                  "2016-06-27_afd-grundsatzprogramm_web-version.pdf")

afd_url <- "../data/2016-06-27_afd-grundsatzprogramm_web-version.pdf"

afd_pfad <- "../data/afd_programm.pdf"

# download(afd_url, afd_pfad)

afd_raw <- pdftools::pdf_text(afd_pfad)
afd_df <- data_frame(Zeile = 1:96,
                     afd_raw)


afd_df %>%
  unnest_tokens(token, afd_raw) %>%
  filter(str_detect(token, "[a-z]")) -> afd_df

count(afd_df)

```



## Worthäufigkeiten auszählen

```{r}
afd_df %>%
  na.omit() %>%  # fehlende Werte löschen
  count(token, sort = TRUE) %>%
  head
```

## Stopwörter entfernen

```{r echo = FALSE}
data(stopwords_de)

stopwords_de <- data_frame(word = stopwords_de)

stopwords_de <- stopwords_de %>%
  rename(token = word)

afd_df %>%
  anti_join(stopwords_de) -> afd_df

afd_df %>%
  count(token, sort = TRUE) -> afd_count


```


```{r echo = FALSE}
afd_count %>%
  top_n(5) %>%
  knitr::kable()
```


