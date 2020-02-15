

#' This is the main file to use for performance testing `jackalope` in comparison
#' to `ngsphy`.
#'
#' To run, time, get max memory and output that info to
#' `results/2Mb__0.0010__0.1M__times.txt` for
#' (1) 2 Mb genome,
#' (2) trees scaled to have max depth of 0.001, and
#' (3) 100 thousand reads:
#'
#' Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/ngsphy/__test.R 2 0.001 0.1
#'
#'
#'


setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests/ngsphy")




args  <- commandArgs(trailingOnly = TRUE)




stopifnot(length(args) >= 3)
gsize <- as.integer(args[1]) * 1e6L
mdepth <- as.numeric(args[2])
n_reads <- as.integer(as.numeric(args[3]) * 1e6)
if (length(args) < 4) {
    std_out <- sprintf("%s/results/%iMb__%.04f__%gM__times.txt",
                       getwd(), gsize %/% 1e6L, mdepth, n_reads / 1e6)
} else std_out <- path.expand(as.character(args[4]))

if (length(args) == 5) {
    dir <- args[5]
    dir <- gsub("/$", "", dir)
} else dir <- tempdir(TRUE)
dir <- paste0(dir, "/")



# std_out <- path.expand("~/Desktop/test.out")
# gsize <- 2e6L
# mdepth <- 0.001
# n_reads <- 100e3
# dir <- path.expand("~/Desktop/out/")


if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)

#'
#' Turning arguments into seeds for RNG. It should affect `rep_order` below,
#' plus the phylogenies that are produced.
#'
#' Note: I plan to simulate a 20 Mb genome at max and 0.001 max branch length
#' as minimum, which is why these values were chosen.
#' `2^31 - 1` is the max integer value in R.
#'
set.seed((gsize / mdepth) / (20e6 / 0.001) * 2^30 + 3)


cat(sprintf("output file directory: %s\n", dir))



if (!dir.exists(dirname(std_out))) dir.create(dirname(std_out), recursive = TRUE)

# Just to clear the file
output <- file(std_out, "wt")
close(output)


# Make trees and indelible configure.txt file:
source("ngsphy_configure.R")




# One rep of jackalope
jlp <- function(nt) {
    sys_str <- paste("/usr/bin/time -l Rscript jackalope.R", gsize, mdepth, n_reads,
                     dir, nt, "1>/dev/null 2>>", std_out)

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

# One rep of ngsphy:
ngp <- function(nt) {
    sys_str <- paste("./ngsphy.sh", dir, nt, std_out)
    system(sys_str)
    invisible(NULL)
}



#'
#' Do 5 reps of each:
#'
#' 0 = ngsphy 1 thread
#' 1 = ngsphy 4 threads
#' 2 = jackalope 1 thread
#' 3 = jackalope 4 threads
#'
rep_order <- sample(rep(0:3, 5))

for (i in 1:length(rep_order)) {

    if (rep_order[i] == 0) {
        ngp(1)
    } else if (rep_order[i] == 1) {
        ngp(4)
    } else if (rep_order[i] == 2) {
        jlp(1)
    } else {
        jlp(4)
    }
    cat(sprintf("%.2f\n", i / length(rep_order)))

}


cat(sprintf(paste("\n~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~~~~~\nFinished for\n",
                  "- size = %iMb\n - max depth = %.04f\n - n_reads = %g M",
                  "\n~~~~~~~~~~~~~~~~~~~~~~~~\n~~~~~~~~~~~~~~~~~~~~\n\n"),
            gsize %/% 1e6L, mdepth, n_reads / 1e6))



