
# For 100,000 reads on 4 threads:
# /usr/bin/time -l Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/illumina.R 100 4

args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) > 0)
n_rds <- as.integer(args[1]) * 1e6L
if (length(args) == 1) {
    nt <- 1
} else nt <- as.integer(args[2])



setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

fa_file <- "in_files/ref.fa"
# set.seed(79807890)
# ref <- create_genome(20, 100e3)
# write_fasta(ref, gsub(".fa", "", fa_file), overwrite = TRUE)

ref <- read_fasta(fa_file)

fq_file <- "illumina_out/jlp"

illumina(ref, fq_file, n_reads = n_rds, read_length = 150,
         paired = TRUE, seq_sys = "HS25",
         n_threads = nt, overwrite = TRUE)
