#' Generate the bibliography
#' @param style formatting style to print bibliography (default is plain text).  Can be 
#' text, bibtex, html, textVersion, R, citation, or other formats defined forthe print bibentry class, 
#' see ?print.bibentry for details.  
#' @param sort logical indicating if bibliography should be sorted
#' alphabetically, defaults to FALSE
#' @param bibtex logical, use bibtex data structure internally? (internal option only)
#' @param .bibstyle the bibstyle function call or string. Defaults to journal of statistical software (JSS).  See \code{\link{bibstyle}}.
#' @param ... additional arguments passed to print.bibentry, see \code{\link{bibentry}}
#' @return a list of bibentries, providing a bibliography of what's been cited
#' @details Formating of the return data is handled by bibentry printing methods.  
#' @examples 
#' bib <- c(citation("knitr"), citation("knitr"), citation("bibtex"), citation("bibtex"), citation("knitr"), citation("knitcitations"), citation("bibtex"))
#' citep(bib)
#' bibliography()
#' 
#' @export
bibliography <- function(style="textVersion", .bibstyle = "JSS", sort=FALSE, bibtex=get("bibtex_data", envir=knitcitations_options), ...){
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
    output <- print_rdfa(out)
    names(output) = ""
    output <- paste0(unlist(output), collapse="")
    pretty_output <- cat(output)
  } else if(style == "markdown"){
    output <- print_markdown(out)
    names(output) = ""
    # output <- print(paste0(unlist(output), collapse=""))
    pretty_output <- cat(output)
  } else {
    stop("Style not recognized")
  }
  invisible(output)
}

