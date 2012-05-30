
## helper functions

#' format the author and year parenthetically
#' @param entry a bibentry
#' @return the author-year citation
authoryear_p <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, %s", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s, %s", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ %s", entry$author[[1]]$family, entry$year)
}

#' format the author and year 
#' @param entry a bibentry
#' @return the author-year citation
authoryear_t <- function(entry){
    n <- length(entry$author)
    if(n==1)
      sprintf("%s, (%s)", entry$author$family, entry$year)
    else if(n==2)
      sprintf("%s & %s, (%s)", entry$author[[1]]$family, entry$author[[2]]$family, entry$year)
    else if(n>2)
      sprintf("%s _et. al._ (%s)", entry$author[[1]]$family, entry$year)
}


#' clean the bib list
#'
#' @return clears the works_cited list
#' @export
cleanbib <- function(){
  empty <- list()
  class(empty) <- "bibentry"
  options(works_cited = empty)
  options(named_dois = c(blank=""))
}



#' generate bibkeys for unamed bibentry objects
#' 
#' create_bibkey generates a key using a LastNameYear format or given key.
#' @param bibentry a bibentry object without a bibkey
#' @param key the key to use as the bibkey. Defaults to NULL, in which case
#' the function constructs its own key using LastNameYear format (from first author).  
#' @param existing a list of existing keys, which will force 'create_bibkey'
#'  to generate a unique pattern.  
#' @return an updated bibentry that now has a key value and is named using its key
#' @examples
#'  r <- ref("10.3998/3336451.0009.101")
#'  print(r, "Bibtex")
#'  r <- create_bibkey(r)
#' ## Notice it now has a key entry
#'  print(r, "Bibtex")
#'   
create_bibkey <- function(bibentry, key=NULL, existing=NULL){

    # If the citation has a key already, please just use it.
    if(!(is.null(bibentry$key)))
       key <- bibentry$key


    # If a key is not found and not specified in the fn call, please generated it
    if(is.null(key)){
      entry <- bibentry
      entry <- unlist(entry)
      key <- paste(entry["author.family"], entry[["year"]], sep="")
      if(!is.na(match(key, existing)))
        key <- paste(key, "_", sep="")
    }
    names(bibentry) <- key
    bibentry$key <- key
  bibentry
}




create_bibkeys <- function(bibentries){
  out <- lapply(bibentries, create_bibkey)
  list_to_bibentry(out)
}

