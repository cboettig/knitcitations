knitcitations
=============

- **Author**: [Carl Boettiger](http://www.carlboettiger.info/)
- **License**: [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
- [Package source code on Github](https://github.com/cboettig/knitcitations)
- [Online package documentation](http://cboettig.github.com/knitcitations/index.html)


`knitcitations` is an R package designed to add dynamic citations to dynamic documents created with [Yihui's knitr package](https://github.com/yihui/knitr).



Installation 
------------

Install directly from Github using [Hadley's devtools package](https://github.com/hadley/devtools)


You can also clone or download the repository and install with `R CMD INSTALL`. Once I'm through the early development phase a copy will be available on CRAN.


Quick start
-----------


```
## Loading required package: bibtex
```


Cite an article by DOI.  The full citation information is gathered automatically.


```r
citep("10.1890/11-0011.1")
```

[1] "(Abrams _et. al._ 2012)"


A key in the format `LastNameYear` is automatically created for this citation, so we can use it again without remembering the DOI.   


```r
citep("Abrams2012")
```

[1] "(Abrams _et. al._ 2012)"


(A custom key can also be given by naming the DOI, such as `citep(c(AbramsEtAl="10.1890/11-0011.1"))`).


If we have a bibtex file, we can cite such articles by those keys as well.  To demonstrate, let's first create a bibtex file with the citation information for some R packages, using the `bibtex` package utilities (a dependency of `knitcitations`):


```r
write.bibtex(c(Yihui2013 = citation("knitr"), Boettiger2013 = citation("knitcitations"), 
    TempleLang2012 = citation("RCurl")))
```

```
## Writing 1 Bibtex entries ...
```

```
## OK Results written to file 'knitcitations.bib'
```

```
## Writing 1 Bibtex entries ...
```

```
## OK Results written to file 'knitcitations.bib'
```

```
## Writing 1 Bibtex entries ...
```

```
## OK Results written to file 'knitcitations.bib'
```

```r
bib <- read.bibtex("knitcitations.bib")
```


Now we can generate citations from `bib`


```r
citep(bib[[2]])
```

```
## [1] "(Boettiger, 2012)"
```

```r
citep(bib["Yihui2013"])
```

```
## [1] "(Xie, 2013)"
```


Generate the final bibliography


```r
bibliography("html")
```

<p>Abrams P, Ruokolainen L, Shuter B and McCann K (2012).
&ldquo;Harvesting Creates Ecological Traps: Consequences of Invisible Mortality Risks in Predator–Prey Metacommunities.&rdquo;
<EM>Ecology</EM>, <B>93</B>.
ISSN 0012-9658, <a href="http://dx.doi.org/10.1890/11-0011.1">http://dx.doi.org/10.1890/11-0011.1</a>.

<p>Boettiger C (2012).
<EM>knitcitations: Citations for knitr markdown files</EM>.
R package version 0.3-0, <a href="https://github.com/cboettig/knitcitations">https://github.com/cboettig/knitcitations</a>.

<p>Xie Y (2013).
<EM>knitr: A general-purpose package for dynamic report generation in R</EM>.
R package version 1.0.7, <a href="http://yihui.name/knitr/">http://yihui.name/knitr/</a>.



Generate and use Bibtex files and more.  [See the full tutorial](https://github.com/cboettig/knitcitations/blob/master/inst/examples/citations.md).  
