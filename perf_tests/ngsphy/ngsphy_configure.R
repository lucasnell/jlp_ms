
#'
#' This script is used inside `test.R` to make the trees and configure files
#' for ngsphy.
#' It's not meant to be run directly.
#'
#' The objects gsize, mdepth, n_reads, and dir should exist in global environment before
#' running this script.
#'



#'
#' How I originally made the species tree:
#'
#' ```r
#' set.seed(960054393)
#' x <- ape::rcoal(8)
#' ape::write.tree(x, "~/GitHub/Wisconsin/jlp_ms/perf_tests/ngsphy/spp_tree.tree")
#' ```
#'




stopifnot("gsize" %in% ls())
stopifnot("mdepth" %in% ls())
stopifnot("n_reads" %in% ls())
stopifnot("dir" %in% ls())



# Start new environment to do all this stuff without cluttering global:
env <- new.env()

# Set parameters
env$gsize <- gsize
env$mdepth <- mdepth
env$n_reads <- n_reads
env$dir <- dir



#' Below is from the ngsphy manual:
#'
#' 7.2.7. Single gene-tree file format and labeling
#'
#' Single gene trees in Newick format should have specific tip labels.
#' Tips must follow a specific format in order to be managed by NGSphy.
#' This format indicates species, locus and individual with the scheme (X_Y_Z) where:
#'
#'     X stands for the the species identifier, where X > 0
#'     Y for the locus identifier, where Y > 0
#'     Z for the individual identifier, where Z > 0
#'
#' The gene tree file must be in Newick format, rooted and with branch lengths.
#' If the gene tree is not rooted, it will be forced following Dendropy specifications.
#'



# Do the configuring:
with(env, {

    library(ape)
    source("../indelible/write_tree.R")

    n_haps <- 8L
    n_chroms <- 20L
    chrom_size <- gsize %/% n_chroms

    # ----------------*
    # Making trees
    # ----------------*
    tree <- read.tree("spp_tree.tree")

    # Scale to have max depth of mdepth
    tree$edge.length <- mdepth * tree$edge.length / max(node.depth.edgelength(tree))

    # For jackalope, simply write the scaled tree to the output directory
    write.tree(tree, paste0(dir, "spp_tree.tree"))

    # Hacking together one giant tree with 20 copies of the species tree to get NGSphy
    # to make all 20 chromosomes
    tree$tip.label <- paste(1:length(tree$tip.label), 1, "1", sep = "_")
    tree$root.edge <- 0
    s <- stree(2)
    s$edge.length <- rep(0, nrow(s$edge))
    z <- bind.tree(s, tree)
    for (i in 2:20) {
        tree$tip.label <- paste(1:length(tree$tip.label), i, "0", sep = "_")
        z <- bind.tree(z, tree, length(z$tip.label)+1)
    }
    z_drop <- ape::drop.tip(z, 1:2)
    write_tree(z_drop, paste0(dir, "ngsphy_tree.tree"))


    # ----------------*
    # Make INDELible config file
    # ----------------*
    indelible_config <- readLines("indelible_header.txt")
    indelible_config <- indelible_config[!grepl("^//", indelible_config)] # remove comments
    indelible_config[grepl("%LENGTH%", indelible_config)] <-
        gsub("%LENGTH%", chrom_size, indelible_config[grepl("%LENGTH%", indelible_config)])
    indelible_config[grepl("%SEED%", indelible_config)] <-
        gsub("%SEED%", sample.int(2^31-1, 1),
             indelible_config[grepl("%SEED%", indelible_config)])
    writeLines(indelible_config, paste0(dir, "indelible_config.txt"))


    # ----------------*
    # Make ngsphy config files
    # ----------------*
    # See "COMPUTING SHAPES" below for more on these
    shapes = rbind(c(100e3, 314.8933),
                   c(1e6, 31.34824),
                   c(10e6, 3.109776))
    ngsphy_config <- readLines("ngsphy_header.txt")
    ngsphy_config <- ngsphy_config[!grepl("^//", ngsphy_config)] # remove comments
    ngsphy_config <- ngsphy_config[ngsphy_config != ""] # remove empty lines
    # average # reads per output file, where there are separate files by
    # gene tree, individual, and which of read pair
    n_reads_i <- n_reads / (n_chroms * n_haps * 2)
    repl_strs <- list(OUT_PATH = dir,
                      READS_PER_FILE = sprintf("%.1f", n_reads_i),
                      INDIV_SHAPE = sprintf("%.3f", shapes[shapes[,1] == n_reads, 2]))
    for (n in names(repl_strs)) {
        str <- paste0("%", n, "%")
        ngsphy_config[grepl(str, ngsphy_config)] <-
            gsub(str, repl_strs[[n]], ngsphy_config[grepl(str, ngsphy_config)])
    }
    # Now add one settings file for 1 thread, another for 4 threads
    for (nt in c(1, 4)) {
        tmp <- ngsphy_config
        tmp[grepl("%THREADS%", ngsphy_config)] <-
            gsub("%THREADS%", nt, ngsphy_config[grepl("%THREADS%", ngsphy_config)])
        writeLines(tmp, paste0(dir, "settings_", nt, ".txt"))
    }

})


# Now remove the environment and everything inside:
rm(env)




# # FOR LOOKING AT NGSPHY OUTPUT:
# setwd("/Users/lucasnell/Desktop/out/NGSphy_output/reads/REPLICATE_1/LOCUS_1")
# fqs <- list.files()
# read_mat <- lapply(fqs, function(f) {
#     fq_str <- readLines(f)
#     n_lines <- length(fq_str)
#     if (n_lines < 4) return(c(0, 0))
#     total_read <- sum(nchar(fq_str[seq(2, n_lines, 4)]))
#     # Returning # reads, and total read output
#     return(c(n_lines / 4, total_read))
# })
# read_mat <- do.call(rbind, read_mat)
#
# # Compare to request # reads:
# sum(read_mat[,1])
# sum(read_mat[,2])
#
# mean(read_mat[,1])




#' ====================================================================================
#'
#' COMPUTING SHAPES
#'
#' ====================================================================================
#'
#'
#' The shapes below are used to use ngsphy's method of generating variance among
#' individuals to generate the same variance as a binomial distribution.
#' The code chunk below was used to generate these shapes.
#'
#' ```{r}
#' find_shape <- function(.n_reads, .interval = c(1, 1000)) {
#'     n <- (.n_reads / 2)
#'     p <- 1 / (n_chroms * n_haps)
#'     .binom_var <- n * p * (1 - p) # variance for binomial process
#'     .rpf <- n_reads / (n_chroms * n_haps * 2) # reads per file
#'
#'     cat(sprintf("----------\nDesired variance = %.2f\n----------\n\n", .binom_var))
#'
#'     foo <- function(x, binom_var, rpf) {
#'         vv <- var(rpf * rgamma(1e5, shape = x, scale = 1 / x))
#'         return(abs(vv - binom_var))
#'     }
#'     return(optimize(foo, .interval, binom_var = .binom_var, rpf = .rpf))
#' }
#'
#' find_shape(100e3)
#' find_shape(1e6)
#' find_shape(10e6)
#' ```
#'
