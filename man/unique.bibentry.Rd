\name{unique.bibentry}
\alias{unique.bibentry}
\title{A simple method to determine unique bibentries by bibkey}
\usage{
  unique.bibentry(bibentry)
}
\arguments{
  \item{a}{list of bibentries (class bibentry)}
}
\value{
  the list with duplicates removed
}
\description{
  Uses the bibkey ids to identify unique entries.  see
  uniquebib for a more detailed attempt at this, which
  still needs a bit of debugging.
}
\keyword{internal}

