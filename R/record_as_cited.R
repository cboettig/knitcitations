#' record as cited
#' 
#' adds a BibEntry object to the works cited list even if not cited 
#' with a call to citep/citet
#' @param entry a BibEntry object (or something that can be coerced to one, like bibentry)
#' @return Adds the object to the citation list, with a BibTex citation 
#' key that does not duplicate any that are already in the record.  
#' Invisibly returns the bibentry object.  
#' @export
record_as_cited <- function(entry){
  if(!is(entry, "BibEntry"))
    entry <- as.BibEntry(entry)

  hash <- check_unique(entry)

  if(entry_exists(hash)){
    entry <- get_matching_key(entry)

  } else { 
    entry <- get_unique_key(entry)
    update_biblio(hash, entry)
  }
  invisible(entry)
}

