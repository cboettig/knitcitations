knitcitations
=============

- **Author**: [Carl Boettiger](http://www.carlboettiger.info/)
- **License**: [CC0](http://creativecommons.org/publicdomain/zero/1.0/)


`knitcitations` is an R package designed to add dynamic citations to dynamic documents created with [Yihui's knitr package](https://github.com/yihui/knitr).


Use 
---

`knitcitations` allows dynamic citations by passing in the DOI of a paper, such as `citep("10.1111/j.1461-0248.2005.00827.x")`  It uses crossref to look up the citation information, and can insert a parenthetical or in-text citation.  A bibliography is then generated from citations and can be inserted using the command `bibliography()`.  Citations can also be included by bibtex shortcode.  A more detailed tutorial (using `knitr`) [can be found in inst/examples](https://github.com/cboettig/knitcitations/blob/master/inst/examples/citations.md). 


- This package is in early development. Please file bugs or requested features on the [Issues page](https://github.com/cboettig/knitcitations/issues). 
- [Package source code on Github](https://github.com/cboettig/knitcitations)
- [Online package documentation](http://cboettig.github.com/knitcitations/index.html)

Installation 
------------

Install directly from Github using [Hadley's devtools package](https://github.com/hadley/devtools)

```r
library(devtools)
install_github("knitcitations", "cboettig")
````

You can also clone or download the repository and install with `R CMD INSTALL`. Once I'm through the early development phase a copy will be available on CRAN.

