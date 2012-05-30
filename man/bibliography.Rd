\name{bibliography}
\alias{bibliography}
\title{Generate the bibliography}
\usage{
  bibliography(erase = FALSE, sort = FALSE,
    addkeys = FALSE, debug = FALSE)
}
\arguments{
  \item{erase}{logical indicating that bibliographic list
  generated during this session will be erased after the
  bibliography is printed}
}
\value{
  the markdown formatted bibliography of what's been cited
}
\description{
  Generate the bibliography
}
\details{
  reads in the values from the option "works_cited",
  possibly applying tidying up and formatting as well.
}

