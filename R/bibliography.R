#' Generate the bibliography
#' @param style formatting style to print bibliography (default is HTML).  Can be 
#' text, bibtex, html, or other formats defined forthe print bibentry class, 
#' see ?print.bibentry for details.  
#' @param erase logical indicating that bibliographic list generated
#' during this session will be erased after the bibliography is printed,
#' defaults to FALSE
#' @param sort logical indicating if bibliography should be sorted
#' alphabetically, defaults to FALSE
#' @param addkeys logical indicating if a list of keys should be added
#' to the citation list, in case keys are not yet present.  Keys are 
#' automatically (or manually) added by the inline citet/citep functions,
#' so this defaults to false.
#' @param debug logical to turn on debug mode, which doesn't strip 
#' duplicates by key.  Defaults to FALSE.  
#' @return a list of bibentries, providing a bibliography of what's been cited
#' @details reads in the values from the option "works_cited",
#' possibly applying tidying up and formatting as well.
#' @examples 
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' citep(bib)
#' bibliography()
#' 
#' @export
bibliography <- function(style="html", erase=FALSE, sort=FALSE, addkeys=FALSE, debug=FALSE){
  out <- getOption("works_cited")
  if(!debug)
    out <- unique.bibentry(out)
  if(addkeys) 
    out <- create_bibkeys(out) 
  if(sort){   
    ordering <- sort(names(out))
    out <- out[ordering]
  }
  if(erase)
    cleanbib()
  invisible(I(print(out, style=style)))
}



#' A simple method to determine unique bibentries by bibkey
#'
#' Uses the bibkey ids to identify unique entries.  see uniquebib 
#' for a more detailed attempt at this, which still needs a bit 
#' of debugging.  
#' @param a list of bibentries (class bibentry)
#' @return the list with duplicates removed
#' @keywords internal
unique.bibentry <- function(bibentry){
  bibentry[unique(sapply(bibentry, function(x) x$key))]
}
  

#' Return only unique entries in a list of bibentries
#' @param a list of bibentries (class bibentry)
#' @return the list with duplicates removed
#' @examples
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' knitcitations:::uniquebib(bib)
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

