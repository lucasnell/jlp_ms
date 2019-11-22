#!/usr/bin/env bash

#
# This script is used inside `__test.R` to run the `ART` version of Illumina simulation.
# It's not meant to be run directly.
#
# Inputs are (1) temporary directory containing output filesa nd `ref.fa`,
# (2) number of total reads for all sequences, and
# (3) output file for results from /usr/bin/time
#


cd $1


nr=$2
# Because ART does it as # read pairs per sequence,
# and jackalope does it as # total reads for all sequences (we have 20 sequences)
nr=$(($nr / 40))


out_fn=$3

echo -e "\n---------------\n>>> ART\n---------------\n" >> $out_fn


# Run ART, suppressing its output, and writing output from /usr/bin/time to $out_fn:
/usr/bin/time -l \
  art_illumina --quiet --rcount $nr --len 150 --mflen 400 --sdev 100 \
  -ss HS25 --paired --quiet --noALN -i ref.fa -o art 1> /dev/null 2>> $out_fn

echo -e "\n\n" >> $out_fn
