# If you are using conda environment need to activate it
# library(reticulate)
# reticulate::use_condaenv("dsc")
library(dscrutils)

dsc_dir <- "01_wiki_example"
dscout <-
  dscquery(dsc.outdir = dsc_dir,
  # A query target may be a module, a module group, a module parameter, or a module output.
  # Note: This differs from the wiki as we need to include "score" and "analyze" explicitly to get the name of the module (ab_err, sq_err)
           targets = c(
                "simulate",
                "simulate.true_mean",
                "analyze",
                "analyze.est_mean",
                "score.error",
                "score"),
           )

head(dscout)

# Common mistake is accessing the module output directly
# Will have a column of NAs
dscout_inc <-
  dscquery(dsc.outdir = dsc_dir,
           targets = c("simulate.true_mean","analyze.est_mean","sq_err.error", "abs_err.error"))
head(dscout_inc)
