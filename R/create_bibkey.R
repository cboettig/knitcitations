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
      key <- check_existing(key, bibentry, current)
    }
    names(bibentry) <- key
    bibentry$key <- key
    bibentry$numeral <- get_numeral(bibentry, current)

  bibentry
}


get_numeral <- function(bibentry, current){
  n <- length(current)
  numeral <- n+1
  numeral
}





check_existing <- function(key, bibentry, current){
     existing <- sapply(current, function(x) x$key)
     m <- match(key, existing)
        key_unique <- is.na(m)
        ##  If key exists, check the title
        if(!key_unique) {
          if(identical(bibentry$title, current[[m]]$title)){
            key <- existing[m] # same title? Use the same key, 
            key_unique <- TRUE # And exit the loop 
          } else {
            key <- paste(key, "_", sep="") ## New title, give it a new key. 
            #warning(paste("Automatic key generation found a copy of this key, using ", key, " instead", sep=""))
            key <- check_existing(key, bibentry, current)
          }
        } # if key is unique, we're done and can return a unique key
        key
}



