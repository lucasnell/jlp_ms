
#'
#' This file creates the file `illumina_scripts.sh` that has each iteration of
#' both programs (with 1, 10, and 10 million reads, plus 1 and 4 threads for jackalope)
#' run 10 times and in randomized order.
#' Each run outputs a file that summarizes the time and memory used.
#'

if (grepl("jlp_ms$", getwd())) setwd("perf_tests")

commands = list(art = "./illumina.sh",
                jackalope = "Rscript ./illumina.R")

n_reps <- 10

cmd_info <- rbind(expand.grid(prog = "art", nreads = c(1, 10, 100), threads = 1,
                             rep = 1:n_reps),
                 expand.grid(prog = "jackalope", nreads = c(1, 10, 100), threads = c(1,4),
                             rep = 1:n_reps))
set.seed(1462570366)
cmd_info <- cmd_info[sample(1:nrow(cmd_info)),]
rownames(cmd_info) <- NULL

scripts <- sapply(1:nrow(cmd_info), function(i) {
    .cmd <- paste(commands[[cmd_info$prog[i]]], cmd_info$nreads[i], cmd_info$threads[i])
    .fn <- sprintf("illumina_out/runs/%s_%iMreads_%ithreads_rep%i.out", cmd_info$prog[i],
                   cmd_info$nreads[i], cmd_info$threads[i], cmd_info$rep[i])
    sprintf("(/usr/bin/time -l %s) &> \\\n    %s\n", .cmd, .fn)
})

writeLines(c("#!/usr/bin/env bash\n", "cd ~/GitHub/Wisconsin/jlp_ms/perf_tests\n",
             "i=1\n",
             paste(scripts, collapse = "echo $i\n\ni=(($i + 1))\n")),
           "illumina_scripts.sh")
