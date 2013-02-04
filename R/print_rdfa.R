#' format for rdfa markup of references
#' 
#' @param bib a bibentry object
#' 
#' @keywords internal 
print_rdfa <- function(bib){
  block <- paste('<div prefix="dc: http://purl.org/dc/terms/,
                      bibo: http://purl.org/ontology/bibo/,
                      foaf: http://xmlns.com/foaf/spec/,
                      biro: http://purl.org/spar/biro/"
        property="http://purl.org/spar/biro/ReferenceList">')

  ## create individual citations
  references <- sapply(bib, function(r){ 
    title <- paste('<span property="dc:title">', r$title, '.</span>', sep='')

    authors <- 
      paste('<span property="dc:creator">', 
        sapply(r$author, function(x) 
               paste('<span property="foaf:givenName">', 
                     x$given[1], 
                     '</span> <span property="foaf:familyName">', 
                     x$family, 
                     '</span>,', collapse="", sep="")
               ), '</span>', collapse = ""
      )

    pdate <- paste(' (<span property="dc:date">', r$year, '</span>) ', sep="")

    journal <- paste('<span rel="http://purl.org/dc/terms/isPartOf" 
                            resource="[http://purl.org/dc/terms/journal]">
                        <span property="http://purl.org/dc/terms/title"
                                content="', r$journal,  '">
                        </span>
                          <span property="bibo:shortTitle">', r$journal, 
              '</span>
               </span>')


    volume <- check(' <span property="bibo:volume">', r$volume)
    issue <- check(' (<span property=bibo:issue">', r$number)
    spage <- check(' <span property=bibo:startPage">', r$page[1])
    epage <- check('-<span property=bibo:endPage">', r$page[2])
    doi  <- paste('<a property="bibo:doi" href="http://dx.doi.org/', r$doi, '">', r$doi, '</a>', sep="")

    paste("\n<li>", title, authors, pdate, journal, volume, issue, spage, epage, doi, "</li>\n" )
    })

  paste(block, "<ul class='bibliography'>", paste0(references, collapse=""), '</ul>\n</div>\n')
}

#' check if the element is present before creating a RDFa span tag for it.  
#'
#' @param element the element of the bibentry whose existence we check for
#' @param tag preceding span tag
#' @return if the element is present, return the span tag, followed by the element and closing span tag. 
#' @keywords internal
check <- function(tag, element){
  if(!is.null(element))
    paste(tag, element, '</span>', sep="")
  else
    ""
}


