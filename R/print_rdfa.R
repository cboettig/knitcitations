#' format for rdfa markup of references
#' 
#' An internal method used by the \code{\link{bibliography}} function
#' @param bib a bibentry object containing one or more citations
#' @param ordering a character list of the order in which information should 
#'  be printed 
#' 
#' @keywords internal 
print_rdfa <- function(bib, ordering =  
                       c("authors", "year", "title", "journal",
                         "volume", "number", "pages", "doi", "uri")){
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
    authors <- paste(' ', authors, sep="") # prepend with space
    year <- paste(' (<span property="dc:date">', r$year, '</span>) ', sep="")
    
    journal <- paste(' <span rel="http://purl.org/dc/terms/isPartOf" 
                            resource="[http://purl.org/dc/terms/journal]">
                        <span property="http://purl.org/dc/terms/title"
                                content="', r$journal,  '">
                        </span>
                          <span property="bibo:shortTitle">', r$journal, 
              '</span>
               </span>')


    volume <- check(' <span property="bibo:volume">', r$volume)
    number <- check(' (<span property=bibo:issue">', r$number)
    pgs <- if(!is.null(r$pages))
      strsplit(r$pages, "--")[[1]]
    spage <- if(!is.null(pgs[1]))
      paste(" ", pgs[1], sep="")
    epage <- if(!is.null(pgs[2])) 
                paste('-', pgs[2], sep="")

    spage <- check(' <span property=bibo:startPage">', spage)
    epage <- check('-<span property=bibo:endPage">', epage)
    pages <- paste(spage, epage, sep="")
    doi  <- 
      if(!is.null(r$doi))
        paste(' <a property="bibo:doi" href="http://dx.doi.org/', r$doi, '">', r$doi, '</a>', sep="")
    uri <- 
      if(is.null(r$doi) && !is.null(r$url))
        paste(' <a property="http://purl.org/dc/terms/URI" href="', r$url, '">', r$url, "</a>")


    bibline <- bib_format(ordering, authors, year, 
                          title, journal, volume, 
                          number, pages, doi, uri, collapse=" ")


    paste("\n<li>", bibline, "</li>\n", sep="")
  })

  paste(block, "<ul class='bibliography'>", paste(references, collapse="", sep=""), '</ul>\n</div>\n')
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


