#' Add a paranthetical citation
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param inline_format a function for formating the inline citation, defaults to authoryear_t
#' @param ... additional arguments that are bassed to \code{\link{citet}}.  
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @export
#' @import knitr
#' @examples
#' library(knitcitations)
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
#' 
citep <- function(x, inline_format = authoryear_p, ...) 
  citet(x, inline_format = inline_format, ...) 

## Helper function

#' format the author and year parenthetically
#' @param entry a bibentry
#' @return the author-year citation
authoryear_p <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, %s", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s, %s", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ %s", entry$author[[1]]$family, entry$year)
}


