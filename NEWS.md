NEWS 
====

For more fine-grained list of changes or to report a bug, consult 

* [The issues log](https://github.com/cboettig/knitcitations/issues)
* [The commit log](https://github.com/cboettig/knitcitations/commits/master)

Versioning
----------

Releases will be numbered with the following semantic versioning format:

<major>.<minor>.<patch>

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor 
  and patch)
* New additions without breaking backward compatibility bumps the minor 
  (and resets the patch)
* Bug fixes and misc changes bumps the patch
* Following the RStudio convention, a .99 is appended after the patch
  number to indicate the development version on Github.  Any version
  Coming from Github will now use the .99 extension, which will never
  appear in a version number for the package on CRAN. 


For more information on SemVer, please visit http://semver.org/.

v1.0.11
-------

- Return to CRAN now that `bibtex` and `RefManageR` are back

v1.0.10
------

- Bugfix for PCRE2 regex compatibility

v1.0.9
------

- Minor bugfix for issue #102

v1.0.8
------

2017-06-24

- Avoid example that depends on XML (no longer inherited dependency from RefManageR)
- add badges to README


v1.0.7
------

- Avoid failures in CRAN tests do to network connectivity issues.
- Update importFrom directive for previously-considered-base package, `utils`

v1.0.5
------

- Add template file for the MIT license, as requested from CRAN. We include the entire MIT License


v1.0.4
------

- Add error handling when Greycite API cannot be reached

v1.0.3
--------

- Update vignette to reflect changes to `rmarkdown` and pandoc (see [#67](https://github.com/cboettig/knitcitations/issues/67))
- Fixed missing citation in vignette building (knitcitations default format for bibtex keys now has an underscore, `LastName_Year`)

v1.0.2
---------

- Fix passing of arguments to `cite_options` that was causing many options to be ignored. (See [#63](https://github.com/cboettig/knitcitations/issues/63))
- Added \donttest on examples needing internet connection (resource may not be available)
- Licence migrated to MIT

v1.0-1
------

This version is a ground-up rewrite of knitcitations, providing a more powerful interface while also streamlining the back end, mostly by relying more on external libraries for knitty gritty. While an effort has been made to preserve the most common uses, some lesser-used functions or function arguments have been significantly altered or removed. Bug reports greatly appreciated.  

- `citet`/`citep` now accept more options.  In addition to the four previously supported options (DOI, URL, bibentry or bibkey (of a previously cited work)), these now accept a plain text query (used in a CrossRef Search), or a path to a PDF file (which attempts metadata extraction).  

- Citation key generation is now handled internally, and cannot be configured just by providing a named argument to `citet`/`citep`.  

- The `cite` function is replaced by `bib_metadata`.  This function takes any argument to `citet`/`citep` as before (including the new arguments), see docs.  

- Linked inline citations now use the configuration: cite_options(style="markdown", hyperlink="to.doc") provides a link to the DOI or URL of the document, using markdown format.  

- Support for cito and tooltip have been removed.  These may be restored at a later date.  (The earlier implementation did not appropriately abstract the use of these features from the style/formatting of printing the citation, making generalization hard.  

- `bibliography` now includes CSL support directly for entries with a DOI using the `style=` argument.  No need to provide a CSL file itself, just the name of the journal (or rather, the name of the corresponding csl file: full journal name, all lower case, spaces as dashes). See https://github.com/cboettig/knitcitations/issues/38 

- `bibliography` formatting has otherwise been completely rewritten, and no longer uses print_markdown, print_html, and print_rdfa methods.  rdfa is no longer available, and other formats are controlled through cite_options.  For formal publication pandoc mode is recommended instead of `bibliography`.  



v0.6-2
------

- Apply accents to names for in-text citations (issue [#51](https://github.com/cboettig/knitcitations/issues/51))
- Use first name if author last name is not available, e.g. `citet(citation())` (issue [#55](https://github.com/cboettig/knitcitations/issues/55))


v0.6-1
------

- Bugfix in default `citep` method (caused by missing `page` argument)

v0.6-0
------

- Pandoc formatting is introduced as the prefered way to handle citations.  The `.Rmd` files remain as before, importing citation data on the fly with `citep()` and `citet` taking DOIs, URLs, or bibentries as arguments, but render in pandoc's markdown. The citations used are written to a bibtex file and the user must use pandoc (either directly or through RStudio's [rmarkdown](https://rmarkdown.rstudio.com/)) to format the citations appropriately.  See the updated vignette & README. This method has to be enabled with `options(citation_format = "pandoc")` at present, otherwise compatibility mode is enabled by default.  (see [#57](https://github.com/cboettig/knitcitations/issues/57)) 


v0.5-0
------
* html print method now provides support for bulleted lists, see [#41](https://github.com/cboettig/knitcitations/issues/41)


v0.4-7
------
* Hard-wrap roxygen documentation to avoid line overflows in pdf manual

v0.4-6
------
* html print method now handled directly in knitcitations just like the
  markdown print method, with ordering, etc, since default html printing 
  method sucks
* ~~Tooltip provides HTML formatting, with link (issue [#37](https://github.com/cboettig/knitcitations/issues/37))~~
* HTML formatting inside tooltip (data-html="true") removed, since incompatible
  with Pandoc parser. [pandoc/#831](https://github.com/jgm/pandoc/issues/831) 

v0.4-5
------

* Provide page range as option to `citep` and `citet` (see issue [#32](https://github.com/cboettig/knitcitations/issues/32))
* Fixes a bug in which page numbers were not grabbed from the DOI look-up  
  ([#33](https://github.com/cboettig/knitcitations/issues/33))  
* Date added to Description file so that users can cite the development version
  properly ([#34](https://github.com/cboettig/knitcitations/issues/34))

v0.4-4
------

* Depends R (>= 2.15.0)
* Released to CRAN (2013-03-18)
* Minor changes: replace paste0 with paste, sep=""


v0.4-3
------

* Some bugfixes to bib_format method
* tooltip javascript uses class 'showtooltip' rather than rel='tooltip' to 
  avoid conflicting semantic meaning and styling and to avoid clashes with  
  existing 'tooltip' class in twitter bootstrap
* cito links fix href and use rel instead of property


v0.4-2
------

* Testing out `bib_format` method to change order of citation elements in 
  reference list

v0.4-1
------

* Fixes Issue [#27](https://github.com/cboettig/knitcitations/issues/27) in 
  rdfa printing
* Nicer markdown printing
* keep each function in separate file

v0.4-0
------

### Major changes

* Support for citations by URL.  Paste the full URL of any academic
  journal or other webpage.  Uses the Greycite API 
* Introduces linked inline citations as an option (previously active
  only for CITO links).  Inline citation text will be linked directly
  to the article by DOI or URL.  Toggle on or off using cite_options
  globally, or passing `linked=FALSE` to the calls to `citet` or `citep`
* Introduces tooltips option. Mouse over an inline citation and see
  the full citation information.  * Introduces `cite_options`, to toggle
  certain settings such as tooltips, linked inline text,


### Minor changes

* in-line link will use URL if a DOI is not found
* `cite` is now exported to the namespace.  Useful to return a bibentry object 
  given a DOI or URL.  


v0.3-5
------

* Fix formatting of parenthetical citations (bug introduced previously 
  converted these to citet format)
* Additional documentation
* Install instructions for development version added to README

v0.3-4
------

* Avoid dropped citations caused by redundant key collisions, closes #21




v0.3-3
------

* Added a new display option, `bibliography('markdown')`
* fixed BUG in the printing of the text-based name in bibliography for bibstyle-based calls

v0.3-2
------

* Semantic citations now enabled.  `bibliography` can print with method 'rdfa'
  to provide RDFa enhanced HTML bibliography data, and citations can take cito
  arguments as an option. (Closes issues #16 and #17)
* `bibliography` now takes more options to match the `bibstyle` and `print.bibentry`
  functions.
* `citet` and `citep` take an optional argument for formating the citation, defaulting
  to `authoryear` format.  Future versions may move this into an option.  
* `newbib()` function initializes and clears existing cache files.  
* README.md updated with semantic examples and more background text (generated by 
  inst/examples/README.Rmd). 
* Some basic unit tests built in.  Could use more, but meanwhile closes #8.
* Test cases work with knit2html button in RStudio, closes #14

v0.3-1
------

* Switched to handling citation data using environment rather than an external bibfile.
  This does not refer to the handling of user-provided bibtex files as input data,
  which are supported as before, but changes only the backend management of that data.
  The external bibtex file method can be switched back on by setting 
  `options("bibtex_data" = TRUE)`.  
* There is no need to call `print(bibliography, "html")`, one can simply call 
  `bibliography()` or `bibliography("html")`. Sort is still an option, other 
  options that were for internal use (`debug`, `remove_duplicates`) are 
  removed as they are no longer necessary.  
* Several new functions have been added to handle the new methods.  


v0.2-0
------

* Fix vignette error that prevents knitr 1.0 submission
* Fixed errors on installing package and lack of entries in bibliography
* Semantic print option added but still in early testing 

v0.1-0
------

* `bibliography()` now takes style as an option (html, text, bibtex output)
* imports write.bib from pkgmaker package instead of from doRNG
* URL in description on CRAN

v0.0-2
------

* Initial Release
