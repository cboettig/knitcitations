\name{citet}
\alias{citet}
\title{Add a textual citation}
\usage{
citet(x, cito = NULL, tooltip = get("tooltip", envir =
  knitcitations_options), linked = get("linked", envir =
  knitcitations_options), numerical = get("numerical", envir =
  knitcitations_options), format_inline_fn = format_authoryear_t,
  inline_format = authoryear_t, page = NULL)
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}

  \item{cito}{Semantic reason for the citation. Only active
  if linked=TRUE}

  \item{tooltip}{Show a citation information on mouseover.
  Requires the tooltip javascript from
  http://twitter.github.com/bootstrap Pass logical
  TRUE/FALSE or set default behavior with
  \code{\link{cite_options}}}

  \item{linked}{link the inline citation text to the
  resource by doi (if available) or url? Pass logical
  TRUE/FALSE or set default behavior with
  \code{\link{cite_options}}}

  \item{numerical}{use citation instead of author-year
  format? (Not functional yet!) Pass logical TRUE/FALSE or
  set default behavior with \code{\link{cite_options}}}

  \item{format_inline_fn}{function to format a single
  inline citation}

  \item{inline_format}{a function for formating the inline
  citation, defaults to authoryear_t (designed for internal
  use only)}

  \item{page}{optional page range added after citation}
}
\value{
  a text inline citation
}
\description{
  Parameters listed here are the same for parenthetical
  citation, \code{\link{citep}}.
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}}. A variety
  of reasons for the citation can be provided following the
  CiTO ontology: c("cites","citesAsAuthority",
  "citesAsMetadataDocument",
  "citesAsSourceDocument","citesForInformation",
  "isCitedBy","obtainsBackgroundFrom", "sharesAuthorsWith",
  "usesDataFrom", "usesMethodIn", "confirms", "credits",
  "extends", "obtainsSupportFrom", "supports", "updates",
  "corrects", "critiques", "disagreesWith", "qualifies",
  "refutes", "discusses", "reviews")
}
\examples{
library(knitcitations)
 citet("10.3998/3336451.0009.101")
 ## Read in the bibtex information for some packages:
 knitr <- citation("knitr")
 citet(knitr)
 # generate the full bibliography:
 bibliography()
## Assign a citation key to a doi and then use it later:
citet(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
citet("Halpern2006")
}

