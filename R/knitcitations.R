# This file contains internal functions which handle 
# getting citation metadata and tracking what has
# already been cited.  


knitcitations <- new.env(hash=TRUE)
BibOptions(check.entries = FALSE)


#' @import RefManageR digest
knit_cite <- function(x, ...){
  entry <- biblio_metadata(x, ...)
  record_as_cited(entry)
  entry
}

biblio_metadata <- function(x, ...){

  if(is(x, "bibentry"))
    entry <- x
  else if(is(x, "character")){
    if(is.bibkey(x))
      entry <- get_by_bibkey(x)
    else if(is.url(x))
      entry <- greycite(x)
    else if(is.pdf(x))
      entry <- ReadPDFs(x)
    else
      entry <- ReadCrossRef(x, limit = 1, ...)
  }
  tweak(entry)
}

record_as_cited <- function(entry){
  hash <- check_unique(entry)

  if(entry_exists(hash)){
    entry <- get_matching_key(entry)
  } else { 
    entry <- get_unique_key(entry)
    update_biblio(hash, entry)
  }
  entry
}


get_bib <- function() 
  do.call("c", mget(ls(env=knitcitations), envir=knitcitations))


is.bibkey <- function(x){
  bib <- get_bib()
  if(length(bib) > 0){
    keys <- sapply(bib, function(b) b$key)
    x %in% keys
  } else
    FALSE
}

get_by_bibkey <- function(key){
  bib <- get_bib() 
  keys <- sapply(bib, function(b) b$key)
  bib[keys %in% key][[1]]
}


tweak <- function(entry){
    for(a in entry$author){
      if(a$given == c("Duncan", "Temple") && a$family == "Lang"){ 
        entry$author$given  <- "Duncan"
        entry$author$family <- "Temple Lang"
      }
    }
    if (is.null(entry$year))
      entry$year <- format(Sys.time(), "%Y")
    if(is.null(entry$key))
      entry <- make_key(entry)
  as.BibEntry(entry)
}


make_key <- function(entry){
  n <- entry$author[[1]]$family
  if(is.null(n))
    n <- entry$author[[1]]$given
  n <- gsub(" ", "_", n)
  entry$key  <- paste(n, entry$year, sep="_")
  entry <- get_unique_key(entry)
}


is.pdf <- function(x){
  if(file.exists(x)){ 
    out <- gsub(".*\\.(pdf)", "\\1", x) == "pdf"
  } else {
    out <- FALSE
  }
  out 
}

is.url <- function(x){
  length(grep(url_regexp, x, perl=TRUE)) == 1
}


entry_exists <- function(hash) 
  hash %in% ls(env=knitcitations)


update_biblio <- function(hash, entry) 
  assign(hash, entry, envir=knitcitations) 


inline_format <- function(entry, ...)
   paste0("@", entry$key)
 

get_matching_key <- function(entry){
  hash <- check_unique(entry)
  matching_entry <- get(hash, env=knitcitations) 
  entry$key <- matching_entry$key
  entry
}


get_unique_key <- function(entry){
  bib <- get_bib() 
  if(length(bib) > 0){
    keys <- sapply(bib, function(x) x$key)
    recursive_key_update(entry, keys, 1)
  } else {
    entry
  }
}


recursive_key_update <- function(entry, keys, i){ 
  if(entry$key %in% keys){
    entry$key <- paste0(entry$key, letters[i])
    i <- i + 1
    recursive_key_update(entry, keys, i)
  } else {
    entry
  }
}


check_unique <- function(entry){  
  entry$key <- "common" # Not unique if only keys are different 
  digest(unlist(entry))
}

