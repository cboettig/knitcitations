
## Helper functions for formatting inline citations


## helper functions
#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_t <- function(entry, format_inline_fn = format_authoryear_t){
    ## Check if we already have an inline citation format
#    if(is.null(entry$inline)){
#      entry$inline <- format_inline_fn(entry)
#      entry <- unique_inline(entry, format_inline_fn)
#    }
#    assign(entry$key, entry, envir=knitcitationsCache)

## Handle multiple entries
    entry$inline
}
## helper functions
#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_p <- function(entry, format_inline_fn = format_authoryear_p){
  authoryear_t(entry, format_inline_fn)
}


#' format the author and year parenthetically
#' @param entry a bibentry
#' @return the author-year citation
format_authoryear_p <- function(entry, char=""){
    n <- length(entry$author)
    if(n==1)
      sprintf("(%s, %s%s)", entry$author$family, entry$year, char)
    else if(n==2)
      sprintf("(%s & %s, %s%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year, char)
#    else if(n==3)
#      sprintf("(%s, %s & %s, %s%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$author[[3]]$family,  entry$year, char)
    else if(n>2)
      sprintf("(%s _et. al._ %s%s)", entry$author[[1]]$family, entry$year, char)
}


format_authoryear_t <- function(entry, char=""){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s (%s%s)", entry$author$family, entry$year, char)
    else if(n==2)
      sprintf("%s & %s (%s%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year, char)
    else if(n>2)
      sprintf("%s _et. al._ (%s%s)", entry$author[[1]]$family, entry$year, char)
}



unique_inline <- function(entry, format_inline_fn, i = 2){
      # check inline citation against existing bibliography
      lib <- read_cache()
      existing <- sapply(lib, function(x) x$inline)
      m <- match(entry$inline, existing)
      # if match, check if key is the same
      if(length(m) > 0){
        if(!is.na(m)){
          #warning(paste("match found, m =", m))
          # if the key is not the same, then we need to modify the inline 
          if(!identical(entry$key, lib[[m]]$key)){
            #warning(paste("key =", entry$key, "found and ", lib[[m]]$key, "found"))
            inline <- format_inline_fn(entry, a_to_z[i])
            i <- i+1
            entry$inline <- inline
             entry <- unique_inline(entry, format_inline_fn, i) # recursive check
          } else {
            entry # inline format matches an entry with the same key, so we can use it.
          }
        } else {
          entry # inline format has not been used yet, so we can use it safely
        }
      }
      entry
}


## For disambuguation of names
a_to_z <- c('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')


numeral <- function(entry){
  paste("[", as.character(entry$numeral), "]", sep="")
}



