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
#' @examples 
#' library(knitcitations)
#' ref("10.3998/3336451.0009.101")
#' print(ref("10.3998/3336451.0009.101"), style="Bibtex")
#' print(ref("10.3998/3336451.0009.101"), style="text")
#' 
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



#' Add a paranthetical citation
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @export
#' @import knitr
#' @examples
#' library(knitcitations)
#'  citep("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  devtools <- citation("devtools")
#'  # generate the parentetical citation for these:
#'  citep(list(knitr,devtools))
#'  # generate the full bibliography:
#'  bibliography()
citep <- function(x){

  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited")))
    cleanbib()


  if(is(x, "character")){
    named_dois <- getOption("named_dois")
    if(!is.null(names(x))){ # if x is named, add it to the keylist
      # avoid repeat entries?
      options(named_dois = c(named_dois, x) )
    } else {
      # See if x is a bibkey name for the doi, rather than the doi
      y <- named_dois[match(x, names(named_dois))]
      if(!is.na(y)) # match found, swap doi for the key
        x <- y
    }
  }
  out <- sapply(x,function(x){
    if(is(x, "character")){
      entry <- ref(x)
    } else # assume it's a bibentry object already
      entry <- x
    if(!is(entry, "bibentry")) # if it's not a bibentry, print "?"
      out <- I("?")
    else {
      ## keep track of what we've cited so far
      options(works_cited = c(getOption("works_cited"), entry))
      out <-  authoryear_p(entry)
    }
    out
  })
  I(paste("(", paste(out, collapse="; "), ")", sep=""))
}
#' Add a textual citation
#'
#' @param x a doi or a bibentry 
#' @return a textual inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @examples
#' library(knitcitations) 
#' citet("10.3998/3336451.0009.101")
#' bibliography()
#'
#' @export
#' @import knitr
citet <- function(x){
  if(is.null(getOption("works_cited")))
    cleanbib()
  if(is(x, "character"))
    entry <- ref(x)
  else # assume it's a bibentry object already
    entry <- x
  if(!is(entry, "bibentry"))
    out <- I("?")
  else {
    ## keep track of what we've cited so far
    options(works_cited = c(getOption("works_cited"), entry))
   out <- I(authoryear_t(entry))
  }
  out
}

#' Generate the bibliography
#' @return the markdown formatted bibliography of what's been cited
#' @export
bibliography <- function(){
  out <- getOption("works_cited")
  cleanbib()
  out
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

#' write a bibtex file  
#'
#' @param entry a 'bibentry' object or a character vector of package names
#' @param file output bibtex file. Will automatically append '.bib' if not added.
#'   if 'NULL' will use stdout.  
#' @param append a logical indicating that bibtex entries be added the the file.  
#'  If FALSE (default), the file is overwritten.  
#' @param verbose a logical to toggle verbosity. If 'file=NULL', verbosity is
#'  forced off.
#' @return a list of citation information, invisibly
#' @details This function is simply a wrapper to the function write.bib from doRNG
#' package by Renaud Gaujoux.  Though that function has been added to the 'bibtex'
#' package by Romain Francois (a more sensible place to find it), that version
#' was not avialble on CRAN at the time of writing.  
#' 
#' The 'knitcitations' package automatically extends the use of this function to
#' be able to write bibtex files from a string of DOIs, making it valuable for 
#' purposes beyond the citation of packages.  
#' 
#' @import bibtex doRNG
#' @examples
#'  write.bibtex(c('bibtex', 'knitr', 'knitcitations'), file="example.bib")
#'  refs <- lapply(c("10.1111/j.1461-0248.2005.00827.x","10.1890/11-0011.1"), ref)
#'  write.bibtex(refs, file="refs.bib")
#' 
#' @export
#' @seealso read.bib citep citet
write.bibtex <- function(entry, file="knitcitations.bib", append=FALSE, verbose=TRUE){
  write.bib(entry=entry, file=file, append=append, verbose=verbose)
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
  options(named_dois = c(blank=""))
}
