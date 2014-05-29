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
#' @param create_key logical indicating whether function should create a 
#'  bibtex citation key if the object doesn't have one.  
#' @param ... additional arguments to WriteBib
#' @return a list of citation information, invisibly 
#' 
#' The 'knitcitations' package automatically extends the use of this function to
#' be able to write bibtex files from a string of DOIs, making it valuable for 
#' purposes beyond the citation of packages.  
#' 
#' @import bibtex RefManageR 
#' @examples
#'  write.bibtex(c("Yihui2013" = citation("knitr"), 
#'                 "Boettiger2013" = citation("knitcitations"), 
#'                 "TempleLang2012"=citation("RCurl")))
#'  bib <- read.bibtex("knitcitations.bib")
#' @export
#' @seealso read.bib citep citet
write.bibtex <- function(entry=NULL, file="knitcitations.bib", append=exists(file), verbose=TRUE, create_key=TRUE, ...){

  if(is.null(entry)){
    bibs <- read_cache(bibtex=get("bibtex_data", envir=knitcitations_options))
    WriteBib(as.BibEntry(bibs), file=file, append=append, ...)

  } else { 
    ## Handles the case of a list of bibentries separately.  
    ## The append is not necessary
    if(is(entry, "list") & is(entry[[1]], "bibentry")){
      if(create_key)
        entry[[1]] <- create_bibkey(entry[[1]])

      write.bib(entry[[1]], file=file, append=append, verbose=verbose)
      for(i in 2:length(entry)){
          if(create_key)
            entry[[i]] <- create_bibkey(entry[[i]])
          write.bib(entry[[i]], file=file, append=TRUE, verbose=verbose)
      }

    ## Handle the standard cases.  
    ## Also exploits the fact that append is clever enough to work on a new file
    } else {
      out <- sapply(entry, function(entry){
        if(create_key)
          entry <- create_bibkey(entry)
        write.bib(entry=entry, file=file, append=TRUE, verbose=verbose)
      })
      invisible(out)
    }
  }
}



