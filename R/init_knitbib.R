#' Helper function to get knit data
#' @param bibtex the option to use bibtex
#' @param the updated value of the option to use bibtex
#' @details creates a cache environment and a bibfile.  Should probably create only one of these.  
#' @keywords internal
knitcitations_data <- function(bibtex = get("bibtex_data", envir=knitcitations_options)){
  if(is.null(bibtex)){
    options("bibtex_data" = FALSE)
    bibtex = get("bibtex_data", envir=knitcitations_options)
    knitcitationsCache <- new.env(hash=TRUE)
  }
  if(bibtex){ 
    ## Creates a blank bibtex file if none exists
    if(is(try(read.bib("knitcitations.bib"), silent=TRUE), "try-error")) ## If none exists 
      tryCatch(write("", file="knitcitations.bib"), error= function(e) 
             stop("Could not initiate a bibliography.")) # try to create it
  }
  bibtex
}


