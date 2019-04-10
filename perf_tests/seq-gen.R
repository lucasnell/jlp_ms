
# time Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen.R

nt <- 4
comp <- FALSE


cat(sprintf("--- %i threads, compressed: %s ...\n", nt, comp))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)


t0 <- Sys.time()
ref <- create_genome(20, 10e6)
t1 <- Sys.time()
m <- make_mevo(ref, list(model = "GTR",
                         abcdef = rep(0.1 * 4/3, 6),
                         pi_tcag = rep(0.25, 4)),
               site_var = list(shape = 1, region_size = 1000))
t2 <- Sys.time()
vars <- create_variants(ref, "coal_trees",
                        method_info = "scrm.tree",
                        mevo_obj = m,
                        n_threads = nt)
t3 <- Sys.time()
write_fasta(vars, "seq-gen_out/vars", compress = comp,
            overwrite = TRUE, n_threads = nt)
t4 <- Sys.time()

cat(sprintf("ref: %.3g secs\n", as.numeric(difftime(t1, t0, units = "secs"))))
cat(sprintf("vars: %.3g secs\n", as.numeric(difftime(t3, t2, units = "secs"))))
cat(sprintf("fasta: %.3g secs\n", as.numeric(difftime(t4, t3, units = "secs"))))

# 1 thread, 20 x 10e6 genome: 
# 4 threads, 20 x 10e6 genome: