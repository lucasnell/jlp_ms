#!/usr/bin/env bash

# For 10,000 reads:
# /usr/bin/time -l ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio.sh 10

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

## Run these beforehand:
## conda activate base
## source activate simlord

nr=$(($1 * 1000))

simlord --read-reference in_files/ref.fa -n $nr --no-sam pacbio_out/simlord


# real	1m28.883s
# user	1m26.833s
# sys	0m0.942s
