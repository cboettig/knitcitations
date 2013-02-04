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

It is usually good to clear the bibliographic environment after loading the library, in case any citations are already stored there.  





Cite an article by DOI and the full citation information is gathered automatically.  


```r
citep("10.1890/11-0011.1")
```

[1] "Abrams _et. al._ 2012"


Typically this is done with knitr's inline code syntax, creating a parenthetical citation in the text like this Abrams _et. al._ 2012.  We display the command in code blocks only for documenting purposes here.  `citep` provides a parenthetical citation; a in-text citation is generated with `citet`, such as this sentence cites Abrams _et. al._ (2012).  

When the citation is called, a key in the format `LastNameYear` is automatically created for this citation, so we can now continue to cite this article without remembering the DOI, using the command:


```r
citep("Abrams2012")
```

[1] "Abrams _et. al._ 2012"


Note that a custom key can also be given by naming the DOI, such as `citep(c(AbramsEtAl="10.1890/11-0011.1"))`.


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
## [1] "Boettiger, 2012"
```

```r
citep(bib["Yihui2013"])
```

```
## [1] "Xie, 2013"
```




Generate the final bibliography in a knitr block using the chunk option `results='asis'` to display as text rather than code:  


```r
bibliography()
```






Abrams P, Ruokolainen L, Shuter B and McCann K (2012). "Harvesting
Creates Ecological Traps: Consequences of Invisible Mortality
Risks in Predator–Prey Metacommunities." _Ecology_, *93*. ISSN
0012-9658, <URL: http://dx.doi.org/10.1890/11-0011.1>.

Boettiger C (2012). _knitcitations: Citations for knitr markdown
files_. R package version 0.3-1, <URL:
https://github.com/cboettig/knitcitations>.

Xie Y (2013). _knitr: A general-purpose package for dynamic report
generation in R_. R package version 1.0.7, <URL:
http://yihui.name/knitr/>.



Other formats can be given as options to `bibliography`, as described in the help documentation, `?bibliography`.  [See the full tutorial](https://github.com/cboettig/knitcitations/blob/master/inst/examples/citations.md) for more about knitcitations.  

## Semantic RDFa

Knitcitations can also return semantic RDFa markup around your citations.  Simply select the "rdfa" in the bibliography option.  



```r
bibliography("rdfa")
```

<div prefix="dc: http://purl.org/dc/terms/,
                      bibo: http://purl.org/ontology/bibo/,
                      foaf: http://xmlns.com/foaf/spec/,
                      biro: http://purl.org/spar/biro/"
        property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
<li> <span property="dc:title">Harvesting Creates Ecological Traps: Consequences of Invisible Mortality Risks in Predator–Prey Metacommunities.</span> <span property="dc:creator"> <span property="foaf:givenName">Peter A.</span> <span property="foaf:familyName">Abrams</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Lasse</span> <span property="foaf:familyName">Ruokolainen</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Brian J.</span> <span property="foaf:familyName">Shuter</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Kevin S.</span> <span property="foaf:familyName">McCann</span>, </span>  (<span property="dc:date">2012</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
                            resource="[http://purl.org/dc/terms/journal]">
                        <span property="http://purl.org/dc/terms/title"
                                content=" Ecology ">
                        </span>
                          <span property="bibo:shortTitle"> Ecology </span>
               </span>  <span property="bibo:volume">93</span>    <a property="bibo:doi" href="http://dx.doi.org/10.1890/11-0011.1">10.1890/11-0011.1</a> </li>
 </ul>
</div>
<div prefix="dc: http://purl.org/dc/terms/,
                      bibo: http://purl.org/ontology/bibo/,
                      foaf: http://xmlns.com/foaf/spec/,
                      biro: http://purl.org/spar/biro/"
        property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
<li> <span property="dc:title">knitcitations: Citations for knitr markdown files.</span> <span property="dc:creator"> <span property="foaf:givenName">Carl</span> <span property="foaf:familyName">Boettiger</span>, </span>  (<span property="dc:date">2012</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
                            resource="[http://purl.org/dc/terms/journal]">
                        <span property="http://purl.org/dc/terms/title"
                                content="  ">
                        </span>
                          <span property="bibo:shortTitle">  </span>
               </span>     <a property="bibo:doi" href="http://dx.doi.org/"></a> </li>
 </ul>
</div>
<div prefix="dc: http://purl.org/dc/terms/,
                      bibo: http://purl.org/ontology/bibo/,
                      foaf: http://xmlns.com/foaf/spec/,
                      biro: http://purl.org/spar/biro/"
        property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
<li> <span property="dc:title">knitr: A general-purpose package for dynamic report generation in R.</span> <span property="dc:creator"> <span property="foaf:givenName">Yihui</span> <span property="foaf:familyName">Xie</span>, </span>  (<span property="dc:date">2013</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
                            resource="[http://purl.org/dc/terms/journal]">
                        <span property="http://purl.org/dc/terms/title"
                                content="  ">
                        </span>
                          <span property="bibo:shortTitle">  </span>
               </span>     <a property="bibo:doi" href="http://dx.doi.org/"></a> </li>
 </ul>
</div>



Here's what the source HTML looks like (generated as R output by not setting `results="asis"` in the knitr block):


```r
bibliography("rdfa")
```

```
## <div prefix="dc: http://purl.org/dc/terms/,
##                       bibo: http://purl.org/ontology/bibo/,
##                       foaf: http://xmlns.com/foaf/spec/,
##                       biro: http://purl.org/spar/biro/"
##         property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
## <li> <span property="dc:title">Harvesting Creates Ecological Traps: Consequences of Invisible Mortality Risks in Predator–Prey Metacommunities.</span> <span property="dc:creator"> <span property="foaf:givenName">Peter A.</span> <span property="foaf:familyName">Abrams</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Lasse</span> <span property="foaf:familyName">Ruokolainen</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Brian J.</span> <span property="foaf:familyName">Shuter</span>, </span><span property="dc:creator"> <span property="foaf:givenName">Kevin S.</span> <span property="foaf:familyName">McCann</span>, </span>  (<span property="dc:date">2012</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
##                             resource="[http://purl.org/dc/terms/journal]">
##                         <span property="http://purl.org/dc/terms/title"
##                                 content=" Ecology ">
##                         </span>
##                           <span property="bibo:shortTitle"> Ecology </span>
##                </span>  <span property="bibo:volume">93</span>    <a property="bibo:doi" href="http://dx.doi.org/10.1890/11-0011.1">10.1890/11-0011.1</a> </li>
##  </ul>
## </div>
## <div prefix="dc: http://purl.org/dc/terms/,
##                       bibo: http://purl.org/ontology/bibo/,
##                       foaf: http://xmlns.com/foaf/spec/,
##                       biro: http://purl.org/spar/biro/"
##         property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
## <li> <span property="dc:title">knitcitations: Citations for knitr markdown files.</span> <span property="dc:creator"> <span property="foaf:givenName">Carl</span> <span property="foaf:familyName">Boettiger</span>, </span>  (<span property="dc:date">2012</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
##                             resource="[http://purl.org/dc/terms/journal]">
##                         <span property="http://purl.org/dc/terms/title"
##                                 content="  ">
##                         </span>
##                           <span property="bibo:shortTitle">  </span>
##                </span>     <a property="bibo:doi" href="http://dx.doi.org/"></a> </li>
##  </ul>
## </div>
## <div prefix="dc: http://purl.org/dc/terms/,
##                       bibo: http://purl.org/ontology/bibo/,
##                       foaf: http://xmlns.com/foaf/spec/,
##                       biro: http://purl.org/spar/biro/"
##         property="http://purl.org/spar/biro/ReferenceList"> <ul class='bibliography'> 
## <li> <span property="dc:title">knitr: A general-purpose package for dynamic report generation in R.</span> <span property="dc:creator"> <span property="foaf:givenName">Yihui</span> <span property="foaf:familyName">Xie</span>, </span>  (<span property="dc:date">2013</span>)  <span rel="http://purl.org/dc/terms/isPartOf" 
##                             resource="[http://purl.org/dc/terms/journal]">
##                         <span property="http://purl.org/dc/terms/title"
##                                 content="  ">
##                         </span>
##                           <span property="bibo:shortTitle">  </span>
##                </span>     <a property="bibo:doi" href="http://dx.doi.org/"></a> </li>
##  </ul>
## </div>
```


### CiTO  

Additional semantic markup can be added the the citations themselves, such as the reason for the citation.  For instance, we can identify that we have used the method from <a rel="http://purl.org/spar/cito/usesMethodIn", resource="http://dx.doi.org/10.1186/2041-1480-1-S1-S6 >Shotton (2010)</a> with the inline command `citet("10.1186/2041-1480-1-S1-S6", cito = "usesMethodIn")`.  

