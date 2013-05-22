#' Add a paranthetical citation
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param inline_format a function for formating the inline citation, 
#'  defaults to authoryear_t
#' @param format_inline_fn function to format a single inline citation
#' @param ... additional arguments passed to citet, see \code{\link{citet}} 
#'  for details
#' @param page optional page or page range that can be given as extra text.
#'   Page ranges should be separated by hyphen, giving "pp.", while single 
#'   page returns as "p." followed by page number.  
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
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
#' @examples \dontrun{
#' library(knitcitations)
#'  ## (requires internet connection)
#'  citep("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  knitcitations <- citation("knitcitations")
#'  # generate the parentetical citation for these:
#'  citep(list(knitr,knitcitations))
#'  # generate the full bibliography:
#'  bibliography()
#' ## Assign a citation key to a doi and then use it later:
#' citep(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
#' citep("Halpern2006")
#' }
citep <- function(x, ..., 
                  format_inline_fn = format_authoryear_p, 
                  inline_format = authoryear_p,
                  page = NULL){
  text <- citet(x, ..., 
                format_inline_fn = format_inline_fn,
                inline_format = inline_format) 
  if(!is.null(page)){
    pgs <- ifelse(grepl("-", page), "pp.", "p.")
    page <- paste(",", pgs, page)
  }
  paste("(", text, page, ")", sep="", collapse=";")
}
