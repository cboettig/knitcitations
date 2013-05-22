#' write knitcitations data to a cache object instead of a file
#' 
#' @param a_bibentry a bibentry object, possibly already named with a key
#' @param bibtex logical, use a bibtex file for the cache of cited works 
#'  rather than an environment?
#' @return writes the bibentry to the environment 'knitcitationsCache'
write_cache <- function(a_bibentry, 
                        bibtex = get("bibtex_data",
                                     envir=knitcitations_options)){
  ## Create a bibkey for the entry if it doesn't have one.  
  if(is.null(names(a_bibentry))){
    a_bibentry <- create_bibkey(a_bibentry)
  }

  if(bibtex)
    write.bibtex(a_bibentry, "knitcitations.bib", append=TRUE)
  else 
    assign(names(a_bibentry), a_bibentry, knitcitationsCache)
}



read_cache <- function(bibtex=get("bibtex_data", envir=knitcitations_options)){
  if(bibtex)
    read.bibtex("knitcitations.bib")
  else {
    files <- ls(envir=knitcitationsCache)
    out <- sapply(files, get, knitcitationsCache, USE.NAMES=FALSE)
    class(out) = "bibentry"
    out
  }
}


