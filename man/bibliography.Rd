\name{bibliography}
\alias{bibliography}
\title{Generate the bibliography}
\usage{
  bibliography(style = "html", sort = FALSE,
    bibtex = getOption("bibtex_data"))
}
\arguments{
  \item{style}{formatting style to print bibliography
  (default is HTML).  Can be text, bibtex, html, or other
  formats defined forthe print bibentry class, see
  ?print.bibentry for details.}

  \item{sort}{logical indicating if bibliography should be
  sorted alphabetically, defaults to FALSE}

  \item{bibtex}{logical, use bibtex data structure
  internally? (internal option only)}
}
\value{
  a list of bibentries, providing a bibliography of what's
  been cited
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

