\name{list_to_bibentry}
\alias{list_to_bibentry}
\title{Helper function to make a list of bibentry objects into a single bibentry object containing multiple entries}
\usage{
  list_to_bibentry(bib)
}
\arguments{
  \item{bib}{a list of bibentry objects.  If already a
  bibentry class with multiple entries, function returns
  the input.}
}
\value{
  a bibentry object with multiple entries
}
\description{
  Helper function to make a list of bibentry objects into a
  single bibentry object containing multiple entries
}
\examples{
bib <- c(citation("knitr"), citation("bibtex"), citation("knitcitations"))
 a <- lapply(bib, knitcitations:::create_bibkey)
knitcitations:::list_to_bibentry(a)
}
\keyword{internal}

