
#'
#' This script is used inside `__test.R` to run the `jackalope` version of an
#' evolution simulation in comparison to `INDELible`.
#' It's not meant to be run directly.
#'
#' It takes as inputs the genome size, max tree depth, directory for input and output,
#' and number of threads.
#'


args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) == 4)
gsize <- as.integer(args[1])
mdepth <- as.numeric(args[2])
dir <- as.character(args[3])
nt <- as.integer(args[4])



library(jackalope)


.pi_tcag <- 0.1 * 4:1
.kappa <- 2.5


ref <- create_genome(20, gsize / 20, pi_tcag = .pi_tcag)


sub <- sub_HKY85(.pi_tcag, alpha = .kappa, beta = 1,
                 invariant = 0.25, gamma_shape = 0.5, gamma_k = 10)

# same for both insertions and deletions
indel <- indels(rate = 0.1, max_length = 541, a = 1.7)


haps <- create_haplotypes(ref,
                        haps_gtrees(fn = paste0(dir, "tree.tree")),
                        sub = sub,
                        ins = indel,
                        del = indel,
                        n_threads = nt)

write_fasta(haps, paste0(dir, "haps"),
            overwrite = TRUE, n_threads = nt)

