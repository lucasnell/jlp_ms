#' This is the main file to use for performance testing `jackalope` in comparison
#' to `seq-gen`.
#'
#' To run, time, get max memory and output that info to `results/2Mb__0.0010__times.txt`
#' for 2 Mb genome with trees scaled to have max depth of 0.001:
#'
#' Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen/__test.R 2 0.001
#'


setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen")


args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) >= 2)
gsize <- as.integer(args[1]) * 1e6L
mdepth <- as.numeric(args[2])
if (length(args) < 3) {
    std_out <- sprintf("%s/results/%iMb__%.04f__times.txt",
                       getwd(), gsize %/% 1e6L, mdepth)
} else std_out <- path.expand(as.character(args[3]))

# std_out <- "~/Desktop/test"
# gsize <- 2 * 1e6L
# mdepth <- 0.001

dir <- tempdir(TRUE)
dir <- paste0(dir, "/")
# dir <- "~/Desktop/out/"
# if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)


cat(sprintf("output file directory: %s\n", dir))

# Just to clear the file
output <- file(std_out, "wt")
close(output)


if (!dir.exists(dirname(std_out))) dir.create(dirname(std_out), recursive = TRUE)


# Make trees and indelible configure.txt file:
source("indelible_configure.R")





#'
#' This file creates the file `seq-gen_scripts.sh` that has each iteration of
#' both programs (with 2, 20, and 200 Mb genome size, plus 1 and 4 threads for jackalope)
#' run 10 times and in randomized order.
#' Each run outputs a file that summarizes the time and memory used.
#'

if (grepl("jlp_ms$", getwd())) setwd("perf_tests")

commands = list(seq_gen = "./seq-gen.sh",
                jackalope = "Rscript ./seq-gen.R")

n_reps <- 10

cmd_info <- rbind(expand.grid(prog = "seqgen", gsize = c(2, 20, 200), threads = 1,
                             rep = 1:n_reps),
                 expand.grid(prog = "jackalope", gsize = c(2, 20, 200), threads = c(1,4),
                             rep = 1:n_reps))
set.seed(1982639769)
cmd_info <- cmd_info[sample(1:nrow(cmd_info)),]
rownames(cmd_info) <- NULL

scripts <- sapply(1:nrow(cmd_info), function(i) {
    .cmd <- paste(commands[[cmd_info$prog[i]]], cmd_info$gsize[i], cmd_info$threads[i])
    .fn <- sprintf("seq-gen_out/runs/%s_%iMb_%ithreads_rep%i.out", cmd_info$prog[i],
                   cmd_info$gsize[i], cmd_info$threads[i], cmd_info$rep[i])
    sprintf("(/usr/bin/time -l %s) &> \\\n    %s\n", .cmd, .fn)
})

writeLines(c("#!/usr/bin/env bash\n", "cd ~/GitHub/Wisconsin/jlp_ms/perf_tests\n",
             "i=1\n",
             paste(scripts, collapse = "echo $i\n\ni=$(($i + 1))\n")),
           "seq-gen_scripts.sh")
