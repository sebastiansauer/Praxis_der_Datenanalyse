
find_funs <- function(f) {

  if ("tidyverse" %in% rownames(installed.packages()) == FALSE) {
    cat("tidyverse is needed for this fuction. Please install. Stopping")
    stop()}

  library(tidyverse)
  library(purrr)

  # search for help in list of installed packages
  help_installed <- help.search(paste0("^",f,"$"), agrep = FALSE)

  # extract package name from help file
  pckg_hit <- help_installed$matches[,"Package"]

  # get list of built-in packages
  builtin_pckgs <- c("base","recommended")
  pckgs <- installed.packages()  %>% as_tibble
  pckgs %>%
    dplyr::filter(Priority %in%  builtin_pckgs) %>%
    dplyr::select(Package) %>%
    distinct -> builtin_pckgs_df

  # check for each element of 'pckg hit' whether its built-in

  map(pckg_hit, ~mat)

  cat(paste("Package name: ", pckg_name, "; built-in package : ", builtin, sep = ""))

}


`%in%`("ggplot2",  "recommended")

match("ggplot2", builtin_pckgs)

help_installed <- help.search(paste0("^", "filter" ,"$"), agrep = FALSE)
pckg
