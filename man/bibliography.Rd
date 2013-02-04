\name{bibliography}
\alias{bibliography}
\title{Generate the bibliography}
\usage{
  bibliography(style = "textVersion", .bibstyle = "JSS",
    sort = FALSE, bibtex = getOption("bibtex_data"), ...)
}
\arguments{
  \item{style}{formatting style to print bibliography
  (default is plain text).  Can be text, bibtex, html,
  textVersion, R, citation, or other formats defined forthe
  print bibentry class, see ?print.bibentry for details.}

  \item{sort}{logical indicating if bibliography should be
  sorted alphabetically, defaults to FALSE}

  \item{bibtex}{logical, use bibtex data structure
  internally? (internal option only)}

  \item{.bibstyle}{the bibstyle function call or string.
  Defaults to journal of statistical software (JSS).  See
  \code{\link{bibstyle}}.}

  \item{...}{additional arguments passed to print.bibentry,
  see \code{\link{bibentry}}}
}
\value{
  a list of bibentries, providing a bibliography of what's
  been cited
}
\description{
  Generate the bibliography
}
\details{
  Formating of the return data is handled by bibentry
  printing methods.
}
\examples{
bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
citep(bib)
bibliography()
}

