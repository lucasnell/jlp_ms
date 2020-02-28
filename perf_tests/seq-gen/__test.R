

#' This is the main file to use for performance testing `jackalope` in comparison
#' to `seq-gen`.
#'
#' To run, time, get max memory and output that info to `results/2Mb__0.0010__times.txt`
#' for 2 Mb genome with trees scaled to have max depth of 0.001:
#'
#' Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen/__test.R 2 0.001
#'
#'
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

# std_out <- "~/Desktop/test.out"
# gsize <- 2 * 1e6L
# mdepth <- 0.001

dir <- tempdir(TRUE)
dir <- paste0(dir, "/")
# dir <- "~/Desktop/out/"
# if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)


cat(sprintf("output file directory: %s\n", dir))


if (!dir.exists(dirname(std_out))) dir.create(dirname(std_out), recursive = TRUE)


# Just to clear the file
output <- file(std_out, "wt")
close(output)



# Make trees and indelible configure.txt file:
source("seq-gen_configure.R")




# One rep of jackalope
jlp <- function(nt) {
    sys_str <- paste("/usr/bin/time -l Rscript jackalope.R", gsize, mdepth, dir, nt,
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

# One rep of seq-gen:
ind <- function() {
    sys_str <- paste("./seq-gen.sh", dir, gsize %/% 1e6L, std_out)
    system(sys_str)
    invisible(NULL)
}





#'
#' Turning arguments into seeds for RNG. It should only affect `rep_order` below,
#' so it's not a big deal that it's not extremely random.
#'
#' Note: I plan to simulate a 20 Mb genome at max and 0.001 max branch length
#' as minimum, which is why these values were chosen.
#' `2^31 - 1` is the max integer value in R.
#'
set.seed((gsize / mdepth) / (20e6 / 0.001) * 2^30 + 1)


# Do 5 reps of each, 0 = seq-gen, 1 = jackalope 1 thread, 2 = jackalope 4 threads
rep_order <- sample(rep(0:2, 5))


for (i in 1:length(rep_order)) {

    if (rep_order[i] == 0) {
        ind()
    } else if (rep_order[i] == 1) {
        jlp(1)
    } else {
        jlp(4)
    }
    cat(sprintf("%.2f\n", i / length(rep_order)))

}


cat(sprintf(paste("\n~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~\nFinished for\n",
                  "- size = %iMb\n - max depth =",
                  "%.04f\n~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~\n\n"),
            gsize %/% 1e6L, mdepth))




