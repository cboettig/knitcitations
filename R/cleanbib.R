#' cleanbib 
#'
#' @aliases reset_bib
#' Clean the log of works cited so far.
#' @export
cleanbib <- function(){
  rm(list = ls(envir = knitcitations),
     envir = knitcitations)
}

reset_bib <- cleanbib
