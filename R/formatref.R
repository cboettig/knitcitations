#' Convert crossref XML into a bibentry object
#'
#' @param a crossref XML output
#' @return a bibentry format of the output
#' @details internal helper function
#' @keywords internal
formatref <- function(a){
 authors <- person(family=check_missing(as.list(xpathSApply(a, "//surname", xmlValue))),
                  given=check_missing(as.list(xpathSApply(a, "//given_name", xmlValue))))
  suppressWarnings(
  # journal article
  if (length(xpathSApply(a, "//journal_article") > 0) {
    rref <- bibentry(
            bibtype = "Article",
            title = check_missing(xpathSApply(a, "//titles/title", xmlValue), sentencecase=TRUE, firsthit=TRUE),
            author = authors,
            journal = check_missing(xpathSApply(a, "//full_title", xmlValue), sentencecase=TRUE,firsthit=TRUE),
            year = check_missing(xpathSApply(a,
            "//journal_article/publication_date/year", xmlValue), firsthit=TRUE),
            month =xpathSApply(a,
            "//journal_article/publication_date/month", xmlValue),
            volume = xpathSApply(a, "//journal_volume/volume", xmlValue),
            doi = xpathSApply(a, "//journal_article/doi_data/doi", xmlValue),
            issn = xpathSApply(a, "//issn[@media_type='print']", xmlValue),
    #        url = xpathSApply(a, "//journal_article/doi_data/resource", xmlValue),
            pages = paste(xpathSApply(a, "//journal_article/pages/first_page", xmlValue),
                    xpathSApply(a, "//journal_article/pages/last_page", xmlValue), sep="--")
            )
    )
  } else if (length(xpathSapply(a, "//book")) > 0) {
    # book chapter
    if ((length(xpathSApply(book, "//book/content_item/@component_type")) > 0) &&
        (xpathSApply(book, "//book/content_item/@component_type") == "chapter")) {
            rref <- bibentry(
                    bibtype = "InBook",
                    chapter = check_missing(xpathSApply(a, "//content_item/titles/title", xmlValue),
                                            sentencecase=TRUE, firsthit=TRUE),
                    author = authors,
                    booktitle = check_missing(xpathSApply(a, "//book_metadata/titles/title", xmlValue),
                                              sentencecase=TRUE,firsthit=TRUE),
                    year = check_missing(xpathSApply(a,
                    "//book_metadata/publication_date/year", xmlValue), firsthit=TRUE),
                    month =xpathSApply(a,
                    "//book_metadata/publication_date/month", xmlValue),
                    #volume = xpathSApply(a, "//journal_volume/volume", xmlValue),
                    series = xpathSApply(a, "//series_metadata/titles/title", xmlValue),
                    doi = xpathSApply(a, "//book_metadata/doi_data/doi", xmlValue),
                    isbn = xpathSApply(a, "//isbn[@media_type='print']", xmlValue),
                    pages = paste(xpathSApply(a, "//content_item/pages/first_page", xmlValue),
                            xpathSApply(a, "//content_item/pages/last_page", xmlValue), sep="--")
                    )
    }
}

## Helper functions

# Title, author, journal, & year cannot be missing, so return "NA" if they are
# Avoid errors in bibentry calls when a required field is not specified.
check_missing <- function(x, sentencecase=FALSE, firsthit=FALSE){
 if(length(x)==0)
  out <- "unknown"
 else
  out <- x
 if(firsthit & length(out) > 1) # handle multiple matches (i.e. submission date vs publication date?)
   out <- out[1]
 if(sentencecase){
   out <- gsub("\\b(\\w)(\\w*)", "\\U\\1\\L\\2", out, perl=TRUE)
   out <- gsub("\\b(\\w{2})\\b", "\\L\\1", out, perl=TRUE)
 }
 out
}


