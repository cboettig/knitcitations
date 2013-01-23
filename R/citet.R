#' Add a textual citation 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param cito_reason Semantic reason for the citation
#' @param semantic logical, use semantic annotations?
#' @return a text inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
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
citet <- function(x, semantic=FALSE, cito_reason=c("cites",
  "citesAsAuthority", "citesAsMetadataDocument",
  "citesAsSourceDocument","citesForInformation",
  "isCitedBy","obtainsBackgroundFrom", "sharesAuthorsWith", "usesDataFrom",
  "usesMethodIn", "confirms", "credits", "extends", "obtainsSupportFrom",
  "supports", "updates", "corrects", "critiques", "disagreesWith",
  "qualifies", "refutes", "discusses", "reviews")){
  out <- cite(x, inline_format=authoryear_t)
  if(semantic){
    # Consider removing the format style from "cite" or making semantic an inline format.  
  } else {
    out <- I(paste(paste(out, collapse="; "), sep=""))
  }
}

## Helper function

## helper functions
#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_t <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s (%s)", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s (%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ (%s)", entry$author[[1]]$family, entry$year)
}



