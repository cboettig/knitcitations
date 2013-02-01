#' Erase existing list of works cited
#' @param bibtex logical, internal use parameter only.  
#' 
#' @details simply overwrites knitcitations.bib in bibtex data logging mode.
#' (which means bibtex is used for internal data; not that the input data comes
#' from bibtex. Input data can come from any source, bibtex or DOI, as shown
#' in the documentation).  
#' @export
newbib <- function(bibtex = getOption("bibtex_data")){
  if(bibtex)
    write("", file = "knitcitations.bib")
  else
    rm(list = ls(envir = knitcitationsCache), envir = knitcitationsCache)
}
