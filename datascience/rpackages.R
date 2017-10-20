#!/usr/bin/Rscript
library(devtools)
install_github("armstrtw/rzmq")
install_github("IRkernel/repr")
install_github("IRkernel/IRkernel")
IRkernel::installspec(user = FALSE)
