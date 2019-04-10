#!/usr/bin/env bash

# time ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio.sh

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

## Run these beforehand:
## conda activate base
## source activate simlord

simlord --read-reference ref.fa -n 10000 --no-sam pacbio_out/simlord


# real	1m28.883s
# user	1m26.833s
# sys	0m0.942s