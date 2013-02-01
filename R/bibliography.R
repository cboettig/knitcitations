#' Generate the bibliography
#' @param style formatting style to print bibliography (default is HTML).  Can be 
#' text, bibtex, html, or other formats defined forthe print bibentry class, 
#' see ?print.bibentry for details.  
#' @param sort logical indicating if bibliography should be sorted
#' alphabetically, defaults to FALSE
#' @param bibtex logical, use bibtex data structure internally? (internal option only) 
#' @return a list of bibentries, providing a bibliography of what's been cited
#' @details reads in the values from the option "works_cited",
#' possibly applying tidying up and formatting as well.
#' @examples 
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' citep(bib)
#' bibliography()
#' 
#' @export
bibliography <- function(style="html", sort=FALSE, bibtex=getOption("bibtex_data")){
  out <- read_cache(bibtex=bibtex)
  if(length(out)>0){
    if(sort){   
      ordering <- sort(names(out))
      out <- out[ordering]
    }
  }
  invisible(output <- print(out, style))
}




####### Methods below are depricated ###########

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

