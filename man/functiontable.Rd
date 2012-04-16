\name{functiontable}
\alias{functiontable}
\title{a table of functions in a package}
\usage{
  functiontable(pkg, ...)
}
\arguments{
  \item{pkg}{a string specifying the name of a package,}

  \item{...}{additional arguments to xtable}
}
\value{
  the output of xtable (as html, or specify type="latex")
}
\description{
  This function takes a package name an generates a
  two-column table with the names of each function in the
  package and the short description from the help
  documentation.
}
\details{
  useful for Sweave/knit manuals specifying a table of
  functions Note that xtable format can also be set with
  \code{options(xtable.type="latex")} \code{or
  options(xtable.type="html")}. This function modified from
  DWin's solution on StackOverflow.com,
  http://stackoverflow.com/questions/7326808/getting-the-list-of-functions-in-an-r-package-to-be-used-in-latex
}
\examples{
functiontable("xtable")
}

