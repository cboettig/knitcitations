#' Generate the bibliography
#' @param ... additional arguments passed to PrintBibliography,
#' @param style the name of the journal style, e.g. "mla", "nature", 
#' "methods-in-ecology-and-evolution", etc. See details.
#' @details Not that style will use the ordering rule set in BibOptions,
#' but not the other formatting options (which will come from the CSL sheet instead).  
#' NOTE that csl formatting works only if reference has a DOI. 
#' 
#' For non-trivial bibliographies, knitcitations recommends authors use 
#' pandoc format, see cite_options(cite_format="pandoc"), and allow pandoc 
#' to generate the references list rather than rely on the bibliography() function. 
#' Pandoc has rich CSL support using any provided CSL file (see Pandoc documentation
#' for details) and is integrated into recent version of RStudio.  
#' 
#' @return a list of works cited 
#' @export
#' @examples
#' citet(citation("XML"))
#' citet(citation("digest"))
#' bibliography()
#' bibliography(sorting = 'ynt') # sort by year, then name, title
#' bibliography(sorting = 'ydnt') # sort by year, descending, then name, title
#' cleanbib()
#'
#' \donttest{
#' # these examples require an internet connection 
#' citet("Vos NeXML 2012")
#' citet("Boettiger Ross Hastings 2013")
#' bibliography(style="nature")
#' bibliography(style="nature", sorting = 'ynt') # obeys sorting rule 
#' }
bibliography <- function(..., style=NULL)
{
  bibs <- get_bib()
  NoCite(bibs) 

  if(!is.null(style)){
    BibOptions(...)
    refs <- sapply(sort(bibs), csl_formatting)
    cat(refs, sep="\n")
  } else {
    PrintBibliography(bibs, .opts=list(...))
  }
  invisible(bibs)

}


csl_formatting <- function(bib, style = "ecology"){
    if(!is.null(bib$doi)){
      resp <- GET(paste("http://data.crossref.org", bib$doi, sep="/"), 
          add_headers(Accept = paste0("text/bibliography; style=", style)))
      if(resp$headers[["content-type"]] == "text/bibliography")
        content(resp)
      else # returned wrong content type, so fall back on default print method
        print(bib)
    } else { # no DOI, fall back on default print method 
      print(bib)
    }
}

