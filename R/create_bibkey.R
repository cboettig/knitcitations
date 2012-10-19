#' generate bibkeys for unamed bibentry objects
#' 
#' create_bibkey generates a key using a LastNameYear format or given key.
#' @param bibentry a bibentry object without a bibkey
#' @param key the key to use as the bibkey. Defaults to NULL, in which case
#' the function constructs its own key using LastNameYear format (from first author).  
#' @param current a list of currently existing citations, such as the output from 'bibliography()', which will force 'create_bibkey'
#'  to generate a unique pattern. 
#' @return an updated bibentry that now has a key value and is named using its key
#' @examples
#'  r <- ref("10.3998/3336451.0009.101")
#'  print(r, "Bibtex")
#'  r <- knitcitations:::create_bibkey(r)
#' ## Notice it now has a key entry
#'  print(r, "Bibtex")
#'   
#' @keywords internal

create_bibkey <- function(bibentry, key=NULL, current=NULL){
    
    # If the citation has a key already, please just use it.
    if(!(is.null(bibentry$key)))
       key <- bibentry$key
    if(!is.null(names(bibentry)))
       key <- names(bibentry)

    # If a key is not found and not specified in the fn call, please generated it
    if(is.null(key)){
      
      key <- paste(bibentry$author$family[[1]], bibentry$year, sep="")

      # Checks if the the key is in use
      existing <- sapply(current, function(x) x$key)
      m <- match(key, existing)

      ## If the key is in use, check if it's the same document
      if(!is.na(m)){
        if(identical(bibentry$title, current[[m]]$title)) {
          key <- existing[m] # same title? Use the same key, 
          # biblio will drop the duplicate
        } else { 
          warning(paste("Automatic key generation found a copy of this key, using ", key, "_ instead", sep=""))
          key <- paste(key, "_", sep="") ## New title, give it a new key.  
        }
      }

    }
    names(bibentry) <- key
    bibentry$key <- key
  bibentry
}




create_bibkeys <- function(bibentries){
  out <- lapply(bibentries, create_bibkey)
  list_to_bibentry(out)
}

