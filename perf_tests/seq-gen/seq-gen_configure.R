

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

    # For seq-gen version:
    writeLines(paste0(gsub("//", "", tree_strings), collapse = "\n"),
               paste0(dir, "seq-gen.tree"))

})


# Now remove the environment and everything inside:
rm(env)
