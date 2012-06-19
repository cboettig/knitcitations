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
#'  knitcitations <- citation("knitcitations")
#'  # generate the parentetical citation for these:
#'  citep(list(knitr,knitcitations))
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



#' Add a citation (internal for citet and citep) 
#'
#' @param x a doi or list of dois, or a bibentry (or list of bibentries)
#' @return a parenthetical inline citation
#' @details Stores the full citation in a "works_cited" list,
#' which can be printed with \code{\link{bibliography}}
#' @import knitr
#' @keywords internal
cite <- function(x, inline_format){
  ## initialize the works cited list if not avaialble
  if(is.null(getOption("works_cited")))
    cleanbib()

  ## Identify what references we already know about
  current <- bibliography(debug=TRUE)
  existing <- sapply(current, function(x) x$key)

  preset_keys <- names(x)

  out <- sapply(1:length(x),function(i){
    key = preset_keys[i]
    m <- match(x[[i]], existing)
    if(!is.na(m))
      entry <- current[[m]] 
    else if(is(x[[i]], "character")){
      entry <- ref(x[[i]])
      entry <- create_bibkey(entry, key=key, current=current)
    } else if(is(x[[i]], "bibentry")) {# it's a bibentry object already
      entry <- x[[i]]
      entry <- create_bibkey(entry, key=key)
    } else {
      warning("citation not found")
      entry <- I("?")
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


