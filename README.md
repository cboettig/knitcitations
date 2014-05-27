<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{An introduction to knitcitations}
-->

<p><a href="https://travis-ci.org/cboettig/knitcitations"><img src="https://travis-ci.org/cboettig/knitcitations.svg" alt="Build Status" /></a></p>
<h1 id="knitcitations">knitcitations</h1>
<ul>
<li><strong>Author</strong>: <a href="http://www.carlboettiger.info/">Carl Boettiger</a></li>
<li><strong>License</strong>: <a href="http://creativecommons.org/publicdomain/zero/1.0/">CC0</a></li>
<li><a href="https://github.com/cboettig/knitcitations">Package source code on Github</a></li>
<li><a href="https://github.com/cboettig/knitcitations/issues"><strong>Submit Bugs and feature requests</strong></a></li>
</ul>
<p><code>knitcitations</code> is an R package designed to add dynamic citations to dynamic documents created with <a href="https://github.com/yihui/knitr">Yihui's knitr package</a>.</p>
<h2 id="installation">Installation</h2>
<p>Install the development version directly from Github</p>
<pre class="sourceCode coffee"><code class="sourceCode coffee">library<span class="kw">(</span>devtools<span class="kw">)</span>
install_github<span class="kw">(</span><span class="st">&quot;knitcitations&quot;</span><span class="kw">,</span> <span class="st">&quot;cboettig&quot;</span><span class="kw">)</span></code></pre>
<p>Or install the current release from your CRAN mirror with <code>install.packages(&quot;knitcitations&quot;)</code>.</p>
<h2 id="quick-start-rmarkdown-pandoc-mode">Quick start: rmarkdown (pandoc) mode</h2>
<p>Start by loading the library. It is usually good to also clear the bibliographic environment after loading the library, in case any citations are already stored there:</p>
<pre class="sourceCode coffee"><code class="sourceCode coffee">library<span class="kw">(</span><span class="st">&quot;knitcitations&quot;</span><span class="kw">)</span>
cleanbib<span class="kw">()</span></code></pre>
<h3 id="cite-by-doi">Cite by DOI</h3>
<p>Cite an article by DOI and the full citation information is gathered automatically. By default this now generates a citation in pandoc-flavored-markdown format. We use the inline command <code>citep(&quot;10.1890/11-0011.1&quot;)</code> to create this citation <span class="citation">(Abrams et al. 2012)</span>.</p>
<p>An in-text citation is generated with <code>citet</code>, such as <code>citet(&quot;10.1098/rspb.2013.1372&quot;)</code> creating the citation to <span class="citation">Boettiger and Hastings (2013)</span>.</p>
<h3 id="cite-by-url">Cite by URL</h3>
<p>Not all the literature we may wish to cite includes DOIs, such as <a href="http://arxiv.org">arXiv</a> preprints, Wikipedia pages, or other academic blogs. Even when a DOI is present it is not always trivial to locate. With version 0.4-0, <code>knitcitations</code> can produce citations given any URL using the <a href="http://greycite.knowledgeblog.org">Greycite API</a>. For instance, we can use the call <code>citep(&quot;http://knowledgeblog.org/greycite&quot;)</code> to generate the citation to the Greycite tool <span class="citation">(Lord 2012)</span>.</p>
<h3 id="cite-bibtex-and-bibentry-objects-directly">Cite bibtex and bibentry objects directly</h3>
<p>We can also use <code>bibentry</code> objects such as R provides for citing packages (using R's <code>citation()</code> function): <code>citep(citation(&quot;knitr&quot;)</code> produces <span class="citation">(Xie 2013a, 2013b, 2014)</span>. Note that this package includes citations to three objects, and pandoc correctly avoids duplicating the author names. In pandoc mode, we can still use traditional pandoc-markdown citations like <code>@Boettiger2013</code> which will render as <span class="citation">Boettiger and Hastings (2013)</span> without any R code, provided the citation is already in the <code>.bib</code> file we name (see below).</p>
<h3 id="re-using-keys">Re-using Keys</h3>
<p>When the citation is called, a key in the format <code>FirstAuthorsLastNameYear</code> is automatically created for this citation, so we can now continue to cite this article without remembering the DOI, using the command <code>citep(&quot;Abrams2012&quot;)</code> creates the citation <span class="citation">(Abrams et al. 2012)</span> without mistaking it for a new article.</p>
<h3 id="displaying-the-final-bibliography">Displaying the final bibliography</h3>
<p>At the end of the document, include a chunk containing the command:</p>
<pre class="sourceCode coffee"><code class="sourceCode coffee">write<span class="kw">.</span>bibtex<span class="kw">(</span>file<span class="kw">=</span><span class="st">&quot;references.bib&quot;</span><span class="kw">)</span></code></pre>
<p>Use the chunk option <code>echo=FALSE</code> to hide the chunk command. This creates a Bibtex file with the name given. <a href="http://johnmacfarlane.net/pandoc">Pandoc</a> can then be used to compile the markdown into HTML, MS Word, LaTeX, PDF, or many other formats, each with the desired journal styling. Pandoc is now integrated with <a href="http://rstudio.com">RStudio</a> through the <a href="http://rmarkdown.rstudio.com">rmarkdown</a> package. Pandoc appends these references to the end of the markdown document automatically. In this example, we have added a yaml header to our Rmd file which indicates the name of the bib file being used:</p>
<pre class="sourceCode yaml"><code class="sourceCode yaml"><span class="ot">---</span>
<span class="fu">output:</span> 
  <span class="fu">html_document:</span>
    <span class="fu">pandoc_args:</span> <span class="kw">[</span>
      <span class="st">&quot;--biblio&quot;</span><span class="kw">,</span> <span class="st">&quot;references.bib&quot;</span><span class="kw">,</span>
      <span class="st">&quot;--csl&quot;</span><span class="kw">,</span> <span class="st">&quot;ecology.csl&quot;</span>
      <span class="kw">]</span>
<span class="ot">---</span></code></pre>
<p>Then calling <code>rmarkdown::render(&quot;tutorial.Rmd&quot;)</code> from R on the tutorial compiles the output markdown, with references in the format of the ESA journals.</p>
<h1 id="references">References</h1>
<!--

At the end of our document we can generate the traditional "References" or "Works Cited" list in a knitr block using the chunk option `results='asis'` to display as text rather than code:  


```coffee
bibliography()
```


- Peter A. Abrams, Lasse Ruokolainen, Brian J. Shuter, Kevin S. McCann,   (2012) Harvesting Creates Ecological Traps: Consequences of Invisible Mortality Risks in Predator–Prey Metacommunities.  *Ecology*  **93**  [10.1890/11-0011.1](http://dx.doi.org/10.1890/11-0011.1)
- Carl Boettiger,   (2012) knitcitations: Citations for knitr markdown files.  [https://github.com/cboettig/knitcitations](https://github.com/cboettig/knitcitations)
- Yihui Xie,   (2013) knitr: A general-purpose package for dynamic report generation in R.  [http://yihui.name/knitr/](http://yihui.name/knitr/)
- Phillip Lord,   (2012) Greycite.  *Knowledge Blog*  [http://knowledgeblog.org/greycite](http://knowledgeblog.org/greycite)


Other formats can be given as options to `bibliography`, as described in the help documentation, `?bibliography`.  For instance, we can specify the format as "markdown".  The custom formats "markdown" and "rdfa" take an additional argument, "ordering", which can specify what elements we want to print and what order they should be given in.  For instance, we can omit everything but the authors, year, and journal, given in that order:


```coffee
bibliography("markdown", ordering = c("authors", "year", "journal"))
```


- Peter A. Abrams, Lasse Ruokolainen, Brian J. Shuter, Kevin S. McCann,   (2012)  *Ecology*
- Carl Boettiger,   (2012)
- Yihui Xie,   (2013)
- Phillip Lord,   (2012)  *Knowledge Blog*


(Note that since version 0.5, "markdown" is the default and can be omitted)

### Links and tooltips

In-text citations are now linked by default to the article.  We can turn this on or off in a single citation like so: `citep("Abrams2012", linked=TRUE)`, creating the citation (<a href="http://dx.doi.org/10.1890/11-0011.1">Abrams _et. al._ 2012</a>).  We can toggle this behavior on or off globally using `cite_options(linked=TRUE)` at the beginning of our document.  


Using the popular javascript library from [bootstrap](http://twitter.github.com/bootstrap), we can tell `knitcitations` to include a javascript tooltip on mouseover.  (This effect will not work inside a github repo due the the lack of the javascript library, but can easily be deployed on a website, see Boettiger (2013). This function is off by default can be toggled on or off in the same way, `cite_options(tooltip=TRUE)`.  

![Screenshot of citation produced with a tooltip.](http://farm9.staticflickr.com/8233/8499745634_04a13fe93e_o.png)

## Semantics 

### CiTO  

Additional semantic markup can be added the the citations themselves, such as the reason for the citation.  For instance, we can identify that we have used the method from Shotton (2010) with the inline command `citet("10.1186/2041-1480-1-S1-S6", cito = "usesMethodIn")`.  

More discussion on using `knitcitations` for CITO and semantic markup can be found in Boettiger (2013).  



-->




<div class="references">
<p>Abrams, P. A., L. Ruokolainen, B. J. Shuter, and K. S. McCann. 2012. Harvesting creates ecological traps: consequences of invisible mortality risks in predator–prey metacommunities. Ecology 93:281–293.</p>
<p>Boettiger, C., and A. Hastings. 2013. no early warning signals for stochastic transitions: insights from large deviation theory. Proceedings of The Royal Society B: Biological Sciences 280:20131372–20131372.</p>
<p>Lord, P. 2012. Greycite. <a href="http://knowledgeblog.org/greycite">http://knowledgeblog.org/greycite</a>.</p>
<p>Xie, Y. 2013a. knitr: a general-purpose package for dynamic report generation in r.</p>
<p>Xie, Y. 2013b. Dynamic documents with R and knitr. Chapman; Hall/CRCBoca Raton, Florida.</p>
<p>Xie, Y. 2014. knitr: a comprehensive tool for reproducible research in R. <em>in</em> V. Stodden, F. Leisch, and R. D. Peng, editors. Implementing reproducible computational research. Chapman; Hall/CRC.</p>
</div>
