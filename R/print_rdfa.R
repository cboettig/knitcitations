

print_rdfa <- function(r){
  block <- paste('<div prefix="dc: http://purl.org/dc/terms/,
                      bibo: http://purl.org/ontology/bibo/,
                      foaf: http://xmlns.com/foaf/spec/,
                      biro: http://purl.org/spar/biro/"
        property="http://purl.org/spar/biro/ReferenceList">')

  title <- paste('<span property="dc:title">', r$title, '</span>', sep='\n')

  authors <- 
    paste('<span property="dc:creator">', 
      sapply(r$author, function(x) 
             paste('<span property="foaf:givenName">', 
                   x$given, 
                   '</span> <span property="foaf:familyName">', 
                   x$family, 
                   '</span>, ')
             ), '</span>'
    )

  pdate <- paste(' (<span property="dc:date">', r$year, '</span>) ')


  journal <- paste('<span rel="http://purl.org/dc/terms/isPartOf" resource="[http://purl.org/dc/terms/journal]">
            <span property="http://purl.org/dc/terms/title"
                    content="', r$journal,  '">
            </span>
            <span property="bibo:shortTitle">', r$journal, 
            '</span>
             </span>')
  volume <- paste(' <span property="bibo:volume">', r$volume, '</span>', 
                  ' (<span property=bibo:issue">', r$number, '</span>)',
                  ' <span property=bibo:startPage">', r$page[1], '</span>',
                  '-<span property=bibo:endPage">', r$page[2], '</span>',
                  ' <span property="bibo:doi">', r$doi, '</span>', sep="")
  paste(block, title, authors, pdate, journal, volume, '</div>')
}
