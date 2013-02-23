\name{write_cache}
\alias{write_cache}
\title{write knitcitations data to a cache object instead of a file}
\usage{
  write_cache(a_bibentry,
    bibtex = get("bibtex_data", envir = knitcitations_options))
}
\arguments{
  \item{a_bibentry}{a bibentry object, possibly already
  named with a key}

  \item{bibtex}{logical, use a bibtex file for the cache of
  cited works rather than an environment?}
}
\value{
  writes the bibentry to the environment
  'knitcitationsCache', created by
}
\description{
  write knitcitations data to a cache object instead of a
  file
}

