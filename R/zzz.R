knitcitationsCache <- new.env(hash=TRUE)
knitcitations_options <- new.env(hash=TRUE) 
assign("tooltip",  FALSE, envir=knitcitations_options)
assign("linked", TRUE,  envir=knitcitations_options)
assign("numerical", FALSE,  envir=knitcitations_options)
assign("bibtex_data", FALSE, envir=knitcitations_options)

