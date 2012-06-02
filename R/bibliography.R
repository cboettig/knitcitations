#' Generate the bibliography
#' @param erase logical indicating that bibliographic list generated
#' during this session will be erased after the bibliography is printed
#' @return the markdown formatted bibliography of what's been cited
#' @details reads in the values from the option "works_cited",
#' possibly applying tidying up and formatting as well. 
#' @export
bibliography <- function(erase=FALSE, sort=FALSE, addkeys=FALSE, debug=FALSE){
  out <- getOption("works_cited")
  if(!debug)
    out <- unique.bibentry(out)
  if(addkeys) 
    out <- create_bibkeys(out) 
  if(sort){   # Not yet supported
    ordering <- sort(names(out))
  }
  if(erase)
    cleanbib()
  out
}



#' A simple method to determine unique bibentries by bibkey
#'
#' Uses the bibkey ids to identify unique entries.  see uniquebib 
#' for a more detailed attempt at this, which still needs a bit 
#' of debugging.  
#' @param a list of bibentries (class bibentry)
#' @return the list with duplicates removed
#' @keywords internal
#' 
unique.bibentry <- function(bibentry){
  bibentry[unique(sapply(bibentry, function(x) x$key))]
}
  

#' Return only unique entries in a list of bibentries
#' @param a list of bibentries (class bibentry)
#' @return the list with duplicates removed
#' @examples
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' knitcitations:::unique.bibentry(bib)
#' @keywords internal
# Needs debugging for this method to work
uniquebib <- function(bibentry){
  
  hits <- TRUE
  i <- 1
  while(any(hits) & length(bibentry) > i){
    range <- 1:length(bibentry)
    hits <- sapply(bibentry[range], function(x) identical(x, bibentry[[i]]))
    index <- which(hits)
    if(length(index) > 1)
      index <- index[-1]
    if(any(hits) & length(index) > 0)
      bibentry <- bibentry[-index]
    i <- i+1
  }
  bibentry
}



#' Helper function to make a list of bibentry objects into a single bibentry object containing multiple entries
#' @param bib a list of bibentry objects.  If already a bibentry class with multiple entries, function returns the input.  
#' @return a bibentry object with multiple entries
#' @examples
#' bib <- c(citation("knitr"), citation("bibtex"), citation("knitcitations"))
#'  a <- lapply(bib, knitcitations:::create_bibkey)
#' knitcitations:::list_to_bibentry(a)
#' @keywords internal 
list_to_bibentry <- function(bib){
  if(is(bib, "bibentry"))
    out <- bib
  else if(is(bib, "list")){
    l <- length(bib)
    out <- bib[[1]]
    for(i in 2:l)
      out <- c(out, bib[[i]])
  }
  out 
}

