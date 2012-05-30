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
#' citep(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
#' citep("Halpern2006")
#' 
citep <- function(x){
  out <- cite(x, inline_format=authoryear_p)
  I(paste("(", paste(out, collapse="; "), ")", sep=""))
}


#' Add a textual citation 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a text inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @export
#' @import knitr
#' @examples
#' library(knitcitations)
#'  citet("10.3998/3336451.0009.101")
#'  ## Read in the bibtex information for some packages:
#'  knitr <- citation("knitr") 
#'  citet(knitr)
#'  # generate the full bibliography:
#'  bibliography()
#' ## Assign a citation key to a doi and then use it later:
#' citet(c(Halpern2006="10.1111/j.1461-0248.2005.00827.x"))
#' citet("Halpern2006")
#' 
citet <- function(x){
  out <- cite(x, inline_format=authoryear_t)
  I(paste(paste(out, collapse="; "), sep=""))
}




cite <- function(x, inline_format){
  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited")))
    cleanbib()
 current <- bibliography()
  existing <- sapply(current, function(x) x$key)
  out <- sapply(x,function(x){
    m <- match(x, existing)
    if(!is.na(m))
      entry <- current[[m]] 
    else if(is(x, "character")){
      key = names(x)
      entry <- ref(x)
      entry <- create_bibkey(entry, key=key, existing=existing)
    } else {# assume it's a bibentry object already
      key = names(x)
      entry <- x
      entry <- create_bibkey(entry, key=key)
    }

    if(!is(entry, "bibentry")) # if it's not a bibentry, print "?"
      out <- I("?")
    else {
      ## keep track of what we've cited so far
      options(works_cited = c(getOption("works_cited"), entry))
      out <-  inline_format(entry)
    }
    out
  })
}


