
#'
#' This script is used inside `test.R` to make the trees and configure files
#' for ngsphy.
#' It's not meant to be run directly.
#'
#' The objects gsize, mdepth, n_reads, and dir should exist in global environment before
#' running this script.
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

    fn <- sprintf("../in_files/scrm_%i.tree", gsize %/% 1e6L)

    full_file <- readLines(fn)

    # numbers of bp per tree
    nbp <- full_file[grepl("^\\[", full_file)]
    nbp <- sapply(strsplit(nbp, "\\("), `[`, i = 1)

    # Create vector to group gene trees into chromosomes
    chroms <- numeric(sum(full_file == "//"))
    j = 0
    for (i in 1:length(full_file)) {
        if (full_file[i] == "//") {
            j = j + 1
            next
        }
        if (grepl("^\\[", full_file[i])) chroms[j] <- chroms[j] + 1
    }
    # Starting and ending points for groups:
    chroms <- cbind(c(1, 1 + head(cumsum(chroms), -1)), cumsum(chroms))

    # Trees themselves:
    trees <- read.tree(fn)

    # Scale to have max depth of mdepth
    trees <- lapply(trees, function(x) {
        x$edge.length <- mdepth * x$edge.length / max(node.depth.edgelength(x))
        return(x)
    })
    names(trees) <- NULL


    # For jackalope version:
    tree_strings <- apply(chroms, 1,
                          function(.xy) {
                              inds <- (.xy[1]):(.xy[2])
                              string <- paste0(nbp[inds], sapply(trees[inds], write_tree),
                                               collapse = "\n")
                              paste0("//\n", string, "\n\n")
                          })
    writeLines(paste0(tree_strings, collapse = "\n\n"),
               paste0(dir, "tree.tree"))



    # ------------*
    # Functions to write NGSphy info
    # ------------*
    # Make INDELible config files
    write_indelible_config <- function(indelible_config, i) {
        folder <- sprintf("%sngsphy_%i/", dir, i)
        indelible_config[grepl("%LENGTH%", indelible_config)] <-
            gsub("%LENGTH%", gsub("\\[|\\]", "", nbp[i]),
                 indelible_config[grepl("%LENGTH%", indelible_config)])
        indelible_config[grepl("%SEED%", indelible_config)] <-
            gsub("%SEED%", sample.int(2^31-1, 1),
                 indelible_config[grepl("%SEED%", indelible_config)])
        writeLines(indelible_config, paste0(folder, "indelible_config.txt"))
        invisible(NULL)
    }
    # Make tree file
    write_tree_file <- function(i) {
        folder <- sprintf("%sngsphy_%i/", dir, i)
        tree <- trees[[i]]
        # NGSphy requires specific naming apparently
        tree$tip.label <- sprintf("1_1_%s", tree$tip.label)
        write_tree(tree, file = paste0(folder, "tree.tree"))
        invisible(NULL)
    }

    # Make ngsphy config files
    write_ngsphy_config <- function(ngsphy_config, i) {
        n_haps <- length(trees[[i]]$tip.label)
        # See "COMPUTING SHAPES" below for more on these
        shapes = rbind(c(100e3, 314.8933),
                        c(1e6, 31.34824),
                        c(10e6, 3.109776))
        len <- as.integer(gsub("\\[|\\]", "", nbp[i]))
        folder <- sprintf("%sngsphy_%i/", dir, i)
        # average # reads per output file, where there are separate files by
        # gene tree, individual, and which of read pair
        n_reads_i <- n_reads / (n_haps * 2) * (len / gsize)
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
                gsub("%THREADS%", (nt), ngsphy_config[grepl("%THREADS%", ngsphy_config)])
            writeLines(tmp, paste0(folder, "settings_", nt, ".txt"))
        }
        invisible(NULL)
    }


    # ------------*
    # Write files for each gene tree's simulation,
    # each set of files in a separate folder
    # ------------*
    n_trees <- length(trees)

    indelible_config <- readLines("indelible_header.txt")
    indelible_config <- indelible_config[!grepl("^//", indelible_config)] # remove comments

    ngsphy_config <- readLines("ngsphy_header.txt")
    ngsphy_config <- ngsphy_config[!grepl("^//", ngsphy_config)] # remove comments
    ngsphy_config <- ngsphy_config[ngsphy_config != ""] # remove empty lines

    for (i in 1:n_trees) {
        folder <- sprintf("%sngsphy_%i/", dir, i)
        dir.create(folder, recursive = TRUE, showWarnings = FALSE)
        write_indelible_config(indelible_config, i)
        write_tree_file(i)
        write_ngsphy_config(ngsphy_config, i)
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
#     return(c(n_lines / 4, total_read))
# })
# read_mat <- do.call(rbind, read_mat)
#
#
# sum(read_mat[,1])
# sum(read_mat[,2]) / (8 * 20 * 500)
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
