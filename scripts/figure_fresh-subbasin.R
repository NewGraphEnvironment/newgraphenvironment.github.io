# Byman-Ailport coho subbasin map at 150 dpi: content/project/open_source_software/fresh_subbasin.png
#
# Knits fresh's own vignette source, which reads the data fresh installs, at a higher resolution than the
# vignette's default. FRESH_RMD is vignettes/subbasin-query.Rmd.orig from fresh. Run from any directory; the
# map lands in OUT_DIR/figure/plot-subbasin-1.png:
#
#   FRESH_RMD=<file> OUT_DIR=<dir> Rscript scripts/figure_fresh-subbasin.R

rmd <- Sys.getenv("FRESH_RMD")
dir_out <- Sys.getenv("OUT_DIR", ".")
if (!file.exists(rmd) || !dir.exists(dir_out)) stop("set FRESH_RMD and OUT_DIR", call. = FALSE)
rmd <- normalizePath(rmd)
setwd(dir_out)
params <- list(update_gis = FALSE)
knitr::opts_chunk$set(dpi = 150)
knitr::knit(rmd, output = "subbasin.md", quiet = TRUE)
