#' Generate the bibliography
#' @param style formatting style to print bibliography (default is plain text).  Can be 
#' text, bibtex, html, textVersion, R, citation, or other formats defined forthe print bibentry class, 
#' see ?print.bibentry for details.  
#' @param ordering a character list of the order in which information should be printed (e.g. c("author",  "year", "title", "journal", "volume", "number", "pages", "doi", "uri")) see details.  Works only for rdfa and markdown formats at the moment. Other styles are formatted according to the \code{\link{bibstyle}} method, see for more information.
#' @param sort logical indicating if bibliography should be sorted
#' alphabetically, defaults to FALSE
#' @param bibtex logical, use bibtex data structure internally? (internal option only)
#' @param .bibstyle the bibstyle function call or string. Defaults to journal of statistical software (JSS).  See \code{\link{bibstyle}}.
#' @param ... additional arguments passed to print.bibentry, see \code{\link{bibentry}}
#' @return a list of bibentries, providing a bibliography of what's been cited
#' @details The markdown and rdfa print formats can take the argument `ordering`. A character string provides the order in which elements should be returned.  Elements not specified are omitted from the return entirely.  Even if both DOI or URI (usually the URL) are given, method will return the URL only if the DOI is absent/unavailable.  
#' @examples 
#' citet(citation("knitr"))
#' bibliography()
#' ## use markdown formatting, show only author, year, and url
#' bibliography("markdown", ordering = c("authors", "year", "url"))
#' 
#' ## Repeat citations do not create duplicates:
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' citep(bib)
#' bibliography()
#' 
#' @export
bibliography <- function(style="markdown", .bibstyle = "JSS", 
                         ordering =  c("authors", "year", "title", 
                                       "journal", "volume", "number",
                                       "pages", "doi", "url"), 
                         sort=FALSE, bibtex=get("bibtex_data", envir=knitcitations_options), ...){
  out <- read_cache(bibtex=bibtex)
  if(length(out)>0){
    if(sort){   
      ordering <- sort(names(out))
      out <- out[ordering]
    }
  }
  if(style %in% c("html", "R", "text", "bibtex", "textVersion", "citation", "LaTeX")){
    output <- print(out, style, .bibstyle=.bibstyle, ...)
    # print(output)
  } else if(style == "rdfa"){
    output <- print_rdfa(out, ordering=ordering)
    names(output) = ""
    output <- paste0(unlist(output), collapse="")
    pretty_output <- cat(output)
  } else if(style == "markdown"){
    output <- print_markdown(out, ordering=ordering)
    names(output) = ""
    # output <- print(paste0(unlist(output), collapse=""))
    pretty_output <- cat(output)
  } else {
    stop("Style not recognized")
  }
  invisible(output)
}

