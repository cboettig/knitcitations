\name{citep}
\alias{citep}
\title{Add a paranthetical citation}
\usage{
  citep(x)
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}
}
\value{
  a parenthetical inline citation
}
\description{
  Add a paranthetical citation
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}}
}
\examples{
out <- sapply(names(sessionInfo()$otherPkgs), function(x) citation(x))
  citep(out)
}

