context("citations")

library("knitcitations")
cleanbib()

test_that("we can cite by doi", {
   testthat::skip_on_cran()
  
   a <-  citep("10.1093/sysbio/sys025")
   expect_match(a, "Vos")
   cleanbib()
})

test_that("we can cite with a crossref search", {
   testthat::skip_on_cran()
  
   a <-  citep("Vos NeXML 2012")
   expect_match(a, "Vos")
  
   b <- bibliography()
   expect_identical(b['Vos_2012']$doi, "10.1093/sysbio/sys025")
   cleanbib()
})


test_that("We can cite by R package / bibentry", {
  testthat::skip_on_cran()
  
          a <- citet(citation("testthat"))
          expect_match(a, "Wickham")

          b <- bibliography()
          expect_match(b[1]$title, "testthat")
   cleanbib()

})

test_that("We create unique keys when necessary", {
  testthat::skip_on_cran()
  
  cite_options(citation_format = "pandoc")
  a <- citet("10.1098/rspb.2012.2085")
  b <- citet("10.1098/rsif.2012.0125")
  expect_false(identical(a,b))

  bib <- bibliography()
  expect_false(identical(bib[1]$key, bib[2]$key))
  cleanbib()
})


test_that("We create textual citations when necessary in text format", {
  testthat::skip_on_cran()
  
  cite_options(citation_format = "text")
  a <- citet("10.1098/rspb.2012.2085")
  b <- citet("10.1098/rsif.2012.0125")
  expect_false(identical(a,b))

})

test_that("We can do trivial things", {
  expect_equal(1+1, 2)
})


# entry entered as doi, later as doi again, later as bibentry, later as bibkey.  Does this avoid duplicates?  
