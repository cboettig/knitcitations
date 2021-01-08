#' cleanbib 
#'
#' Clean the log of works cited so far.
#' 
#' @return Removes log cache, returns invisible `NULL`
#' @aliases reset_bib
#' @export
cleanbib <- function(){
  rm(list = ls(envir = knitcitations),
     envir = knitcitations)
}

reset_bib <- cleanbib
