#' Toggles for various citation options
#' 
#' @param citation_format 'pandoc', 'compatibility' (with version 0.5 or earlier), or 'text'
#' @param style plain "text" style (default) inline citations, "markdown" style or or html style links
#' to the hyperlink
#' @param hyperlink Either logical (FALSE), or link "to.doc" (by DOI if available, otherwise to URL), or
#' link "to.bib" section.  
#' @param cite.style Should inline textual citations use "authoryear", "numeric", or "authortitle" format?
#' @param super logical, should numeric cite.style be a superscript?
#' @param max.names numeric, maximum number of names to list before adding "et al.".  
#' @param longnamesfirst logical. Should all authors be listed the first time a citation is used (rather than obeying max.names?) 
#' @param check.entries logical. Should error if any 'required' bibtex field is missing? Default FALSE
#' @param ... additional arguments to BibOptions
#' @return updates the option specified for the duration of the session. 
#' @export 
cite_options <- function(citation_format = "compatibility", 
                         style = "text", # markdown, html
                         hyperlink = FALSE, # "to.doc" "to.bib"
                         cite.style = "authoryear", # numeric, authoryear, authortitle
                         super = FALSE, 
                         max.names = 4,
                         longnamesfirst = FALSE, 
                         check.entries = FALSE, 
                         ...){
  options(citation_format = citation_format)
  invisible(BibOptions(check.entries = check.entries, ...))
}

