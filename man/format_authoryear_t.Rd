\name{format_authoryear_t}
\alias{format_authoryear_t}
\title{format the author and year}
\usage{
format_authoryear_t(entry, char = "")
}
\arguments{
  \item{entry}{a bibentry}

  \item{char}{a character to append to the citation (to
  disambiguate). This is handled automatically by the cite
  function.}
}
\value{
  the author-year citation
}
\description{
  This formats a single entry, though adjusted by author.
  This function is passed down to 'cite' by 'citet', wher
  it creates the actuall formatting on the first use.
}

