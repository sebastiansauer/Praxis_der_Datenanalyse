# make_package_list.R
# ===================
#
# (C) in 2017 by Norman Markgraf
#
# Lizence CC BY-NC-SA 4.0

library(stringr)

doc_root <- "./"
my_packages_list <- paste0(doc_root, "includes/my_package_list.R")

libstring <- regex("library\\((\\w+)\\)", multiline = TRUE)

files <- list.files(file.path(doc_root), pattern="\\d\\d\\d_\\w+.Rmd")

names(files) <- files

# Selektives löschen von Dateien mit _fake_ Einträgen:
files["020_Rahmen_1.Rmd"] <- NA

output <- c()

output <- c(output, "# Diese Datei wird automatisch erzeugt! Bitte nicht von Hand ändern!")
output <- c(output, "# (w) in 2017 by Norman Markgraf")
output <- c(output,"packages <- c()")

for(file in na.omit(files)) {
  srctext <- read_lines(file.path(file))
  libs <- na.omit(str_match(srctext, libstring))[,2]
  output <- c(output,paste("# ", file))
  output <- c(output,paste("packages <- c(packages, ", paste(paste0("\"",libs, "\""), collapse=", "), ")"))
}

output <- c(output,"packages <- sort(unique(packages)[-1])")

write(output, file=my_packages_list, sep="\n")

#print(output)
