#' write a bibtex file
#'
#' @param entry a 'bibentry' object or list of bibentry objects.
#'        If NULL, writes all that have currently been cited.
#' @param file output bibtex file. Will automatically append '.bib' if not
#'  added. if 'NULL' will use stdout.
#' @param append a logical indicating that bibtex entries be added the the
#'  file.  If FALSE (default), the file is overwritten.
#' @param ... additional arguments to WriteBib
#' @return a list of citation information, invisibly
#' @import RefManageR
#' @examples
#'  tmp <- tempfile(fileext=".bib")
#'  write.bibtex(c(citation("knitr"),
#'                 citation("knitcitations"),
#'                 citation("httr")),
#'                file = tmp)
#'  bib <- read.bibtex(tmp)
#' @export
#' @seealso read.bib citep citet
write.bibtex <- function(entry = NULL,
                         file = "knitcitations.bib",
                         append = FALSE,
                         ...){

  if(is.null(entry)){
    entry <- get_bib()

  } else if(is(entry, "bibentry")){
    entry <- as.BibEntry(entry)

  } else {
    stop(paste("entry object of class", class(entry), "not recognized"))

  }

  keys <- vapply(
    entry,
    function(e) {
      key <- e$key
      if (is.null(key))
        key <- NA_character_
      key
    },
    character(1L)
  )

  WriteBib(entry[order(keys)], file=file, append=append, ...)
}


#' read.bibtex
#' @param file string; bib file to parse.
#' @param  .Encoding encoding
#' @param check error, warn, or logical FALSE.  What action should be
#'        taken if an entry is missing required fields?  FALSE means
#'        no checking is done, warn means entry is added with an
#'        error. error means the entry will not be added.  See
#'        BibOptions.
#' @import RefManageR
#' @return Returns the bib object
#' @export
read.bibtex <- function(file, .Encoding = "UTF-8", check=FALSE)
  ReadBib(file, .Encoding=.Encoding, header=NULL, footer = NULL, check=check)
