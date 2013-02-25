#' Specify the order in which citation elements should be returned
#' 
#' An internal function used by methods such as print_rdfa
#' and print_markdown to specify a custom odering of the elements.
#' 
#' @param ordering a character string giving the ordering of elements
#' @param authors the author element
#' @param year the year element
#' @param title element
#' @param journal journal element
#' @param volume volume element
#' @param number isue number element
#' @param pages the pages element
#' @param doi the doi element
#' @param uri the URL element
#' @param collapse the collapse value passed to paste (e.g. separate with spaces only)
#' @details currently not possible to specify custom markup 
#' (quotations, bold, italics, etc) though this could be added
#' more or less without changing the API. 
#' @keywords internal
#' 
bib_format <- function(ordering = 
                       c("authors", "year", "title", "journal",
                         "volume", "number", "pages", "doi", "url"),
                       authors, year, title, journal, volume, 
                       number, pages, doi, uri, collapse=" "){

  ## FIXME consider using pmatch first so that things line vol and author
  ## work in ordering, rather than needing the full term.  
  dat <- list(authors=authors, year=year, title=title,
              journal=journal, volume=volume, number=number,
              pages=pages, doi=doi, url=uri)

  paste(unlist(dat[ordering]), collapse=collapse, sep="")
}
