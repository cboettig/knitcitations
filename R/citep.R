#' Add a paranthetical citation
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @export
#' @import knitr
#' @examples
#' library(knitcitations)
#'  citep("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  devtools <- citation("devtools")
#'  # generate the parentetical citation for these:
#'  citep(list(knitr,devtools))
#'  # generate the full bibliography:
#'  bibliography()
#' ## Assign a citation key to a doi and then use it later:
#' citep(Halpern2006=("10.1111/j.1461-0248.2005.00827.x"))
#' citep("Halpern2006")
#' 
citep <- function(x){

  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited")))
    cleanbib()


  if(is(x, "character")){
    named_dois <- getOption("named_dois")
    if(!is.null(names(x))){ # if x is named, add it to the keylist
      # avoid repeat entries?
      options(named_dois = c(named_dois, x) )
    ## need to handle lists of unnamed dois
#    else if(is.null(names(x)) & grep("^10.",x))  ## is a doi without a name

    } else {
      # See if x is a bibkey name for the doi, rather than the doi
      y <- named_dois[match(x, names(named_dois))]
      if(!is.na(y)) # match found, swap doi for the key
        x <- y
    }
  }
  out <- sapply(x,function(x){
    if(is(x, "character")){
      entry <- ref(x)
    } else # assume it's a bibentry object already
      entry <- x
    if(!is(entry, "bibentry")) # if it's not a bibentry, print "?"
      out <- I("?")
    else {
      ## keep track of what we've cited so far
      options(works_cited = c(getOption("works_cited"), entry))
      out <-  authoryear_p(entry)
    }
    out
  })
  I(paste("(", paste(out, collapse="; "), ")", sep=""))
}


