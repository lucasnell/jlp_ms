
# To run, time, get max memory for 20 Mb genome using 1 thread:
# /usr/bin/time -l Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen.R 20 1


args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) > 0)
gsize <- as.integer(args[1]) * 1e6L
if (length(args) == 1) {
    nt <- 1
} else nt <- as.integer(args[2])

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

ref <- create_genome(20, gsize / 20, pi_tcag = c(0.4, 0.3, 0.2, 0.1))


vars <- create_variants(ref,
                        vars_gtrees(fn = "in_files/scrm.tree"),
                        ### mean mutation rate of 0.001:
                        # sub = sub_HKY85(rep(0.25, 4), 0.001, 0.0015),
                        ### mean mutation rate of 0.1:
                        sub = sub_HKY85(rep(0.25, 4), 0.1, 0.15, gamma_shape = 1),
                        n_threads = nt)

write_fasta(vars, "seq-gen_out/vars",
            overwrite = TRUE, n_threads = nt)


