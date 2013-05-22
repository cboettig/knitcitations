#' read in bibtex and use key as list names
#'
#' @param bibfile a bibtex .bib file
#' @return a list of citation information
#' @details this differs from read.bib in that the list is named.
#'  this allows one to use citep(bib[c("key1", "key2")]
#' @import bibtex
#' @export
#' @seealso read.bib citep citet
read.bibtex <- function(bibfile){
  bibs <- read.bib(bibfile)
  keys <- lapply(bibs, function(entry) entry$key)
  names(bibs) <- keys
  bibs
}


