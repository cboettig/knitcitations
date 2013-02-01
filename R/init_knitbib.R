#' Helper function to get knit data
#' @param bibtex the option to use bibtex
#' @param the updated value of the option to use bibtex
#' @details creates a cache environment and a bibfile.  Should probably create only one of these.  
#' @keywords internal
knitcitations_data <- function(bibtex = getOption("bibtex_data")){
  if(is.null(bibtex)){
    options("bibtex_data" = FALSE)
    bibtex = getOption("bibtex_data")
    knitcitationsCache <- new.env(hash=TRUE)
#    assign("knitcitationsCache", new.env(hash=TRUE), envir=.GlobalEnv)
  }
  ## Creates a special environment to cache citation data if it doesn't exist yet
  #if(!exists("knitcitationsCache", .GlobalEnv))
    #assign("knitcitationsCache", new.env(hash=TRUE), envir=.GlobalEnv)
  if(bibtex){ 
    ## Creates a blank bibtex file if none exists
    if(is(try(read.bib("knitcitations.bib"), silent=TRUE), "try-error")) ## If none exists 
      tryCatch(write("", file="knitcitations.bib"), error= function(e) 
             stop("Could not initiate a bibliography.")) # try to create it
  }
  bibtex
}


