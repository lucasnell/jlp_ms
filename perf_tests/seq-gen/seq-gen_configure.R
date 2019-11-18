
#'
#' This script is used inside `__test.R` to make the trees for seq-gen.
#' It's not meant to be run directly.
#'
#' The objects gsize, mdepth, and dir should exist in global environment before
#' running this script.
#'


stopifnot("gsize" %in% ls())
stopifnot("mdepth" %in% ls())
stopifnot("dir" %in% ls())


# Start new environment to do all this stuff without cluttering global:
env <- new.env()

# Set parameters
env$gsize <- gsize
env$mdepth <- mdepth
env$dir <- dir


# Do the configuring:
with(env, {

    library(ape)

    source("../indelible/write_tree.R")

    trees <- read.tree("../in_files/scrm.tree")

    # Scale to have max depth of mdepth
    trees <- lapply(trees, function(x) {
        x$edge.length <- mdepth * x$edge.length / max(node.depth.edgelength(x))
        return(x)
    })
    names(trees) <- NULL

    # For jackalope version:
    writeLines(paste0("//\n", sapply(trees, write_tree), collapse = "\n\n"),
               paste0(dir, "tree.tree"))


    n_chroms <- length(trees)  # one tree per chromosome
    partition_size <- as.integer(gsize / n_chroms)

    tree_strs <- sapply(1:n_chroms, function(i) {
        sprintf("[TREE] t%02i %s\n", i, write_tree(trees[[i]]), mdepth)
    })

    part_strs <- sapply(1:n_chroms, function(i) {
        sprintf("[PARTITIONS] chrom%02i [t%02i hky_model %i]\n", i, i, partition_size)
    })

    evolve_strs <- c("[EVOLVE]    chrom01     1   out01\n",
                     sapply(2:n_chroms,
                            function(i) sprintf("            chrom%02i     1   out%02i\n",
                                                i, i)))

    # cat(paste(tree_strs, collapse = ""))
    # cat(paste(part_strs, collapse = ""))
    # cat(paste(evolve_strs, collapse = ""))


    hdr <- readLines("indelible_header.txt")
    hdr <- sapply(hdr, function(x) paste0(x, "\n"))



    lines <- c(hdr, "\n\n", tree_strs, "\n\n", part_strs, "\n\n", evolve_strs)


    out_fn <- paste0(dir, "control.txt")

    writeLines(paste(lines, collapse = ""), out_fn)
})


# Now remove the environment and everything inside:
rm(env)
