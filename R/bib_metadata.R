#' get the full metadata for a citation / bibliographic object
#' 
#' @param x a query or citation identifer, as in citep/citet, except 
#'  that it must be a single query, not a list of multiple queries.   
#' @param BibEntry logical. Coerce to RefManageR's BibEntry type?
#' @param ... additional arguments to query (see RCrossRef)
#' @return a BibEntry (or bibentry, if requested) object with
#' the required citation information.
#' @details This function is called internally by citet and citep,
#' but is also made available in the namespace for a user wanting 
#' to return the full citation object directly.   
#' @export 
bib_metadata <- function(x, BibEntry = TRUE, ...){
  if(is(x, "bibentry"))
    entry <- x
  else if(is(x, "character")){
    if(is.bibkey(x))
      entry <- get_by_bibkey(x)
    else if(is.url(x))
      entry <- greycite(x)
    else if(is.pdf(x))
      entry <- ReadPDFs(x)
    else
      entry <- ReadCrossRef(x, limit = 1, ...)
  }
  tweak(entry, BibEntry = BibEntry)
}


