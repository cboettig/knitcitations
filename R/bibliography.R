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
  if(style %in% c("html", "R", "text", "bibtex", "textVersion", "citation")){
    output <- print(out, style, .bibstyle=.bibstyle, ...)
    # print(output)
  } else if(style == "rdfa"){
    output <- sapply(out, print_rdfa)
    names(output) = ""
    output <- paste0(unlist(output), collapse="")
    pretty_output <- print(cat(output))
  } else if(style == "markdown"){
    output <- sapply(out, print_markdown)
    names(output) = ""
    output <- print(paste0(unlist(output), collapse=""))
    print(output)
  } else {
    stop("Style not recognized")
  }
  invisible(output)
}

#' print method for markdown format
#' @keywords internal
print_markdown <- function(bib){
  ## create individual citations
  references <- sapply(bib, function(r){ 
    title <- paste(r$title, ",", sep="")
    authors <-      
        paste(sapply(r$author, function(x) 
               paste(x$given[1], " ", x$family, ", ", collapse="", sep=""))
              , sep="", collapse="")
    pdate <- if(!is.null(r$year))
               paste("(", r$year, ")", sep="")
    journal <- paste("*", r$journal, "*,", sep="")
    volume <- paste('**', r$volume, '**', sep="")
    issue <- r$number
    spage <- r$page[1]
    epage <- if(!is.null(r$page[2])) 
                paste('-', r$page[2], sep="")
             
    doi  <- paste('[',  r$doi, '](http://dx.doi.org/', r$doi, ')', sep="")
    paste("\n- ", title, authors, pdate, journal, volume, issue, spage, epage, doi)
    })

  paste(paste0(references, collapse=""))
}





