#' clean the bib list
#'
#' @return clears the works_cited list
#' @export
cleanbib <- function(){
  empty <- list()
  class(empty) <- "bibentry"
  options(works_cited = empty)
  options(named_dois = c(blank=""))
}



