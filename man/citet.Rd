\name{citet}
\alias{citet}
\title{Add a textual citation}
\usage{
  citet(x, cito = NULL, inline_format = authoryear_t)
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}

  \item{cito}{Semantic reason for the citation}

  \item{inline_format}{a function for formating the inline
  citation, defaults to authoryear_t}
}
\value{
  a text inline citation
}
\description{
  Add a textual citation
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

