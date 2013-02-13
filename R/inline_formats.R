
## Helper functions for formatting inline citations

#' format the author and year parenthetically
#' @param entry a bibentry
#' @return the author-year citation
authoryear_p <- function(entry){
# FIXME Need to handle the case of Boettiger 2012a, Boettiger 2012b, etc

    n <- length(entry$author)
    if(n==1)
      sprintf("(%s, %s)", entry$author$family, entry$year)
    else if(n==2)
      sprintf("(%s & %s, %s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
#    else if(n==3)
#      sprintf("(%s, %s & %s, %s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$author[[3]]$family,  entry$year)
    else if(n>2)
      sprintf("(%s _et. al._ %s)", entry$author[[1]]$family, entry$year)
}


## For disambuguation of names
a_to_z <- c('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')

## helper functions
#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_t <- function(entry){
    
    n <- length(entry$author)
    if(n==1)
      sprintf("%s (%s)", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s (%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ (%s)", entry$author[[1]]$family, entry$year)
}

numeral <- function(entry){
entry$numeral
}



