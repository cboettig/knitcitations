#' Toggles for various citation options
#' 
#' @param citation_format 'pandoc', 'compatibility' (with version 0.5 or earlier), or 'text' 
#' @param ... additional arguments to BibOptions
#' @return updates the option specified for the duration of the session. 
#' @export 
cite_options <- function(citation_format = "compatibility", ...){
  options(citation_format = citation_format)
  invisible(BibOptions(...))
}

