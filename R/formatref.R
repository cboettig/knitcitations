#' Convert crossref XML into a bibentry object
#' 
#' @param a crossref XML output
#' @return a bibentry format of the output
#' @details internal helper function
formatref <- function(a){
 authors <- person(family=as.list(xpathSApply(a, "//surname", xmlValue)),
                  given=as.list(xpathSApply(a, "//given_name", xmlValue)))
  suppressWarnings(
  rref <- bibentry(
        bibtype = "Article",
        title = check_missing(xpathSApply(a, "//titles/title", xmlValue)),
        author = check_missing(authors),
        journal = check_missing(xpathSApply(a, "//full_title", xmlValue)),
        year = check_missing(xpathSApply(a, 
          "//journal_article/publication_date/year", xmlValue)),
        month =xpathSApply(a, 
          "//journal_article/publication_date/month", xmlValue),
        volume = xpathSApply(a, "//journal_volume/volume", xmlValue),
        doi = xpathSApply(a, "//journal_article/doi_data/doi", xmlValue),
        issn = xpathSApply(a, "//issn[@media_type='print']", xmlValue),
#        url = xpathSApply(a, "//journal_article/doi_data/resource", xmlValue)
        )
  )
}

# Title, author, journal, & year cannot be missing, so return "NA" if they are
# Avoid errors in bibentry calls when a required field is not specified.   
check_missing <- function(x){
 if(length(x)==0)
  out <- "NA"
 else 
  out <- x
  out
}


