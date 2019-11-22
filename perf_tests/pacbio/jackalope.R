
#'
#' This script is used inside `__test.R` to run the `jackalope` version of PacBio
#' read simulation.
#' It's not meant to be run directly.
#'
#' It takes as inputs the number of reads, directory for input and output,
#' and number of threads.
#'

args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) >= 3)
n_rds <- as.integer(args[1])
dir <- as.character(args[2])
nt <- as.integer(args[3])

library(jackalope)


fa_file <- paste0(dir, "ref.fa")

#' How this file was generated:
#' ```
#' set.seed(79807890)
#' ref <- create_genome(20, 100e3)
#' write_fasta(ref, "ref", overwrite = TRUE)
#' ```


ref <- read_fasta(fa_file)

fq_file <- paste0(dir, "jlp")

pacbio(ref, fq_file, n_reads = n_rds, overwrite = TRUE,
       n_threads = nt)


