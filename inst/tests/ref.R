Bilder2006 <- ref("10.3998/3336451.0009.101")
test_that("DOI returned field values as expected", {
  expect_equal(ref("10.3998/3336451.0009.101")$title,  "in Google we Trust?")
})