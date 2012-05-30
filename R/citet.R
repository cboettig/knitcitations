#' Add a textual citation
#'
#' @param x a doi or a bibentry 
#' @return a textual inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @examples
#' library(knitcitations) 
#' citet("10.3998/3336451.0009.101")
#' bibliography()
#'
#' @export
#' @import knitr
citet <- function(x){
  if(is.null(getOption("works_cited")))
    cleanbib()
  if(is(x, "character"))
    entry <- ref(x)
  else # assume it's a bibentry object already
    entry <- x
  if(!is(entry, "bibentry"))
    out <- I("?")
  else {
    ## keep track of what we've cited so far
    options(works_cited = c(getOption("works_cited"), entry))
   out <- I(authoryear_t(entry))
  }
  out
}


