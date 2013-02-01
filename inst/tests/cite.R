test_that("Citation handles all types", {
  a <- citep("10.1890/11-0011.1") 
  expect_is(a, "AsIs")
  expect_equivalent(a, I("(Abrams _et. al._ 2012)"))
})



test_that("knitcitations_data file initialized", {
   a <-  citep("10.1890/11-0011.1")
   # create a bibentry object of this article
   b <- ref("10.1890/11-0011.1")
   # cite the bibentry object, should avoid creating a duplicate
   a2 <- citep(b)
   # Did this create a bibfile we can read?
#   b <- read.bib("knitcitations.bib")
#   expect_is(b, "bibentry")
})

# entry entered as doi, later as doi again, later as bibentry, later as bibkey.  Does this avoid duplicates?  
