\name{citet}
\alias{citet}
\title{Add a textual citation}
\usage{
  citet(x)
}
\arguments{
  \item{x}{a doi or a bibentry}
}
\value{
  a textual inline citation
}
\description{
  Add a textual citation
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}}
}
\examples{
\dontrun{
citet("10.3998/3336451.0009.101")
bibliography()
}
}

