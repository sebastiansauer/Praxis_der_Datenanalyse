find_funs <- function(f) {
  h <- help.search(paste0("^",f,"$"),agrep=FALSE)
  h$matches[,"Package"]
}


# code by Ben Bolker
# https://stackoverflow.com/questions/10553755/name-of-a-package-for-a-given-function-in-r