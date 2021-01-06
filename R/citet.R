#' citet - inline text citation
#' 
#' Generate an inline text citation
#' @param x a citation query, or list of queries for multiple citations. See details and examples 
#' @param ... additional arguments for the search or formatting. See details.  
#' @details the citation query can be any of: 
#' - A bibentry object, 
#' - An article or dataset DOI,
#' - The URL to a website such as a scientific journal article page 
#' - A path to a PDF file (will attempt to extract citation info)
#' - A search query string, such as part of the article title, 
#'   year, or journal (Queries CrossRef)
#' - The bibkey to anything that has already been cited. 
#'  knitcitations will attempt to find the most complete citation information
#'  based on the information specified.  In some cases that information may
#'  be incomplete.  When using search queries rather than an exact reference
#'  (such as URL, DOI, pdf, or bibkey) the desired article may not be found or
#'  many not be uniquely determined by the string. The most relevant search
#'  result is returned, so consider refining search terms as necessary.
#'  See examples.
#'
#' @return Format of the text citation will depend on configuration. Unless 
#'   citation_format = "pandoc", formatting is handled by
#'   \code{\link[RefManageR]{Citet}}. See the arguments to Citet for details.
#'   knitcitations will automatically track what has been cited during the
#'   active R session until the citation log is reset.
#'
#' @seealso \code{\link[RefManageR]{Citep}} for more details on the inline text
#'   citation generation.  \code{\link{citep}} for generating parenthetical
#'   citations.
#'
#' @examples 
#' # Cite an R package using the 'bibentry' object
#' citet(citation("httr"))
#' 
#' @import RefManageR digest
#' @export
citet <- function(x, ...){
  bib <- do.call(c, lapply(x, knit_cite, ...))
  citation_format = getOption("citation_format", "text")
  if(citation_format == "pandoc")
    paste0("@", sapply(bib, function(b) b$key), collapse=", ")
  else 
    Citet(bib, ...)
}

