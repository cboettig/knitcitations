\name{knitcitations_data}
\alias{knitcitations_data}
\title{Helper function to get knit data}
\usage{
  knitcitations_data(bibtex = getOption("bibtex_data"))
}
\arguments{
  \item{bibtex}{the option to use bibtex}

  \item{the}{updated value of the option to use bibtex}
}
\description{
  Helper function to get knit data
}
\details{
  creates a cache environment and a bibfile.  Should
  probably create only one of these.
}
\keyword{internal}

