\name{print_rdfa}
\alias{print_rdfa}
\title{format for rdfa markup of references}
\usage{
print_rdfa(bib, ordering = c("authors", "year", "title", "journal", "volume",
  "number", "pages", "doi", "uri"))
}
\arguments{
  \item{bib}{a bibentry object containing one or more
  citations}

  \item{ordering}{a character list of the order in which
  information should be printed}
}
\description{
  An internal method used by the \code{\link{bibliography}}
  function
}
\keyword{internal}

