#' Add a citation (internal for citet and citep) 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @import knitr
#' @keywords internal
cite <- function(x, inline_format){

  knitcitations_data()
  ## initialize the works cited list if not avaialble
  #if(is.null(getOption("works_cited")))
  #  cleanbib()
  ## Identify what references we already know about
  current <- read.bibtex("knitcitations.bib")
  existing <- names(current) 
  given_keys <- names(x) # if any keys are specified in the citation call




  out <- sapply(1:length(x),function(i){
    
    key = given_keys[i]  ## Get the bibkey name for the current citation
    m <- match(x[[i]], existing)  

    ## Handle anything we've already cited so far.  
    if(!is.na(m)){
      entry <- current[[m]] 

                ## Handle anything we haven't cited yet
    } else {
      ## Handle lookups by DOI or Bibtex Key using `ref()` function
      if(is(x[[i]], "character")){
        entry <- ref(x[[i]])
        entry <- create_bibkey(entry, key=key, current=current)

      ## Handle bibentry types 
      } else if(is(x[[i]], "bibentry")) {
        entry <- x[[i]]
        entry <- create_bibkey(entry, key=key)
      ## Handle exceptions
      } else {
        warning("citation not found")
        entry <- I("?")
      }
          ## Now enter the citation into the bibliographic list
          
      # Handle look-up failures, probably due to `ref()` call failing
      if(!is(entry, "bibentry")){ 
        entry <- I("?")
      } else {
        write.bibtex(entry, "knitcitations.bib", append=TRUE)
        #options(works_cited = c(getOption("works_cited"), entry))
      }
    }
    inline_format(entry)
  })
}


