\name{cite}
\alias{cite}
\title{Add a citation (internal for citet and citep)}
\usage{
  cite(x, bibtex = getOption("bibtex_data"))
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}

  \item{bibtex}{internal logical indicating if we use a
  cache or external bibtex file}
}
\value{
  a parenthetical inline citation
}
\description{
  Add a citation (internal for citet and citep)
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}}
}
\examples{
citep("10.3998/3336451.0009.101")
}
\keyword{internal}

