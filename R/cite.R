#' Add a citation (internal for citet and citep) 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @import knitr
#' @keywords internal
cite <- function(x, inline_format){

  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited")))
    cleanbib()
  ## Identify what references we already know about
  current <- bibliography(debug=TRUE)
  existing <- sapply(current, function(x) x$key)
  preset_keys <- names(x)




  out <- sapply(1:length(x),function(i){

    
    key = preset_keys[i]  ## Get the bibkey name for the current citation
    m <- match(x[[i]], existing)
    if(!is.na(m))
      entry <- current[[m]] 
    else if(is(x[[i]], "character")){
      entry <- ref(x[[i]])
      entry <- create_bibkey(entry, key=key, current=current)
    } else if(is(x[[i]], "bibentry")) {# it's a bibentry object already
      entry <- x[[i]]
      entry <- create_bibkey(entry, key=key)
    } else {
      warning("citation not found")
      entry <- I("?")
    }

    if(!is(entry, "bibentry")) # if it's not a bibentry, print "?"
      out <- I("?")
    else {
      ## keep track of what we've cited so far
      write.bibtex(entry, "knitcitations.bib", append=TRUE, verbose=TRUE)
      #options(works_cited = c(getOption("works_cited"), entry))
      out <-  inline_format(entry)
    }
    out
  })
}


