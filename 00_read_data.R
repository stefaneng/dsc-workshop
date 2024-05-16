# If you are using conda environment need to activate it
# library(reticulate)
# reticulate::use_condaenv("dsc")
library(dscrutils)

dsc_dir <- "00_first"
dscout1 <- dscquery(dsc.outdir = dsc_dir,
                   targets    = c(
                    "normal.true_mean",
                    "mean.mean"
                    )
            )
