#!/usr/bin/env bash

#
# This script is used inside `__test.R` to run the `seq-gen` version of variant
# haplotype creation.
# It's not meant to be run directly.
#
# Inputs are (1) temporary directory containing output files and tree files,
# (2) genome size (in Mb), and
# (3) output file for results from /usr/bin/time
#


# to run, time, get max memory for 20 Mb genome:
# /usr/bin/time -l ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen.sh 20


# used to generate tree:
# cd ~/Wisconsin/jlp_ms/in_files
# scrm 8 20 -T -seed 1829812441 253160851 137767610 > scrm.tree
# cat scrm.tree | tail +4 | grep -v // > seq-gen.tree
#
#
# -m HKY # HKY substitution model
# -l 10000 # length of sequence
# -q # Quiet
# -a 1 # shape of Gamma for site variability
# -g 5 # number of categories for Gamma distribution
# -f0.2,0.3,0.1,0.4  #  frequencies for A C G T
# -i 0.25 # proportion of invariable sites
# -t 2.5 # transition transversion ratio


# How I calculated the max # partitions
#``` r
# z <- matrix(0, 20, 3)
# for (k in 1:3) {
#     s = c(2, 20, 200)[k]
#     x <- readLines(sprintf("perf_tests/in_files/scrm_%i.tree", s))
#     x <- x[x != ""]
#     j = 0
#     for (i in 2:length(x)) {
#         if (x[i] == "//") {
#             j = j + 1
#             next
#         }
#         if (grepl("^\\[", x[i])) z[j,k] <- z[j,k] + 1
#     }
# }
# z
# max(z)
# # [1] 10
#```



cd $1

# Genome length in Mb
export len=$2
# Chromosome length (in bp), since it's assumed to have 20 chromosomes
export clen=$(($len * 1000000 / 20))

export out_fn=$3

echo -e "\n---------------\n>>> SEQ-GEN\n---------------\n" >> $out_fn

# Run seq-gen, suppressing its output, and writing output from /usr/bin/time to $out_fn:
/usr/bin/time -l seq-gen -m HKY -l $clen -p 10 -q -f0.2,0.3,0.1,0.4 -t 1 -i 0.25 \
    -a 0.5 -g 10 < seq-gen.tree 1> seq-gen.out 2>> $out_fn


echo -e "\n\n" >> $out_fn

