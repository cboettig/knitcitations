\name{cite}
\alias{cite}
\title{Add a citation (internal for citet and citep)}
\usage{
  cite(x,
    bibtex = get("bibtex_data", envir = knitcitations_options),
    format_inline_fn = format_authoryear_p)
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}

  \item{bibtex}{internal logical indicating if we use a
  cache or external bibtex file}

  \item{format_inline_fn}{a function which will create the
  inline citation format (stored with the entry to avoid
  non-unique citation styles, e.g. Boettiger 2012a,
  Boettiger 2012b.)}
}
\value{
  a parenthetical inline citation
}
\description{
  Add a citation (internal for citet and citep)
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}}
}
\examples{
citep("10.3998/3336451.0009.101")
}

