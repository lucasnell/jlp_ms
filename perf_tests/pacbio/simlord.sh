#!/usr/bin/env bash


#
# This script is used inside `__test.R` to run the `simlord` version of PacBio simulation.
# It's not meant to be run directly.
#
# Inputs are (1) temporary directory containing output files and `ref.fa`,
# (2) number of total reads for all sequences, and
# (3) output file for results from /usr/bin/time
#

# Needed to start simlord:
eval "$(conda shell.bash hook)"
conda activate base
conda activate simlord


cd $1


nr=$2

out_fn=$3

echo -e "\n---------------\n>>> SIMLORD\n---------------\n" >> $out_fn


# Run simlord, suppressing its output, and writing output from /usr/bin/time to $out_fn:
/usr/bin/time -l \
  simlord --read-reference ref.fa -n $nr --no-sam simlord 1> /dev/null 2>> $out_fn


echo -e "\n\n" >> $out_fn

