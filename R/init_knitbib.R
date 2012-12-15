#' Helper function to get knit data
#' 
#' @keywords internal
knitcitations_data <- function(){
  if(!exists("knitbib", envir=knitcitationsCache))
    tryCatch(init_knitbib(), error= function(e) 
      stop("Could not initiate a bibliography."))
  get("knitbib", envir=knitcitationsCache)
}

init_knitbib <- function(){
  write("", file="knitcitations.bib")
  knitbib <- read.bib("knitcitations.bib")
  assign('knitbib', knitbib, envir=knitcitationsCache)
}
