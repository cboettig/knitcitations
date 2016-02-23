# This file contains internal functions which handle 
# getting citation metadata and tracking what has
# already been cited.  


knitcitations <- new.env(hash=TRUE)
BibOptions(check.entries = FALSE)


#' @import RefManageR digest methods
#' @importFrom utils bibentry person
knit_cite <- function(x, ...){   # the method that citet/p loop over
  entry <- bib_metadata(x, ...)
  record_as_cited(entry)
}

get_bib_list <- function() 
  mget(ls(envir = knitcitations), envir=knitcitations)

get_bib <- function() 
  do.call("c", get_bib_list())

is.bibkey <- function(x){
  bib <- get_bib_list()
  if(length(bib) > 0){
    keys <- sapply(bib, function(b) b$key)
    x %in% keys
  } else
    FALSE
}

get_by_bibkey <- function(key){
  bib <- get_bib_list() 
  keys <- sapply(bib, function(b) b$key)
  bib[keys %in% key][[1]]
}


fix_duncan <- function(entry){
  if(!is.null(entry$author) && length(entry$author) > 0){
    i <- suppressWarnings(which(sapply(entry$author, function(x) identical(x$given, c("Duncan", "Temple")) && x$family == "Lang")))
    if(length(i) > 0){
      class(entry) = "bibentry" # Strip BibEntry class so that this works
      entry$author[i] <- person("Duncan", "Temple Lang")
    }
  }
  entry
}

tweak <- function(entry, BibEntry = TRUE){
    # Make sure every entry has a year and a key.
    entry <- fix_duncan(entry) 
    if (is.null(entry$year))
      entry$year <- format(Sys.time(), "%Y")
    if(is.null(entry$key))
      entry <- make_key(entry)
  if(BibEntry)
    as.BibEntry(entry)
  else 
    entry
}


make_key <- function(entry){
  n <- entry$author[[1]]$family
  if(is.null(n))
    n <- entry$author[[1]]$given
  n <- gsub(" ", "_", n)
  n <- paste(n, entry$year, sep="_")

  entry$key  <- iconv(n, to = "ASCII//TRANSLIT")
  get_unique_key(entry)
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
  hash %in% ls(envir = knitcitations)


update_biblio <- function(hash, entry) 
  assign(hash, entry, envir=knitcitations) 


inline_format <- function(entry, ...)
   paste0("@", entry$key)
 

get_matching_key <- function(entry){
  hash <- check_unique(entry)
  matching_entry <- get(hash, envir = knitcitations) 
  entry$key <- matching_entry$key
  entry
}


get_unique_key <- function(entry){
  bib <- get_bib_list() 
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

