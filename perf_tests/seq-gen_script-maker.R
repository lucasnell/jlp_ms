
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
             paste(scripts, collapse = "echo $i\n\ni=(($i + 1))\n")),
           "seq-gen_scripts.sh")
