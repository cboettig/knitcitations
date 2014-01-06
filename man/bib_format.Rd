\name{bib_format}
\alias{bib_format}
\title{Specify the order in which citation elements should be returned}
\usage{
bib_format(ordering = c("authors", "year", "title", "journal", "volume",
  "number", "pages", "doi", "url"), authors, year, title, journal, volume,
  number, pages, doi, uri, collapse = " ")
}
\arguments{
  \item{ordering}{a character string giving the ordering of
  elements}

  \item{authors}{the author element}

  \item{year}{the year element}

  \item{title}{element}

  \item{journal}{journal element}

  \item{volume}{volume element}

  \item{number}{isue number element}

  \item{pages}{the pages element}

  \item{doi}{the doi element}

  \item{uri}{the URL element}

  \item{collapse}{the collapse value passed to paste (e.g.
  separate with spaces only)}
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
\keyword{internal}

