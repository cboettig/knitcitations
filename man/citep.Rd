\name{citep}
\alias{citep}
\title{Add a paranthetical citation}
\usage{
  citep(x, ..., format_inline_fn = format_authoryear_p,
    inline_format = authoryear_p)
}
\arguments{
  \item{x}{a doi or list of dois, or a bibentry (or list of
  bibentries)}

  \item{inline_format}{a function for formating the inline
  citation, defaults to authoryear_t}

  \item{format_inline_fn}{function to format a single
  inline citation}

  \item{...}{additional arguments passed to citet, see
  \code{\link{citet}} for details}
}
\value{
  a parenthetical inline citation
}
\description{
  Add a paranthetical citation
}
\details{
  Stores the full citation in a "works_cited" list, which
  can be printed with \code{\link{bibliography}} A variety
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
 citep("10.3998/3336451.0009.101")
 ## Read in the bibtex information for some packages:
 knitr <- citation("knitr")
 knitcitations <- citation("knitcitations")
 # generate the parentetical citation for these:
 citep(list(knitr,knitcitations))
 # generate the full bibliography:
 bibliography()
## Assign a citation key to a doi and then use it later:
citep(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
citep("Halpern2006")
}

