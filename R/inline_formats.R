
## Helper functions for formatting inline citations


## helper functions
#' format the author and year 
#' @param entry a bibentry
#' @param format_inline_fn the function that actually creates the inline format for a single entry
#' @return the author-year citation
authoryear_t <- function(entry, format_inline_fn = format_authoryear_t){
## FIXME Now that these checks are redundant, this entire function
##   could be collapsed with format_authoryear_t, etc.  
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
#' 
#' This is just a utility function that calls format_authoryear_p,
#' which does the actual formating at the time the citation is added
#' to the data.  This provides a separate API for the function that 
#' simply returns the formatted text, from the function that does the
#' formatting (which may change, or may have more flavors, etc).  
#' @param entry a bibentry
#' @param format_inline_fn the function that actually creates the inline format for a single entry
#' @return the author-year citation
authoryear_p <- function(entry, format_inline_fn = format_authoryear_p){
  authoryear_t(entry, format_inline_fn)
}


#' format the author and year parenthetically
#' 
#' This formats a single entry, though adjusted by author.  
#' This function is passed down to 'cite' by 'citep', wher
#' it creates the actuall formatting on the first use.  
#' @param entry a bibentry
#' @param char a character to append to the citation (to disambiguate). 
#' This is handled automatically by the cite function.  
#' @return the author-year citation
format_authoryear_p <- function(entry, char=""){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, %s%s", entry$author$family, entry$year, char)
    else if(n==2)
      sprintf("%s & %s, %s%s", entry$author[[1]]$family, entry$author[[2]]$family, entry$year, char)
#    else if(n==3)
#      sprintf("%s, %s & %s, %s%s", entry$author[[1]]$family, entry$author[[2]]$family, entry$author[[3]]$family,  entry$year, char)
    else if(n>2)
      sprintf("%s _et. al._ %s%s", entry$author[[1]]$family, entry$year, char)
}



#' format the author and year 
#' 
#' This formats a single entry, though adjusted by author.  
#' This function is passed down to 'cite' by 'citet', wher
#' it creates the actuall formatting on the first use.  
#' @param entry a bibentry
#' @param char a character to append to the citation (to disambiguate). 
#' This is handled automatically by the cite function.  
#' @return the author-year citation
format_authoryear_t <- function(entry, char=""){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s (%s%s)", entry$author$family, entry$year, char)
    else if(n==2)
      sprintf("%s & %s (%s%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year, char)
    else if(n>2)
      sprintf("%s _et. al._ (%s%s)", entry$author[[1]]$family, entry$year, char)
}





## Helper internal function.  
#' Helper function to generate a unique inline citation format (called by cite)
#' @param entry a bibentry type object
#' @param format_inline_fn a function that can generate the desired inline citation format (e.g. format_authoryear_t function)
#' @param i the index to start appending disambiguated values on.  Starts at 2 corresponding to the letter b.  
#' @keywords internal
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


## For disambuguation of names in unique_inline()
a_to_z <- c('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')



#' Formatting for numeric inline citations.  Needs testing.  
#' @param entry a bibentry object, e.g. from cite
numeral <- function(entry){
  paste("[", as.character(entry$numeral), "]", sep="")
}



