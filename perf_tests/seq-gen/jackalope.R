
#'
#' This script is used inside `__test.R` to run the `jackalope` version of an
#' evolution simulation in comparison to `seq-gen`.
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
.tstv_ratio <- 1 # transition transversion ratio (alpha / (2 * beta))

# Just setting this to 1 bc the rate matrix gets scaled anyway:
.alpha <- 1
.beta <- .alpha / (2 * .tstv_ratio)


ref <- create_genome(20, gsize / 20, pi_tcag = .pi_tcag)


sub <- sub_HKY85(.pi_tcag, alpha = .alpha, beta = .beta,
                 invariant = 0.25, gamma_shape = 0.5, gamma_k = 10)


vars <- create_haplotypes(ref,
                          haps_gtrees(fn = paste0(dir, "tree.tree")),
                          sub = sub,
                          n_threads = nt)

write_fasta(vars, paste0(dir, "haps"),
            overwrite = TRUE, n_threads = nt)

