knitcitations
=============

- **Author**: [Carl Boettiger](http://www.carlboettiger.info/)
- **License**: [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
- [Package source code on Github](https://github.com/cboettig/knitcitations)
- [Online package documentation](http://cboettig.github.com/knitcitations/index.html)


`knitcitations` is an R package designed to add dynamic citations to dynamic documents created with [Yihui's knitr package](https://github.com/yihui/knitr).



Installation 
------------

Install the development version directly from Github 

```r
library(devtools)
install_github("knitcitations", "cboettig")
```

Or install the current release from your CRAN mirror with `install.packages("knitcitations")`.  


Quick start
-----------

It is usually good to clear the bibliographic environment after loading the library, in case any citations are already stored there.  



```
## Loading required package: bibtex
```


### Cite by DOI

Cite an article by DOI and the full citation information is gathered automatically.  


```r
citep("10.1890/11-0011.1")
```

[1] "(<a href=\"http://dx.doi.org/10.1890/11-0011.1\">Abrams _et. al._ 2012</a>)"


Typically this is done with knitr's inline code syntax, creating a parenthetical citation in the text like this (<a href="http://dx.doi.org/10.1890/11-0011.1">Abrams _et. al._ 2012</a>).  We display the command in code blocks only for documenting purposes here.  `citep` provides a parenthetical citation; a in-text citation is generated with `citet`, such as this sentence cites <a href="http://dx.doi.org/10.1890/11-0011.1">Abrams _et. al._ (2012)</a>.  


### Cite by URL

Not all the literature we may wish to cite includes DOIs, such as [arXiv](http://arxiv.org) preprints, Wikipedia pages, or other academic blogs.  Even when a DOI is present it is not always trivial to locate.  With version 0.4-0, `knitcitations` can produce citations given any URL using the [Greycite API](http://greycite.knowledgeblog.org). For instance, we can use the call 


```r
citep("http://knowledgeblog.org/greycite")
```

[1] "(<a href=\"http://knowledgeblog.org/greycite\">Lord, 2012</a>)"


to generate the citation to the Greycite tool.  

### Cite from a bibtex file 

If we have a bibtex file, we can cite such articles by those keys as well.  To demonstrate, let's first create a bibtex file with the citation information for some R packages, using the `bibtex` package utilities (a dependency of `knitcitations`):


```r
write.bibtex(c(Yihui2013 = citation("knitr"), Boettiger2013 = citation("knitcitations"), 
    TempleLang2012 = citation("RCurl")))
bib <- read.bibtex("knitcitations.bib")
```


Now we can generate citations from `bib`


```r
citep(bib[[2]])
```

```
## [1] "(<a href=\"https://github.com/cboettig/knitcitations\">Boettiger, 2012</a>)"
```

```r
citep(bib["Yihui2013"])
```

```
## [1] "(<a href=\"http://yihui.name/knitr/\">Xie, 2013</a>)"
```



### Re-using Keys

When the citation is called, a key in the format `LastNameYear` is automatically created for this citation, so we can now continue to cite this article without remembering the DOI, using the command:


```r
citep("Abrams2012")
```

[1] "(<a href=\"http://dx.doi.org/10.1890/11-0011.1\">Abrams _et. al._ 2012</a>)"


Note that a custom key can also be given by naming the DOI, such as `citep(c(AbramsEtAl="10.1890/11-0011.1"))`.

### Displaying the final bibliography

At the end of our document we can generate the traditional "References" or "Works Cited" list in a knitr block using the chunk option `results='asis'` to display as text rather than code:  


```r
bibliography()
```


Other formats can be given as options to `bibliography`, as described in the help documentation, `?bibliography`.   


## Links and tooltips

In-text citations are now linked by default to the article.  We can turn this on or off in a single citation like so: `citep("Abrams2012", linked=FALSE)`, or toggle this behavior on or off globally using `cite_options(linked=TRUE)` at the beginning of our document.  Using the popular javascript library from [bootstrap](http://twitter.github.com/bootstrap), we can tell `knitcitations` to include a javascript tooltip on mouseover.  (This effect will not work inside a github repo due the the lack of the javascript library, but can easily be deployed on a website, see <a href="http://carlboettiger.info/2013/02/22/semantic-citations-for-the-notebook-and-knitr.html" property="http://purl.org/spar/cito/discusses" >Boettiger (2013)</a>. This function is off by default can be toggled on or off in the same way, `cite_options(tooltip=TRUE)`.  

![Screenshot of citation produced with a tooltip.](http://farm9.staticflickr.com/8233/8499745634_04a13fe93e_o.png)

## Semantics 

### CiTO  

Additional semantic markup can be added the the citations themselves, such as the reason for the citation.  For instance, we can identify that we have used the method from <a href="http://dx.doi.org/10.1186/2041-1480-1-S1-S6" property="http://purl.org/spar/cito/usesMethodIn" >Shotton (2010)</a> with the inline command `citet("10.1186/2041-1480-1-S1-S6", cito = "usesMethodIn")`.  

More discussion on using `knitcitations` for CITO and semantic markup can be found in <a href="http://carlboettiger.info/2013/02/22/semantic-citations-for-the-notebook-and-knitr.html" property="http://purl.org/spar/cito/usesMethodIn" >Boettiger (2013)</a>.  



