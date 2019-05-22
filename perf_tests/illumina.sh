#!/usr/bin/env bash

# For 100,000 total reads:
# /usr/bin/time -l ~/GitHub/Wisconsin/jlp_ms/perf_tests/art.sh 1

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

nr=$(($1 * 100000))
# Because ART does it as # read pairs per sequence,
# and jackalope does it as # total reads for all sequences (we have 20 sequences)
nr=$(($nr / 40))

art_illumina --quiet --rcount $nr --len 150 --mflen 400 --sdev 100 \
  -ss HS25 --paired --quiet --noALN -i in_files/ref.fa -o illumina_out/art
