
authoryear_t <- function(entry) entry$inline
authoryear_p <- authoryear_t


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
      sprintf("%s, %s%s", shortname(entry$author$family), entry$year, char)
    else if(n==2)
      sprintf("%s & %s, %s%s", shortname(entry$author[[1]]), shortname(entry$author[[2]]), entry$year, char)
#    else if(n==3)
#      sprintf("%s, %s & %s, %s%s", entry$author[[1]]$family, entry$author[[2]]$family, entry$author[[3]]$family,  entry$year, char)
    else if(n>2)
      sprintf("%s et al. %s%s", shortname(entry$author[[1]]), entry$year, char)
}


shortname <- function(person){
  if(person$family == "")
    cleanupLatex(person$given)
  else 
    cleanupLatex(person$family)
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
      sprintf("%s (%s%s)", shortname(entry$author), entry$year, char)
    else if(n==2)
      sprintf("%s & %s (%s%s)", shortname(entry$author[[1]]), shortname(entry$author[[2]]), entry$year, char)
    else if(n>2)
      sprintf("%s et al. (%s%s)", shortname(entry$author[[1]]), entry$year, char)
}





## Helper internal function.  
#' Helper function to generate a unique inline citation format (called by cite)
#' @param entry a bibentry type object
#' @param format_inline_fn a function that can generate the desired inline 
#'  citation format (e.g. format_authoryear_t function)
#' @param i the index to start appending disambiguated values on.  
#'  Starts at 2 corresponding to the letter b.  
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
      #warning(paste("key =", entry$key, "found and ",
      #                lib[[m]]$key, "found"))
            inline <- format_inline_fn(entry, a_to_z[i])
            i <- i+1
            entry$inline <- inline
             entry <- unique_inline(entry, format_inline_fn, i) 
             # recursive check
          } else {
            entry 
            # inline format matches an entry with the same key, 
            # so we can use it.
          }
        } else {
          entry # inline format has not been used yet, so we can use it safely
        }
      }
      entry
}


## For disambuguation of names in unique_inline()
a_to_z <- c('a','b','c','d','e','f','g','h','i','j','k',
            'l','m','n','o','p','q','r','s','t','u','v',
            'w','x','y','z')



#' Formatting for numeric inline citations.  Needs testing.  
#' @param entry a bibentry object, e.g. from cite
numeral <- function(entry){
  paste("[", as.character(entry$numeral), "]", sep="")
}




cleanupLatex <-
function (x) 
{
    if (!length(x)) 
        return(x)
    if (any(grepl("mkbib", x))) {
        x <- gsub("mkbibquote", "dQuote", x)
        x <- gsub("mkbibemph", "emph", x)
        x <- gsub("mkbibbold", "bold", x)
    }
    x <- gsub("\\\\hyphen", "-", x)
    latex <- try(tools::parseLatex(x), silent = TRUE)
    if (inherits(latex, "try-error")) {
        x
    }
    else {
        x <- tools::deparseLatex(tools::latexToUtf8(latex), dropBraces = TRUE)
        if (grepl("\\\\[[:punct:]]", x)) {
            x <- gsub("\\\\'I", "\303\215", x)
            x <- gsub("\\\\'i", "\303\255", x)
            x <- gsub("\\\\\"I", "\303\217", x)
            x <- gsub("\\\\\"i", "\303\257", x)
            x <- gsub("\\\\\\^I", "\303\216", x)
            x <- gsub("\\\\\\^i", "\303\256", x)
            x <- gsub("\\\\`I", "\303\214", x)
            x <- gsub("\\\\`i", "\303\254", x)
            Encoding(x) <- "UTF-8"
        }
        x
    }
}


