content("citations")

test_that("we can cite by doi", {
   a <-  citep("10.1890/11-0011.1")
})

# entry entered as doi, later as doi again, later as bibentry, later as bibkey.  Does this avoid duplicates?  
