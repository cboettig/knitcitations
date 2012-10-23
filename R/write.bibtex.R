#' write a bibtex file  
#'
#' @param entry a 'bibentry' object, list of bibentry objects, or a character vector of package names
#' @param file output bibtex file. Will automatically append '.bib' if not added.
#'   if 'NULL' will use stdout.  
#' @param append a logical indicating that bibtex entries be added the the file.  
#'  If FALSE (default), the file is overwritten.  
#' @param verbose a logical to toggle verbosity. If 'file=NULL', verbosity is
#'  forced off.
#' @return a list of citation information, invisibly
#' @details This function is simply a wrapper to the function write.bib 
#' by Renaud Gaujoux.  Though that function has been added to the 'bibtex'
#' package by Romain Francois (a more sensible place to find it), that version
#' was not avialble on CRAN at the time of writing.  
#' 
#' The 'knitcitations' package automatically extends the use of this function to
#' be able to write bibtex files from a string of DOIs, making it valuable for 
#' purposes beyond the citation of packages.  
#' 
#' @import bibtex pkgmaker
#' @examples
#'  write.bibtex(c('bibtex', 'knitr', 'knitcitations'), file="example.bib")
#'  refs <- lapply(c("10.1111/j.1461-0248.2005.00827.x","10.1890/11-0011.1"), ref)
#'  write.bibtex(refs, file="refs.bib")
#' 
#' @export
#' @seealso read.bib citep citet
write.bibtex <- function(entry, file="knitcitations.bib", append=FALSE, verbose=TRUE){
  if(is(entry, "list") & is(entry[[1]], "bibentry")){    
    write.bib(entry[[1]], file=file, append=append, verbose=verbose)
    for(i in 2:length(entry))
      write.bib(entry[[i]], file=file, append=TRUE, verbose=verbose)
  } else {
    write.bib(entry=entry, file=file, append=append, verbose=verbose)
  }
}



