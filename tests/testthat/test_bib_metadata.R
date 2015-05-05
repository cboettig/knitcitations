context("bib_metadata")
library("knitcitations")

test_that("DOI returned field values as expected", {
  Bilder2006 <- bib_metadata("10.3998/3336451.0009.101")
  expect_equal(bib_metadata("10.3998/3336451.0009.101")$title,  "In Google We Trust?")
})
