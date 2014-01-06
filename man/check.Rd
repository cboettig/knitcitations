\name{check}
\alias{check}
\title{check if the element is present before creating a RDFa span tag for it.}
\usage{
check(tag, element)
}
\arguments{
  \item{element}{the element of the bibentry whose
  existence we check for}

  \item{tag}{preceding span tag}
}
\value{
  if the element is present, return the span tag, followed
  by the element and closing span tag.
}
\description{
  check if the element is present before creating a RDFa
  span tag for it.
}
\keyword{internal}

