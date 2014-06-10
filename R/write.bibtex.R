#' write a bibtex file  
#'
#' @param entry a 'bibentry' object, list of bibentry objects, or a character
#'  vector of package names. If NULL, writes all that have currently been cited. 
#' @param file output bibtex file. Will automatically append '.bib' if not
#'  added. if 'NULL' will use stdout.  
#' @param append a logical indicating that bibtex entries be added the the
#'  file.  If FALSE (default), the file is overwritten.  
#' @param verbose a logical to toggle verbosity. If 'file=NULL', verbosity 
#'  is forced off.
#' @param ... additional arguments to WriteBib
#' @return a list of citation information, invisibly 
#' @import bibtex RefManageR 
#' @examples
#'  write.bibtex(c("Yihui2013" = citation("knitr"), 
#'                 "Boettiger2013" = citation("knitcitations"), 
#'                 "TempleLang2012"=citation("RCurl")))
#'  bib <- read.bibtex("knitcitations.bib")
#' @export
#' @seealso read.bib citep citet
write.bibtex <- function(entry = NULL, 
                         file = "knitcitations.bib", 
                         append = FALSE, 
                         ...){

  if(is.null(entry)){
    entry <- get_bib() 

  } else if(is(entry, "bibentry")){
    entry <- as.BibEntry(entry)

  } else {
    stop(paste("entry object of class", class(entry), "not recognized"))
  
  }

  WriteBib(entry, file=file, append=append, ...)
}


#' read.bibtex
#' @import RefManageR
#' @export
read.bibtex <- ReadBib
