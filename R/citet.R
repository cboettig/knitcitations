#' Add a textual citation 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param cito Semantic reason for the citation
#' @param format_inline_fn function to format a single inline citation
#' @param inline_format a function for formating the inline citation, defaults to authoryear_t (designed for internal use only)
#' @return a text inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}.
#' A variety of reasons for the citation can be provided following the
#' CiTO ontology: 
#' c("cites","citesAsAuthority", "citesAsMetadataDocument",
#'   "citesAsSourceDocument","citesForInformation",
#'   "isCitedBy","obtainsBackgroundFrom", "sharesAuthorsWith", "usesDataFrom",
#'   "usesMethodIn", "confirms", "credits", "extends", "obtainsSupportFrom",
#'   "supports", "updates", "corrects", "critiques", "disagreesWith",
#'   "qualifies", "refutes", "discusses", "reviews")
#' @export
#' @import knitr
#' @examples
#' library(knitcitations)
#'  citet("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  citet(knitr)
#'  # generate the full bibliography:
#'  bibliography()
#' ## Assign a citation key to a doi and then use it later:
#' citet(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
#' citet("Halpern2006")
#'


citet <- function(x, cito = NULL, format_inline_fn = format_authoryear_t,  inline_format = authoryear_t){
  out <- cite(x, format_inline_fn = format_inline_fn)
  if(length(out) == 1){
    if(!is.null(cito)){ # only works with one entry at a time...
    output <- paste('<a rel="http://purl.org/spar/cito/', cito, '", href="http://dx.doi.org/', out[[1]]$doi, '">', I(inline_format(out[[1]])), '</a>', sep="")
    # Consider removing the format style from "cite" or making semantic an inline format.  
    } else {
      output <- inline_format(out)
    }
  } else {
    output <- paste(sapply(out, inline_format), collapse="; ", sep="")
  }
  output
}

## Helper function

