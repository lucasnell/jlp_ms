#!/usr/bin/env bash

# time ~/GitHub/Wisconsin/jlp_ms/perf_tests/art.sh

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

art_illumina --rcount 100000 --len 150 --mflen 400 --sdev 100 \
  -ss HS25 --paired --quiet --noALN -i ref.fa -o art_out

## &> art_stdout_stderr.txt

