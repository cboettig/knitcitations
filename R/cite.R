cite <- function(x, 
                 bibtex = get("bibtex_data", envir=knitcitations_options), 
                 format_inline_fn = NULL){

  # Initialize the works cited list (or verify that it is already initialized)
  bibtex = knitcitations_data(bibtex = bibtex) 

  ## For each citation given, do the following:
  out <- lapply(1:length(x),function(i){

    ## Identify what references we already know about (as a list of keys) 
    ## Note that this is updated for each i.  
    current <- read_cache(bibtex = bibtex)
    existing <- names(current) 
    
    ## See if the desired citations have any keys specified for them in the call 
    given_keys <- names(x) 

    ## See if we have a key
    key = given_keys[i]  ## Get the bibkey name for the current citation
    m <- match(x[[i]], existing)  

    ## Handle anything we've already cited so far.  
    if(!is.na(m)){
      entry <- current[[m]] 

    ## Handle anything we haven't cited yet
    } else {
      ## Handle DOIs, http://stackoverflow.com/questions/27910/finding-a-doi-in-a-document-or-page
      ##  Modified by https://github.com/cboettig/knitcitations/commit/7ba14c7bf2ba3cd008157617d64f62f94e7a18b4#commitcomment-4353812
      doi_pattern = "\\b(10[.][0-9]{4,}(?:[.][0-9]+)*/(?:(?![\"&\'])\\S)+)\\b"
      if(is.character(x[[i]]) && length(grep(doi_pattern, x[[i]], perl=TRUE)) == 1){  
        entry <- ref(x[[i]]) # look-up by DOI

      ## Handle URLs
      } else if(is.character(x[[i]]) && length(grep(url_regexp, x[[i]], perl=TRUE)) == 1){
        entry <- greycite(x[[i]])

      ## Handle bibentry types 
      } else if(is(x[[i]], "bibentry")) {
        entry <- x[[i]] # Already a bibentry object?
      ## Handle exceptions
      } else {
        warning("citation not found")
        entry <- I("?")
        entry$key <- "not_found"
      }
      entry <- create_bibkey(entry, key=key, current=current) # Create a bibkey for it

      ## Generate the inline citation  
      if(!is.null(format_inline_fn)){
        if(is.null(entry$inline)){
          entry$inline <- format_inline_fn(entry)
          entry <- unique_inline(entry, format_inline_fn)
        }
      }

      ### Now enter the citation into the bibliographic list ###
      if(!is(entry, "bibentry")){ 
        entry <- I("???")  # make anything we cannot parse an unkown
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
    entry
  })
  if(length(out) == 1)
    out <- out[[1]]
  out
}


#' Add a citation 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @param bibtex internal logical indicating if we use a cache or 
#'  external bibtex file
#' @param format_inline_fn a function which will create the inline 
#'  citation format (stored with the entry to avoid non-unique citation
#'  styles, e.g. Boettiger 2012a, Boettiger 2012b.)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#'  which can be printed with \code{\link{bibliography}}
#' @import knitr
#' @examples \donttest{
#' citep("10.3998/3336451.0009.101")
#' }
#' 
#' @export
kcite <- cite
