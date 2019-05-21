
# For 10,000 reads using 4 threads:
# /usr/bin/time -l Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio.R 10 4

args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) > 0)
n_rds <- as.integer(args[1]) * 1e3L
if (length(args) == 1) {
    nt <- 1
} else nt <- as.integer(args[2])


setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

fa_file <- "in_files/ref.fa"

# set.seed(79807890)
# ref <- create_genome(20, 100e3)
# write_fasta(ref, "ref", overwrite = TRUE)

ref <- read_fasta(fa_file)


fq_file <- "pacbio_out/pb"

pacbio(ref, fq_file, n_reads = n_rds, overwrite = TRUE,
       n_threads = nt)



#' CURRENT TIMES ----
#'
#'
#' 1 threads, compressed: FALSE ...
#'
#' real	0m2.734s
#' user	0m2.088s
#' sys	0m0.429s
#'
#'
#' 4 threads, compressed: FALSE ...
#'
#' real	0m1.484s
#' user	0m3.268s
#' sys	0m0.702s
#'
#'
#' 1 threads, compressed: TRUE ...
#'
#' real	0m19.329s
#' user	0m18.972s
#' sys	0m0.231s
#'
#'
#' 4 threads, compressed: TRUE ...
#'
#' real	0m7.917s
#' user	0m25.204s
#' sys	0m1.373s
#'

