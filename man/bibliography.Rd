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
  bibliography is printed, defaults to FALSE}

  \item{sort}{logical indicating if bibliography should be
  sorted alphabetically, defaults to FALSE}

  \item{addkeys}{logical indicating if a list of keys
  should be added to the citation list, in case keys are
  not yet present.  Keys are automatically (or manually)
  added by the inline citet/citep functions, so this
  defaults to false.}

  \item{debug}{logical to turn on debug mode, which doesn't
  strip duplicates by key.  Defaults to FALSE.}
}
\value{
  a list of bibentries, providing a bibliography of what's
  been cited Note that the format can be controlled using
  "print" with different styles, see ?print.bibentry for
  details.
}
\description{
  Generate the bibliography
}
\details{
  reads in the values from the option "works_cited",
  possibly applying tidying up and formatting as well.
}
\examples{
bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
citep(bib)
bibliography()
}

