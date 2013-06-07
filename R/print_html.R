#' print method for html format 
#' 
#' The built-in html format sucks, with unclosed p tags and mixed capital tags 
#' @param bib a bibentry object containing one or more citations
#' @param ordering a character list of the order in which information should 
#' be printed 
#' @details An internal method used by the \code{\link{bibliography}} function
#' @keywords internal
print_html <- 
function (bib, ordering = c("authors", "year", "title", "journal", 
    "volume", "number", "pages", "doi", "uri"), bulleted = TRUE) 
{
    references <- sapply(bib, function(r) {
        title <- paste(r$title, ".", sep = "")
        authors <- paste(sapply(r$author, function(x) paste(x$given[1], 
            " ", x$family, ", ", collapse = "", sep = "")), sep = "", 
            collapse = "")
        authors <- paste(" ", authors, sep = "")
        year <- if (!is.null(r$year)) 
            paste(" (", r$year, ")", sep = "")
        journal <- if (!is.null(r$journal)) 
            paste(" <em>", r$journal, "</em>", sep = "")
        volume <- if (!is.null(r$volume)) 
            paste(" <strong>", r$volume, "</strong>", sep = "")
        number <- if (!is.null(r$number)) 
            paste(" (", r$number, ") ", sep = "")
        pgs <- if (!is.null(r$pages)) 
            strsplit(r$pages, "--")[[1]]
        spage <- if (!is.null(pgs[1])) 
            paste(" ", pgs[1], sep = "")
        epage <- if (!is.null(pgs[2])) 
            paste("-", pgs[2], sep = "")
        pages <- paste(spage, epage, sep = "")
        doi <- if (!is.null(r$doi)) 
            paste(" <a href=\"http://dx.doi.org/", r$doi, "\">", 
                r$doi, "</a>", sep = "")
        uri <- if (is.null(r$doi) && !is.null(r$url)) 
            paste(" <a href=\"", r$url, "\">", r$url, "</a>", 
                sep = "")
        bibline <- bib_format(ordering, authors, year, title, 
            journal, volume, number, pages, doi, uri, collapse = " ")
        if (bulleted) {
            paste("\n-", bibline, sep = "")
        } else {
            paste("<p>", bibline, "</p>", sep = "")
        }
    })
    paste(paste(references, collapse = "", sep = ""))
}




