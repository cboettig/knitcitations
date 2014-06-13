#' Generate the bibliography
#' @param ... additional arguments passed to PrintBibliography,
#' @return a list of works cited  
#' @export
bibliography <- function(..., style=NULL)
{
  bibs <- get_bib()

  if(!is.null(style)){
    refs <- sapply(bibs, csl_formatting)
    # Provide better styling than this.  
    cat(refs)
  } else {
    NoCite(bibs) 
    PrintBibliography(bibs, ...)
  }
  invisible(bibs)


}


csl_formatting <- function(bib, style = "ecology"){
    resp <- GET(paste("http://data.crossref.org", bib$doi, sep="/"), 
        add_headers(Accept = paste0("text/bibliography; style=", style)))
    content(resp)
}

