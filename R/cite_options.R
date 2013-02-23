#' Toggles for various citation options
#' 
#' @param tooltip Provide a javascript tooltip over the in-line citation? (requires twitter-bootstrap tooltip JS, see details).  
#' @param linked Add an HTML link around the in-line citation? 
#' @param numerical Use numerical instead of author-year format citations? 
#' @param bibtex_data whether we should write to a bibtex file instead of the knitcitationsCache environment for tracking bibliographic information of what we have already cited.  
#' @return updates the option specified for the duration of the session. 
#' @export 
cite_options <- function(tooltip = FALSE, linked=TRUE, numerical=FALSE, bibtex_data = FALSE){
  assign("tooltip",  tooltip, envir=knitcitations_options)
  assign("linked", linked,  envir=knitcitations_options)
  assign("numerical", numerical,  envir=knitcitations_options)
  assign("bibtex_data", bibtex_data, envir=knitcitations_options)
}

