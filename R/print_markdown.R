#' print method for markdown format
#' 
#' An internal method used by the \code{\link{bibliography}} function
#' @keywords internal
print_markdown <- function(bib){
  ## create individual citations
  references <- sapply(bib, function(r){ 
    title <- paste(r$title, ".", sep="")
    authors <-      
        paste(sapply(r$author, function(x) 
               paste(x$given[1], " ", x$family, ", ", collapse="", sep=""))
              , sep="", collapse="")
    authors <- paste(" ", authors)
    pdate <- if(!is.null(r$year))
               paste(" (", r$year, ")", sep="")

    journal <- if(!is.null(r$journal))
      paste(" *", r$journal, "*,", sep="")
    volume <- if(!is.null(r$volume))
      paste(' **', r$volume, '**', sep="")
    issue <- if(!is.null(r$number))
      paste(" (", r$number, ") ", sep="")
    spage <- if(!is.null(r$page[1]))
      paste(" ", r$page[1], sep="")
    epage <- if(!is.null(r$page[2])) 
                paste('-', r$page[2], sep="")
    doi  <- if(!is.null(r$doi))
      paste(' [',  r$doi, '](http://dx.doi.org/', r$doi, ')', sep="")
    uri <- if(is.null(r$doi) && !is.null(r$url))
      paste(' [',  r$url, '](', r$url, ')', sep="")

    paste("\n-", authors, pdate, title, journal,
          volume, issue, spage, epage, doi, uri, sep="")
    })

  paste(paste0(references, collapse=""))
}





