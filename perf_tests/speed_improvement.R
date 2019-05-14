
# Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/speed_improvement.R

nt <- 1
# comp <- FALSE


# cat(sprintf("--- %i threads, compressed: %s ...\n", nt, comp))
cat(sprintf("--- %i threads ...\n", nt))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)


t0 <- Sys.time()
ref <- create_genome(20, 100e3)
t1 <- Sys.time()
vars <- create_variants(ref,
                        vars_gtrees(fn = "scrm.tree"),
                        sub = sub_JC69(0.1),
                        gamma_mats = site_var(ref, shape = 1, region_size = 100),
                        n_threads = nt, show_progress = TRUE)
t2 <- Sys.time()
# write_fasta(vars, "seq-gen_out/vars", compress = comp,
#             overwrite = TRUE, n_threads = nt)
# t3 <- Sys.time()

# cat(sprintf("ref: %.3g secs\n", as.numeric(difftime(t1, t0, units = "secs"))))
cat(sprintf("vars: %.3g secs\n", as.numeric(difftime(t2, t1, units = "secs"))))
# cat(sprintf("fasta: %.3g secs\n", as.numeric(difftime(t3, t2, units = "secs"))))

# 1 thread, 20 x 10e6 genome: 
# 4 threads, 20 x 10e6 genome:



#' To start out (20 x 100e3 genome):
#' --- 1 threads ...
#' vars: 273 secs
#' 
#' --- 4 threads ...
#' vars: 136 secs
#' 
#' 
#' With a chunk size of 1
#' --- 1 threads ...
#' vars: 46.4 secs
#' 
#' With uniform location sampling:
#' --- 1 threads ...
#' vars: 48 secs
#' 
#' --- 4 threads ...
#' vars: 23.2 secs
#' 



