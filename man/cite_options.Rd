\name{cite_options}
\alias{cite_options}
\title{Toggles for various citation options}
\usage{
  cite_options(tooltip = FALSE, linked = TRUE,
    numerical = FALSE, bibtex_data = FALSE)
}
\arguments{
  \item{tooltip}{Provide a javascript tooltip over the
  in-line citation?  (requires twitter-bootstrap tooltip
  JS, see details).}

  \item{linked}{Add an HTML link around the in-line
  citation?}

  \item{numerical}{Use numerical instead of author-year
  format citations?}

  \item{bibtex_data}{whether we should write to a bibtex
  file instead of the knitcitationsCache environment for
  tracking bibliographic information of what we have
  already cited.}
}
\value{
  updates the option specified for the duration of the
  session.
}
\description{
  Toggles for various citation options
}

