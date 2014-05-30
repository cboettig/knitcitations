#' Add a textual citation 
#'
#' Parameters listed here are the same for parenthetical 
#'  citation, \code{\link{citep}}.  
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param cito Semantic reason for the citation. Only active if linked=TRUE
#' @param ... additional arguments (dependent on citation_format). 
#' @param citation_format name of the citation format to use.  Currently
#'  available options are "pandoc" or "compatibility".  
#' @return a text inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}.
#' A variety of reasons for the citation can be provided following the
#' CiTO ontology: 
#' c("cites","citesAsAuthority", "citesAsMetadataDocument",
#'   "citesAsSourceDocument","citesForInformation",
#'   "isCitedBy","obtainsBackgroundFrom", "sharesAuthorsWith", "usesDataFrom",
#'   "usesMethodIn", "confirms", "credits", "extends", "obtainsSupportFrom",
#'   "supports", "updates", "corrects", "critiques", "disagreesWith",
#'   "qualifies", "refutes", "discusses", "reviews")
#' @export
#' @import knitr
#' @examples \donttest{
#' library(knitcitations)
#'  citet("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  citet(knitr)
#'  # generate the full bibliography:
#'  bibliography()
#' ## Assign a citation key to a doi and then use it later:
#' citet(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
#' citet("Halpern2006")
#' }
citet <- function(x, 
                  cito = NULL, 
                  ..., 
                  citation_format = 
                    getOption("citation_format", "compatibility")
                  ){

if(citation_format== "compatibility")
  legacy_citet(x, cito, ...)
else if(citation_format == "pandoc"){
  bib <- cite(x)
  paste(sapply(bib, function(b) paste0("@", b$key)), sep = "", collapse="; ")
  }
else if(citation_format == "text"){
  bib <- cite(x)
  Citet(as.BibEntry(bib), ...)
  }
}







legacy_citet <- function(x, 
                         cito, 
                         tooltip = get("tooltip", envir=knitcitations_options), 
                         linked = get("linked", envir=knitcitations_options), 
                         numerical = get("numerical", envir=knitcitations_options), 
                         format_inline_fn = format_authoryear_t,  
                         page = NULL){ 

  out <- cite(x, format_inline_fn = format_inline_fn)
  if(length(out) > 1) {
    output <- paste(sapply(out, citet, cito, tooltip, linked, format_inline_fn), collapse="; ", sep="")
  } else {
    if(linked){
      citoproperty <- ""
      if(!is.null(cito))
        citoproperty <- paste(' rel="http://purl.org/spar/cito/', cito, '" ', sep='')
      if(!is.null(out$doi)) # Link by DOI if a DOI is available
        link <- paste('href="http://dx.doi.org/', out[[1]]$doi, '"', sep='')
      else ## Attempt to link by bibtex URL field.  
        link <- paste('href="', out$url, '"', sep='')
      output <- paste('<a ', link, citoproperty, '>', I(out[[1]]$inline), '</a>', sep='')
      if(tooltip){
        bibinfo <- clean_html(format(out, "html"))
     output <- paste('<span title="', bibinfo, '">', output, '</span>', sep='')
      }
    } else { # not linked 
      output <- out$inline
    }
  } 

  if(!is.null(page)){
    pgs <- ifelse(grepl("-", page), "pp.", "p.")
    page <- paste(",", pgs, page)
    pageout <- strsplit(output, ")</a>;|)</a>")
    pageout <- sapply(pageout, function(x) {
      paste0(x, page, ")</a>")
    })
    output <- paste(pageout, collapse= ";")
  }

  output
}


# Clean up (strip) the silly default html formatting 
clean_html <- function(bibinfo){
        bibinfo <- gsub('<p>', '', bibinfo) 
         bibinfo <- gsub("&ldquo;", "'", bibinfo) # okay if data-html is on 
         bibinfo <- gsub("&rdquo;", "'", bibinfo) # okay if data-html is on 
         bibinfo <- gsub("&ndash;", "-", bibinfo)  # okay if data-html is on 
         bibinfo <- gsub('<a .*</a>', '', bibinfo) 
         bibinfo <- gsub('<B>', '', bibinfo) 
         bibinfo <- gsub('<EM>', '', bibinfo) 
         bibinfo <- gsub('</B>', '', bibinfo) 
         bibinfo <- gsub('</EM>', '', bibinfo) 
         bibinfo <- gsub('\\n', ' ', bibinfo) 
         bibinfo <- gsub(', \\.', '.', bibinfo) 
}

