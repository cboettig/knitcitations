#' greycite citation method
#' 
#' Grab citation data using the greycite API
#' @param url the website URL
#' @param format have greycite return data in bib (bibtex) or json format?
#' @return a bibentry class object
#' @import httr
#' @export 
#' 
greycite <- function(url, format=c("bib","json")){
  format <- match.arg(format)
  dat <- GET(paste("http://greycite.knowledgeblog.org/", format, "/?uri=", url, sep=""))
  if(format == "bib"){
    con <- tempfile("greycite.bib")
    writeLines(content(dat, "text"), con=con)
    bib <- ReadBib(con)
    unlink(con)
  }
  bib
}
