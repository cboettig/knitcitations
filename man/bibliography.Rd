\name{bibliography}
\alias{bibliography}
\title{Generate the bibliography}
\usage{
  bibliography(style = "markdown", .bibstyle = "JSS",
    ordering = c("authors", "year", "title", "journal", "volume",
                  "number", "pages", "doi", "url"),
    sort = FALSE,
    bibtex = get("bibtex_data", envir = knitcitations_options),
    ...)
}
\arguments{
  \item{style}{formatting style to print bibliography
  (default is plain text).  Can be text, bibtex, html,
  textVersion, R, citation, or other formats defined for
  the print bibentry class, see ?print.bibentry for
  details.}

  \item{ordering}{a character list of the order in which
  information should be printed (e.g. c("author", "year",
  "title", "journal", "volume", "number", "pages", "doi",
  "uri")) see details.  Works only for rdfa and markdown
  formats at the moment. Other styles are formatted
  according to the \code{\link{bibstyle}} method, see for
  more information.}

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
  The markdown and rdfa print formats can take the argument
  `ordering`. A character string provides the order in
  which elements should be returned.  Elements not
  specified are omitted from the return entirely.  Even if
  both DOI or URI (usually the URL) are given, method will
  return the URL only if the DOI is absent/unavailable.
}
\examples{
citet(citation("knitr"))
bibliography()
## use markdown formatting, show only author, year, and url
bibliography("markdown", ordering = c("authors", "year", "url"))

## Repeat citations do not create duplicates:
bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"),
         citation("bibtex"), citation("knitr"), citation("knitcitations"),
         citation("bibtex"))
citep(bib)
bibliography()
}

