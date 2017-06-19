# pdfcrop all pdf-files recursively


find . -name '*.pdf' -exec pdfcrop {} \;
