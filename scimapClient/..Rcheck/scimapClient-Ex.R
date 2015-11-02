pkgname <- "scimapClient"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('scimapClient')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("addUserMetadata")
### * addUserMetadata

flush(stderr()); flush(stdout())

### Name: addUserMetadata
### Title: Add user metadata
### Aliases: addUserMetadata

### ** Examples

## Not run: addUserMetadata(list(project="Arrow trajectory analysis", version="v5.4"))



cleanEx()
nameEx("deanonymize")
### * deanonymize

flush(stderr()); flush(stdout())

### Name: deanonymize
### Title: Associate personal identity with usage data
### Aliases: deanonymize

### ** Examples

library(scimapClient)
## Not run: 
##D deanonymize("Chris Bogart", "http://quetzal.bogarthome.net/",
##D     "http://scholar.google.com/citations?user=FQSWa4sAAAAJ&hl=en")
## End(Not run)



cleanEx()
nameEx("isEnabledScimap")
### * isEnabledScimap

flush(stderr()); flush(stdout())

### Name: isEnabledScimap
### Title: Does 'scimapClient' have permission to track usage?
### Aliases: isEnabledScimap

### ** Examples

## Type this in interactive mode to see whether
## the scimapClient package is enabled to collect usage data.
isEnabledScimap()
# returns TRUE or FALSE



cleanEx()
nameEx("scimapClient")
### * scimapClient

flush(stderr()); flush(stdout())

### Name: scimapClient
### Title: Collects and reports usage data on R packages
### Aliases: scimapClient scimapClient-package

### ** Examples

##  Call this to reenable scimap
## Not run: enableScimap()

##  Call this to toggle scimap off if you do not want to send data.
## Not run: disableScimap()

## Call this to see what kind of information is sent
previewPacket()



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
