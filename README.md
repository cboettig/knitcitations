---
title: An introduction to knitcitations
author: Carl Boettiger
date: 27 May 2014
bibliography: references.bib
---

[![Build Status](https://travis-ci.org/cboettig/knitcitations.svg?branch=master)](https://travis-ci.org/cboettig/knitcitations)
[![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/knitcitations)](https://cran.r-project.org/package=knitcitations)

<!--
%\VignetteEngine{knitr::rmarkdown}
%\VignetteIndexEntry{An introduction to knitcitations}
-->

<!--
[![Build Status](https://travis-ci.org/cboettig/knitcitations.png)](https://travis-ci.org/cboettig/knitcitations)
-->


knitcitations
=============



- **Author**: [Carl Boettiger](https://www.carlboettiger.info/)
- **License**: [MIT](https://opensource.org/licenses/MIT)
- [Package source code on Github](https://github.com/cboettig/knitcitations)
- [**Submit Bugs and feature requests**](https://github.com/cboettig/knitcitations/issues)


`knitcitations` is an R package designed to add dynamic citations to dynamic documents created with [Yihui's knitr package](https://github.com/yihui/knitr).



Installation 
------------

Install the development version directly from Github 

```r
library(devtools)
install_github("cboettig/knitcitations")
```

Or install the current release from your CRAN mirror with `install.packages("knitcitations")`.  


Quick start: rmarkdown (pandoc) mode
------------------------------------

Start by loading the library.  It is usually good to also clear the bibliographic environment after loading the library, in case any citations are already stored there:  


```r
library("knitcitations")
cleanbib()
```

Set pandoc as the default format:


```r
options("citation_format" = "pandoc")
```

(Note: The old method will eventually be deprecated.  For documents using `knitcitations <= 0.5` it will become necessary to set this as `"compatibility"`).  

### Cite by DOI

Cite an article by DOI and the full citation information is gathered automatically. By default this now generates a citation in pandoc-flavored-markdown format. We use the inline command `citep("10.1890/11-0011.1")` to create this citation [@Abrams_2012].  

An in-text citation is generated with `citet`, such as `citet("10.1098/rspb.2013.1372")` creating the citation to @Boettiger_2013.  


### Cite by URL

Not all the literature we may wish to cite includes DOIs, such as [arXiv](https://arxiv.org/) preprints, Wikipedia pages, or other academic blogs.  Even when a DOI is present it is not always trivial to locate.  With version 0.4-0, `knitcitations` can produce citations given any URL using the [Greycite API](http://greycite.knowledgeblog.org). For instance, we can use the call `citep("http://knowledgeblog.org/greycite")` to generate the citation to the Greycite tool [@greycite2739].  

### Cite bibtex and bibentry objects directly 

We can also use `bibentry` objects such as R provides for citing packages (using R's `citation()` function): `citep(citation("knitr"))` produces [@Xie_2014; @Xie_2013; @Xie_2014a].  Note that this package includes citations to three objects, and pandoc correctly avoids duplicating the author names.  In pandoc mode, we can still use traditional pandoc-markdown citations like `@Boettiger2013` which will render as @Boettiger2013 without any R code, provided the citation is already in the `.bib` file we name (see below).


### Re-using Keys

When the citation is called, a key in the format `FirstAuthorsLastName_Year` is automatically created for this citation, so we can now continue to cite this article without remembering the DOI, using the command `citep("Abrams_2012")` creates the citation [@Abrams_2012] without mistaking it for a new article.  






### Displaying the final bibliography

At the end of the document, include a chunk containing the command:


```r
write.bibtex(file="references.bib")
```

Use the chunk options `echo=FALSE` and `message=FALSE` to hide the chunk command and output.  

This creates a Bibtex file with the name given.  [Pandoc](https://johnmacfarlane.net/pandoc) can then be used to compile the markdown into HTML, MS Word, LaTeX, PDF, or many other formats, each with the desired journal styling. Pandoc is now integrated with [RStudio](https://rstudio.com) through the [rmarkdown](https://rmarkdown.rstudio.com/) package.  Pandoc appends these references to the end of the markdown document automatically.  In this example, we have added a yaml header to our Rmd file which indicates the name of the bib file being used, and the optional link to a [CSL](https://github.com/citation-style-language/styles) stylesheet which formats the output for the ESA journals:

```yaml
---
bibliography: "references.bib"
csl: "ecology.csl"
output:
  html_document
---
```


Then calling `rmarkdown::render("intro.Rmd")` from R on the tutorial compiles the output markdown, with references in the format of the ESA journals.  

# References













