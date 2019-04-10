
# time Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/fasta.R

# nt <- 4
# comp <- TRUE
# 
# 
# cat(sprintf("%i threads, compressed: %s ...\n", nt, comp))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

# fa_file <- "ref.fa"
# ref <- read_fasta(fa_file)

ref <- create_genome(1, 10e3)
m <- make_mevo(ref, list(model = "HKY85", alpha = ,
                         beta = ,
                         pi_tcag = rep(0.25, 4)))
tr <- ape::rcoal(4)
tr$edge.length <- tr$edge.length * 0.1

vars <- create_variants(ref, "phylo", method_info = tr, mevo_obj = m)

write_fasta(vars, "fa_out/vars", compress = TRUE, overwrite = TRUE, n_threads = 1)


