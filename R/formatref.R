#' Convert crossref XML into a bibentry object
#'
#' @param a crossref XML output
#' @return a bibentry format of the output
#' @details internal helper function
#' @keywords internal
formatref <- function(a){
  authors <- .parse_contributors(a)

  suppressWarnings(
  # journal article
  if (length(xpathSApply(a, "//journal_article")) > 0) {
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
  } else if (length(xpathSApply(a, "//book")) > 0) {
    # shared book fields
    editors = .parse_contributors(a, role='editor')

    booktitle = check_missing(xpathSApply(a, "//book_metadata/titles/title", xmlValue),
                              sentencecase=TRUE,firsthit=TRUE)
    year = check_missing(xpathSApply(a, "//book_metadata/publication_date/year", xmlValue),
                         firsthit=TRUE)
    month = xpathSApply(a, "//book_metadata/publication_date/month", xmlValue)
    series = xpathSApply(a, "//series_metadata/titles/title", xmlValue)
    doi = xpathSApply(a, "//book_metadata/doi_data/doi", xmlValue)
    isbn = xpathSApply(a, "//isbn[@media_type='print']", xmlValue)
    publisher = xpathSApply(a, "//publisher/publisher_name", xmlValue)

    # If no authors specified, use editors instead
    if (as.character(authors) == 'unknown unknown') {
      authors = NULL
    }

    # book chapter
    if ((length(xpathSApply(a, "//book/content_item/@component_type")) > 0) &&
        (xpathSApply(a, "//book/content_item/@component_type") == "chapter")) {
      rref <- bibentry(
              bibtype = "InBook",
              author = authors,
              editor = editors,
              booktitle = booktitle,
              year = year,
              month = month,
              series = series,
              publisher = publisher,
              doi = doi,
              isbn = isbn,
              title = check_missing(xpathSApply(a, "//content_item/titles/title", xmlValue),
                                    sentencecase=TRUE, firsthit=TRUE),
              chapter = xpathSApply(a, "//component_number", xmlValue),
              pages = paste(xpathSApply(a, "//content_item/pages/first_page", xmlValue),
                            xpathSApply(a, "//content_item/pages/last_page", xmlValue), sep="--")
              )
    } else {
      # book
      rref <- bibentry(
              bibtype = "Book",
              author = authors,
              editor = editors,
              title = booktitle,
              year = year,
              month = month,
              series = series,
              publisher = publisher,
              doi = doi,
              isbn = isbn)
    }
  }
)}

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

# Parses author and editor fields
.parse_contributors <- function(x, role='author') {
  base_query = sprintf('//person_name[@contributor_role="%s"]', role)

  surnames = xpathSApply(x, sprintf('%s/surname', base_query, role), xmlValue)
  given_names = xpathSApply(x, sprintf('%s/given_name', base_query, role), xmlValue)

  return(person(family=check_missing(as.list(surnames)),
                given=check_missing(as.list(given_names))))
}


