#' Lookup article info via CrossRef with DOI.
#' @import RCurl XML
#' @param doi digital object identifier for an article in PLoS Journals
#' @param title return the title of the paper or not (defaults to FALSE)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Metadata from DOI in R's bibentry format.
#' @export
#' @examples \dontrun{
#' ref("10.3998/3336451.0009.101")
#' print(ref("10.3998/3336451.0009.101"), style="Bibtex")
#' print(ref("10.3998/3336451.0009.101"), style="text")
#' }
ref <- 
function(doi, title = FALSE,
  url = "http://www.crossref.org/openurl/", 
  key = "cboettig@gmail.com", 
  ...,
  curl = getCurlHandle())
{
  ## Assemble a url query such as:
  #http://www.ref.org/openurl/?id=doi:10.3998/3336451.0009.101&noredirect=true&pid=API_KEY&format=unixref
  args = list(id = paste("doi:", doi, sep="") )
  args$pid = as.character(key)
  args$noredirect=as.logical(TRUE)
  args$format=as.character("unixref")
  tt = getForm(url, .params = args, .opts = list(...), curl = curl)
  ans = xmlParse(tt)
  formatref(ans)
}

#' Convert crossref XML into a bibentry object
#' 
#' @param a crossref XML output
#' @return a bibentry format of the output
#' @details internal helper function
formatref <- function(a){
 authors <- person(family=as.list(xpathSApply(a, "//surname", xmlValue)),
                  given=as.list(xpathSApply(a, "//given_name", xmlValue)))
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



#' Add a paranthetical citation
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @export
#' @import knitr
#' @examples 
#'   out <- sapply(names(sessionInfo()$otherPkgs), function(x) citation(x))
#'   citep(out)
citep <- function(x){

  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited"))){
    empty <- list()
    class(empty) <- "bibentry"
    options(works_cited = empty)
    knitr::knit_hooks$set(inline = identity)
  }

  out <- sapply(x,function(x){
    if(is(x, "character"))
      entry <- ref(x)
    else # assume it's a bibentry object already
      entry <- x
    ## keep track of what we've cited so far
    options(works_cited = c(getOption("works_cited"), entry))
    authoryear_p(entry)
  })
  paste("(", paste(out, collapse="; "), ")", sep="")
}
#' Add a textual citation
#'
#' @param x a doi or a bibentry 
#' @return a textual inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @examples
#' \dontrun{
#' citet("10.3998/3336451.0009.101")
#' bibliography()
#' }
#' @export
#' @import knitr
citet <- function(x){
  if(is.null(getOption("works_cited"))){
    empty <- list()
    class(empty) <- "bibentry"
    options(works_cited = empty)
    knitr::knit_hooks$set(inline = identity)
  }
    if(is(x, "character"))
      entry <- ref(x)
    else # assume it's a bibentry object already
      entry <- x
    ## keep track of what we've cited so far
    options(works_cited = c(getOption("works_cited"), entry))
    authoryear_t(entry)
}

#' Generate the bibliography
#' @return the markdown formatted bibliography of what's been cited
#' @export
bibliography <- function(){
  getOption("works_cited")
}

#' read in bibtex and use key as list names
#'
#' @param bibfile a bibtex .bib file
#' @return a list of citation information
#' @details this differs from read.bib in that the list is named.
#' this allows one to use citep(bib[c("key1", "key2")]
#' @import bibtex
#' @export
#' @seealso read.bib citep citet
read.bibtex <- function(bibfile){
  bibs <- read.bib(bibfile)
  keys <- lapply(bibs, function(entry) entry$key)
  names(bibs) <- keys
  bibs
}



## helper functions

#' format the author and year parenthetically
#' @param entry a bibentry
#' @return the author-year citation
authoryear_p <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, %s", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s, %s", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ %s", entry$author[[1]]$family, entry$year)
}

#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_t <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, (%s)", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s, (%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ (%s)", entry$author[[1]]$family, entry$year)
}


#' clean the bib list
#'
#' @return clears the works_cited list
#' @export
cleanbib <- function(){
  empty <- list()
  class(empty) <- "bibentry"
  options(works_cited = empty)
  knitr::knit_hooks$set(inline = identity)
}
