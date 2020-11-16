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
  if(dat$status_code == 200){
    if(format == "bib"){
      con <- tempfile("greycite.bib")
      writeLines(content(dat, "text"), con=con)
      bib <- ReadBib(con)
      unlink(con)
    }
  } else {
    warning("cannot reach Greycite API")
    bib <- bibentry(bibtype = "misc", author="Unknown", 
                    title="Unknown", url = url, 
                    howpublished=paste0("\\url{", url, "}"),
                    year=format(Sys.Date(), "%Y"),
                    note = paste("Accessed", Sys.Date()))
  }
  bib
}
