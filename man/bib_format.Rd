\name{bib_format}
\alias{bib_format}
\title{Specify the order in which citation elements should be returned}
\usage{
  bib_format(ordering = c("authors", "year", "title", "journal", "volume", "number", "pages", "doi", "uri"),
    authors, year, title, journal, volume, number, pages,
    doi, uri, collapse = " ")
}
\description{
  An internal function used by methods such as print_rdfa
  and print_markdown to specify a custom odering of the
  elements.
}
\details{
  currently not possible to specify custom markup
  (quotations, bold, italics, etc) though this could be
  added more or less without changing the API.
}

