#' print method for markdown format
#' @param bib a bibentry object containing one or more citations
#' @param ordering a character list of the order in which information should be printed 
#' An internal method used by the \code{\link{bibliography}} function
#' @keywords internal
print_markdown <- function(bib, ordering =  
                       c("authors", "year", "title", "journal",
                         "volume", "number", "pages", "doi", "uri")){
  ## create individual citations
  references <- sapply(bib, function(r){ 
    title <- paste(r$title, ".", sep="")
    authors <-      
        paste(sapply(r$author, function(x) 
               paste(x$given[1], " ", x$family, ", ", collapse="", sep=""))
              , sep="", collapse="")
    authors <- paste(" ", authors, sep="")
    year <- if(!is.null(r$year))
               paste(" (", r$year, ")", sep="")

    journal <- if(!is.null(r$journal))
      paste(" *", r$journal, "*", sep="")
    volume <- if(!is.null(r$volume))
      paste(' **', r$volume, '**', sep="")
    number <- if(!is.null(r$number))
      paste(" (", r$number, ") ", sep="")
    spage <- if(!is.null(r$page[1]))
      paste(" ", r$page[1], sep="")
    epage <- if(!is.null(r$page[2])) 
                paste('-', r$page[2], sep="")
    pages <- paste(spage, epage, sep="")
    doi  <- if(!is.null(r$doi))
      paste(' [',  r$doi, '](http://dx.doi.org/', r$doi, ')', sep="")
    uri <- if(is.null(r$doi) && !is.null(r$url))
      paste(' [',  r$url, '](', r$url, ')', sep="")

    bibline <- bib_format(ordering, authors, year, 
                          title, journal, volume, 
                          number, pages, doi, uri, collapse=" ")

    paste("\n-", bibline, sep="")
    })

  paste(paste(references, collapse="", sep=""))
}





