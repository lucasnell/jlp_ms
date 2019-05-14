
# time Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/illumina.R

nt <- 1
comp <- FALSE


cat(sprintf("-- illumina --\n%i threads, compressed: %s ...\n", nt, comp))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

# set.seed(79807890)
# ref <- create_genome(20, 100e3)
# write_fasta(ref, "ref", overwrite = TRUE)

fa_file <- "ref.fa"
ref <- read_fasta(fa_file)

#' 
#' The `rcount` argument in the call to ART (see `art.sh`) is per sequence and
#' it's # read pairs.
#' jackalope is # reads in total, so we multiply by 10 and 2
#' 
#' 

set.seed(1)

fq_file <- "illumina_out/ill"
if (comp) fq_file <- paste0(fq_file, "_gz")

illumina(ref, fq_file, n_reads = 10 * 2 * 100000, read_length = 150,
         paired = TRUE, frag_mean = 400, frag_sd = 100, seq_sys = "HS25",
         n_threads = nt, overwrite = TRUE, compress = comp)


# 1 threads, bgzip: 13.3 sec
# 1 threads, gzip: 13.8 sec
# 4 threads, bgzip: 12.7 sec
# 4 threads, gzip: 13.9 sec
# 4 threads, bgzip done afterward on non-compressed files: 4.8 sec





# fq <- readLines("illumina_out_R1.fq")
# fq2 <- readLines("illumina_out_gz_R1.fq")
# identical(fq, fq2)
# gz <- gzfile("illumina_out_gz_R1.fq.gz", "rb")
# gzfq <- readLines(gz)

# 
# identical(gzfq, fq)



#' 
#' MOST RECENT -----
#' 
#' 
#' 1 threads, compressed: FALSE ...
#' 
#' real	0m19.042s
#' user	0m16.604s
#' sys	0m1.349s
#' 
#' 1 threads, compressed: FALSE ...
#' 
#' real	0m17.313s
#' user	0m15.480s
#' sys	0m1.240s
#'
#' 4 threads, compressed: FALSE ...
#' 
#' real	0m9.189s
#' user	0m26.961s
#' sys	0m1.696s
#'
#' 1 threads, compressed: TRUE ...
#' 
#' real	2m4.482s
#' user	2m3.026s
#' sys	0m0.717s
#'
#' 4 threads, compressed: TRUE ...
#' 
#' real	0m48.201s
#' user	2m42.421s
#' sys	0m3.522s





#' 
#' BEFORE ANY CHANGES -----
#' 
#' 
#' 1 threads, compressed: FALSE ...
#' 
#' real	0m16.528s
#' user	0m15.101s
#' sys	0m1.088s
#' 
#' 4 threads, compressed: FALSE ...
#' 
#' real	0m8.374s
#' user	0m27.016s
#' sys	0m1.531s
#' 
#' 1 threads, compressed: TRUE ...
#' 
#' real	2m17.603s
#' user	2m15.412s
#' sys	0m0.778s
#' 
#' 4 threads, compressed: TRUE ...
#' 
#' real	2m18.547s
#' user	8m28.815s
#' sys	0m16.053s


# Just doing compression afterward:
# 
# $ time bgzip illumina_out_R2.fq
# 
# real	0m54.166s
# user	0m53.575s
# sys	0m0.381s
# 
# $ time bgzip -@ 4 illumina_out_R1.fq
# 
# real	0m19.055s
# user	1m8.225s
# sys	0m0.712s

# Compression using jackalope:::bgzip_cpp
# 
# 1 thread
# 
# real	0m55.341s
# user	0m54.099s
# sys	0m0.622s
# 
# 4 threads
# 
# real	0m19.010s
# user	1m8.869s
# sys	0m0.693s

