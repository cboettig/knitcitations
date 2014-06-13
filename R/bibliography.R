#' Generate the bibliography
#' @param ... additional arguments passed to PrintBibliography,
#' @return a list of works cited  
#' @export
bibliography <- function(...)
{
  bibs <- get_bib()
  NoCite(bibs) 
  PrintBibliography(bibs, ...)
  invisible(bibs)
}


