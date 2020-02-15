

#'
#' This script is used inside `test.R` to make the trees and `configure.txt`
#' for indelible.
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

    source("write_tree.R")

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



    # INDELible version:
    n_trees <- length(trees)
    tree_strs <- sapply(1:n_trees, function(i) {
        sprintf("[TREE] t%02i %s\n", i, write_tree(trees[[i]]), mdepth)
    })

    part_strs <- sapply(1:n_trees, function(i) {
        partition_size <- as.integer(gsub("\\[|\\]", "", nbp[[i]]))
        sprintf("[PARTITIONS] region%02i [t%02i hky_model %i]\n", i, i, partition_size)
    })

    evolve_strs <- c("[EVOLVE]    region01     1   out01\n",
                     sapply(2:n_trees,
                            function(i) sprintf("            region%02i     1   out%02i\n",
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
