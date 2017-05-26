library(shinyrAtlantis)
library(stringr)
library(tidyverse)

#shinyrAtlantis::SpatialDistributionsExample()
#shinyrAtlantis::DisplayParametersExample()
#shinyrAtlantis::DisplayInitializationExample()

## bgm
bgm.file <- "Antarctica_28.bgm"
#obj <- make.sh.dist.object(bgm.file)
#sh.dist(obj)

## init
# nc.file <- "input.nc"
# obj <- make.sh.init.object(bgm.file, nc.file)
# sh.init(obj)

## 
#grp.file <- "./AntarcticGroups.csv"
#prm.file <- "./SO28_biol.prm"

#obj <- make.sh.prm.object(bgm.file, grp.file, prm.file)
#sh.prm(obj)

salinity.file    <- "SOsaltdummy.nc"
temperature.file <- "SOtempdummy.nc"
exchange.file <- "exchange-fill.nc" #"SOhydrodummy.nc"
cum.depth <- c(0,20,50,100,200,300,400,750,1000,2000)  # cumulative water layer depths

input.object <- make.sh.forcings.object(
  bgm.file         = bgm.file,
  exchange.file    = exchange.file,
  cum.depth        = cum.depth,
  temperature.file = temperature.file,
  salinity.file    = salinity.file
)

## hacky hack
input.object$numtimes <- dim(input.object$temperature)[3]
input.object$t <-  angstroms::rawdata(temperature.file, "t")
input.object$numtimes <- length(input.object$t)
sh.forcings(input.object)
