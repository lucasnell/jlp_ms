#!/usr/bin/env bash

#
# This script is used inside `__test.R` to run the `indelible` version of an
# evolution simulation.
# It's not meant to be run directly.
#
# Inputs are (1) temporary directory containing config.txt and tree files and
# (2) output file for results from /usr/bin/time
#



cd $1

export indelible=~/Downloads/INDELibleV1.03/src/indelible
export out_fn=$2

echo -e "\n---------------\n>>> INDELIBLE\n---------------\n" >> $out_fn

# Run indelible, suppressing its output, and writing output from /usr/bin/time to $out_fn:
/usr/bin/time -l $indelible 1>/dev/null 2>> $out_fn

echo -e "\n\n" >> $out_fn
