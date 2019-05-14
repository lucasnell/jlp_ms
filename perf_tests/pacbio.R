
# time Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio.R

nt <- 4
comp <- TRUE


cat(sprintf("-- pacbio --\n%i threads, compressed: %s ...\n", nt, comp))

setwd("~/GitHub/Wisconsin/jlp_ms/perf_tests")

library(jackalope)

nt <- 1
comp <- FALSE
fa_file <- "ref.fa"

# set.seed(79807890)
# ref <- create_genome(20, 100e3)
# write_fasta(ref, "ref", overwrite = TRUE)

ref <- read_fasta(fa_file)


set.seed(7890)

fq_file <- "pacbio_out/pb"
if (comp) fq_file <- paste0(fq_file, "_gz")

t0 <- Sys.time()
pacbio(ref, fq_file, n_reads = 10e3, overwrite = TRUE, 
       n_threads = nt, compress = comp)
t1 <- Sys.time()

t1 - t0


#' CURRENT TIMES ----
#' 
#' 
#' 1 threads, compressed: FALSE ...
#' 
#' real	0m2.734s
#' user	0m2.088s
#' sys	0m0.429s
#' 
#' 
#' 4 threads, compressed: FALSE ...
#' 
#' real	0m1.484s
#' user	0m3.268s
#' sys	0m0.702s
#' 
#' 
#' 1 threads, compressed: TRUE ...
#' 
#' real	0m19.329s
#' user	0m18.972s
#' sys	0m0.231s
#' 
#' 
#' 4 threads, compressed: TRUE ...
#' 
#' real	0m7.917s
#' user	0m25.204s
#' sys	0m1.373s
#' 

