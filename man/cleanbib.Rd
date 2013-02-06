\name{cleanbib}
\alias{cleanbib}
\title{Erase existing list of works cited}
\usage{
  cleanbib(bibtex = getOption("bibtex_data"))
}
\arguments{
  \item{bibtex}{logical, internal use parameter only.}
}
\description{
  Erase existing list of works cited
}
\details{
  simply overwrites knitcitations.bib in bibtex data
  logging mode. (which means bibtex is used for internal
  data; not that the input data comes from bibtex. Input
  data can come from any source, bibtex or DOI, as shown in
  the documentation).
}

