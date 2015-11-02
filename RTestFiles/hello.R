#!/usr/bin/env Rscript
library('datasets')
library('foreign')
library('graphics')
sayHello <- function(){
    fileConn<-file("output.txt")
    writeLines(c("Hello World"), fileConn)
    close(fileConn)
}

sayHello()
