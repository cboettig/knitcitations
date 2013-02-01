\name{write.bibtex}
\alias{write.bibtex}
\title{write a bibtex file}
\usage{
  write.bibtex(entry, file = "knitcitations.bib",
    append = FALSE, verbose = TRUE, create_key = TRUE)
}
\arguments{
  \item{entry}{a 'bibentry' object, list of bibentry
  objects, or a character vector of package names}

  \item{file}{output bibtex file. Will automatically append
  '.bib' if not added.  if 'NULL' will use stdout.}

  \item{append}{a logical indicating that bibtex entries be
  added the the file.  If FALSE (default), the file is
  overwritten.}

  \item{verbose}{a logical to toggle verbosity. If
  'file=NULL', verbosity is forced off.}

  \item{create_key}{logical indicating whether function
  should create a bibtex citation key if the object doesn't
  have one.}
}
\value{
  a list of citation information, invisibly

  The 'knitcitations' package automatically extends the use
  of this function to be able to write bibtex files from a
  string of DOIs, making it valuable for purposes beyond
  the citation of packages.
}
\description{
  write a bibtex file
}
\examples{
write.bibtex(c("Yihui2013" = citation("knitr"), "Boettiger2013" = citation("knitcitations"), "TempleLang2012"=citation("RCurl")))
 bib <- read.bibtex("knitcitations.bib")
}
\seealso{
  read.bib citep citet
}

