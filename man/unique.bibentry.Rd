\name{unique.bibentry}
\alias{unique.bibentry}
\title{Return only unique entries in a list of bibentries}
\usage{
  unique.bibentry(bibentry)
}
\arguments{
  \item{a}{list of bibentries (class bibentry)}
}
\value{
  the list with duplicates removed
}
\description{
  Return only unique entries in a list of bibentries
}
\examples{
bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
knitcitations:::unique.bibentry(bib)
}
\keyword{internal}

