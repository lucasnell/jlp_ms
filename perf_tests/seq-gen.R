
# To run, time, get max memory for 20 Mb genome using 1 thread:
# /usr/bin/time -l Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen.R 20 1

args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) > 0)
gsize <- as.integer(args[1]) * 1e6L
if (length(args) == 1) {
    nt <- 1
} else nt <- as.integer(args[2])


# cat(sprintf("--- %i threads, gsize = %s ...\n", nt,
#             format(as.integer(gsize), big.mark = ",")))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)


# t0 <- Sys.time()
ref <- create_genome(20, gsize / 20)
# t1 <- Sys.time()

# t2 <- Sys.time()
vars <- create_variants(ref,
                        vars_gtrees(fn = "in_files/scrm.tree"),
                        # mean mutation rate of 0.001:
                        sub = sub_HKY85(rep(0.25, 4), 0.004, 0.006),
                        gamma_mats = site_var(ref, shape = 1, region_size = 100),
                        # show_progress = TRUE,
                        n_threads = nt)
# t3 <- Sys.time()

# t4 <- Sys.time()
write_fasta(vars, "seq-gen_out/vars",
            overwrite = TRUE, n_threads = nt)
# t5 <- Sys.time()

# cat(sprintf("ref: %.3g secs\n", as.numeric(difftime(t1, t0, units = "secs"))))
# cat(sprintf("vars: %.3g secs\n", as.numeric(difftime(t3, t2, units = "secs"))))
# cat(sprintf("fasta: %.3g secs\n", as.numeric(difftime(t5, t4, units = "secs"))))
# cat(sprintf("overall: %.3g secs\n", as.numeric(difftime(t5, t0, units = "secs"))))


# 200e6: 3m2.406s
# 20e6: 0m8.359s
# 2e6: 0m1.520s
