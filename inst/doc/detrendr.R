## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment = "#>")

## ----load----------------------------------------------------------------
library(detrendr)

## ----display------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
path <- system.file("extdata", "bleached.tif", package = "detrendr")
img <- read_tif(path)
dim(img)  # img has 500 frames
display(img[, , 1],  # first frame
        breaks = 0:500, col = grDevices::grey(seq(0, 1, length.out = 500)))
display(img[, , 500],  # last frame
        breaks = 0:500, col = grDevices::grey(seq(0, 1, length.out = 500)))

## ----frame means--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
plot(apply(img, 3, mean), ylim = c(60, 150))

## ----detrend------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
system.time(corrected_exp <- img_detrend_exp(img, "auto", 
                                             seed = 0, parallel = 2))["elapsed"]
display(corrected_exp[, , 1],  # first frame
        breaks = 0:500, col = grDevices::grey(seq(0, 1, length.out = 500)))
display(corrected_exp[, , 500],  # last frame
        breaks = 0:500, col = grDevices::grey(seq(0, 1, length.out = 500)))

## ----corrected frame means----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
plot(apply(corrected_exp, 3, mean), ylim = c(60, 150))

## ----boxcar and polynom-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
system.time(corrected_boxcar <- img_detrend_boxcar(img, "auto", 
                                  seed = 0, parallel = 2))["elapsed"]
system.time(corrected_polynom <- img_detrend_polynom(img, "auto", 
                                   seed = 0, parallel = 2))["elapsed"]

## ----compare brightnesses-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
mean(brightness_pillars(corrected_exp))
mean(brightness_pillars(corrected_boxcar))
mean(brightness_pillars(corrected_polynom))

