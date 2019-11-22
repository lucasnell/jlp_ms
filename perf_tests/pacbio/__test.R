
#' This is the main file to use for performance testing `jackalope` in comparison
#' to `simlord`.
#'
#' To run, time, get max memory and output that info to `results/1k__times.txt`
#' 1 thousand reads:
#'
#' Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio/__test.R 1
#'


setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio")


args  <- commandArgs(trailingOnly = TRUE)

stopifnot(length(args) >= 1)
n_reads <- as.integer(as.numeric(args[1]) * 1e3)
if (length(args) < 2) {
    std_out <- sprintf("%s/results/%gk__times.txt", getwd(), n_reads / 1e3)
} else std_out <- path.expand(as.character(args[2]))



dir <- tempdir(TRUE)
dir <- paste0(dir, "/")


if (!dir.exists(dirname(std_out))) dir.create(dirname(std_out), recursive = TRUE)


invisible(file.copy("../in_files/ref.fa", dir, overwrite = TRUE))


cat(sprintf("output file directory: %s\n", dir))

# Just to clear the file
output <- file(std_out, "wt")
close(output)





# One rep of jackalope
jlp <- function(nt) {
    sys_str <- paste("/usr/bin/time -l Rscript jackalope.R", n_reads, dir, nt,
                     "1>/dev/null 2>>", std_out)

    output <- file(std_out, "at")
    writeLines(sprintf("\n---------------\n>>> JACKALOPE - %i\n---------------\n", nt),
               output)
    close(output)

    system(sys_str)

    output <- file(std_out, "at")
    writeLines("\n\n", output)
    close(output)
    invisible(NULL)
}

# One rep of simlord:
slr <- function() {
    sys_str <- paste("./simlord.sh", dir, n_reads, std_out)
    system(sys_str)
    invisible(NULL)
}


#'
#' Turning arguments into seeds for RNG. It should only affect `rep_order` below,
#' so it's not a big deal that it's not extremely random.
#'
#' Note: I plan to simulate a max of 100 k reads, which is why this value was chosen.
#' `2^31 - 1` is the max integer value in R.
#'
set.seed(n_reads / 100e3  * (2^31 - 1))



# Do 10 reps of each, 0 = simlord, 1 = jackalope 1 thread, 2 = jackalope 4 threads
rep_order <- sample(rep(0:2, 5))

for (i in 1:length(rep_order)) {

    if (rep_order[i] == 0) {
        slr()
    } else if (rep_order[i] == 1) {
        jlp(1)
    } else {
        jlp(4)
    }
    cat(sprintf("%.2f\n", i / length(rep_order)))

}


cat(sprintf(paste("\n~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~\nFinished for\n",
                  "- n_reads = %g k",
                  "\n~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~\n\n"),
            n_reads / 1e3))

