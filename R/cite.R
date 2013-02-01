#' Add a citation (internal for citet and citep) 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param bibtex internal logical indicating if we use a cache or external bibtex file
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @import knitr
#' @keywords internal
#' @examples
#' citep("10.3998/3336451.0009.101")
cite <- function(x, inline_format = authoryear_t, bibtex = getOption("bibtex_data")){

  # Initialize the works cited list (or verify that it is already initialized)
  bibtex = knitcitations_data(bibtex = bibtex) 
  
  ## Identify what references we already know about (as a list of keys) 
  current <- read_cache(bibtex = bibtex)
  existing <- names(current) 
  
  ## See if the desired citations have any keys specified for them in the call 
  given_keys <- names(x) 


  ## For each citation given, do the following:
  out <- sapply(1:length(x),function(i){
   
    ## See if we have a key
    key = given_keys[i]  ## Get the bibkey name for the current citation

    ## 
    m <- match(x[[i]], existing)  

    ## Handle anything we've already cited so far.  
    if(!is.na(m)){
      entry <- current[[m]] 

    ## Handle anything we haven't cited yet
    } else {

      ## Handle DOIs
      doi_pattern = "\\b(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![\"&\'<>])\\S)+)\\b"
      if(is.character(x[[i]]) && grep(doi_pattern, x[[i]], perl=T)){
        entry <- ref(x[[i]]) # look-up by DOI
        entry <- create_bibkey(entry, key=key, current=current) # and create a bibkey for it

      ## Handle bibentry types 
      } else if(is(x[[i]], "bibentry")) {
        entry <- x[[i]] # Already a bibentry object?
        entry <- create_bibkey(entry, key=key) # Create a bibkey for it

      ## Handle exceptions
      } else {
        warning("citation not found")
        entry <- I("?")
      }


      ### Now enter the citation into the bibliographic list ###
      ## Handle look-up failures, probably due to `ref()` call failing
      if(!is(entry, "bibentry")){ 
        entry <- I("?")
      } else {
         ## Check if we already have this key entered
         m <- match(names(entry), existing)  
         if(is.na(m))
          write_cache(entry, bibtex = bibtex)
        else
          message("citation already in database")
      }
    }
    ## Format using entry using the specified function (e.g. authoryear_p) 
    inline_format(entry)
  })
}

