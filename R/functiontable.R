

#' a table of functions in a package
#' 
#' This function takes a package name an generates a two-column table 
#' with the names of each function in the package and the short description
#' from the help documentation.  
#' @param pkg a string specifying the name of a package,
#' @param ... additional arguments to xtable
#' @return the output of xtable (as html, or specify type="latex")
#' @details useful for Sweave/knit manuals specifying a table of functions
#' Note that xtable format can also be set with \code{options(xtable.type="latex")}
#' \code{or options(xtable.type="html")}.  
#' This function modified from DWin's solution on StackOverflow.com,
#' http://stackoverflow.com/questions/7326808/getting-the-list-of-functions-in-an-r-package-to-be-used-in-latex
#' @export
#' @import xtable
#' @examples functiontable("xtable") 
functiontable <- function(pkg, ...){
  tst<-library(help=pkg, character.only=TRUE)$"info"[[2]]
  tdf <- data.frame("function name" = unlist(lapply(
                               strsplit(sub("\\s+", "\t", tst), "\t"), 
                               "[", 1)),
                    description = unlist(lapply(
                               strsplit(sub("\\s+", "\t", tst), "\t"), 
                               "[", 2)) )
  xtable(tdf, ...)
}
