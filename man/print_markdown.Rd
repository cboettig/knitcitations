\name{print_markdown}
\alias{print_markdown}
\title{print method for markdown format}
\usage{
print_markdown(bib, ordering = c("authors", "year", "title", "journal",
  "volume", "number", "pages", "doi", "uri"))
}
\arguments{
  \item{bib}{a bibentry object containing one or more
  citations}

  \item{ordering}{a character list of the order in which
  information should be printed}
}
\description{
  print method for markdown format
}
\details{
  An internal method used by the \code{\link{bibliography}}
  function
}
\keyword{internal}

