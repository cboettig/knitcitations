#' Toggles for various citation options
#' 
#' @param tooltip Provide a javascript tooltip over the in-line citation? 
#'  (requires twitter-bootstrap tooltip JS, see details).  
#' @param linked Add an HTML link around the in-line citation? 
#' @param bibtex_data whether we should write to a bibtex file instead of 
#'  the knitcitationsCache environment for tracking bibliographic 
#'  information of what we have already cited.  
#' @param citation_format pandoc-style citations, compatibility (with version 0.5 or earlier), or text (show citations as plain text without hyperlinks)
#' @param ... additional arguments to BibOptions
#' @return updates the option specified for the duration of the session. 
#' @export 
cite_options <- function(tooltip = FALSE, linked=TRUE, bibtex_data = FALSE, citation_format = "compatibility", ...){
  assign("tooltip",  tooltip, envir=knitcitations_options)
  assign("linked", linked,  envir=knitcitations_options)
  assign("bibtex_data", bibtex_data, envir=knitcitations_options)
  options(citation_format = citation_format)
  invisible(BibOptions(...))
}

