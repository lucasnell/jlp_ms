#!/usr/bin/env bash

#
# This script is used inside `__test.R` to run the `ngsphy` version of an
# evolution and read simulation.
# It's not meant to be run directly.
#
# Inputs are...
# (1) temporary parent directory containing folders with configuration and tree files,
# (2) number of threads to use, and
# (3) output file for results from /usr/bin/time
#



export INDELIBLE=~/Downloads/INDELibleV1.03/src/
export PATH="$INDELIBLE:$PATH"

# /Users/lucasnell/opt/anaconda3/etc/profile.d/conda.sh
export PATH="/Users/lucasnell/opt/anaconda3/bin:$PATH"
export NGSPHY=~/Downloads/ngsphy/scripts/ngsphy


# Needed to start ngsphy:
eval "$(conda shell.bash hook)"
conda activate py2


cd $1

export nt=$2
export out_fn=$3



echo -e "\n---------------\n>>> NGSPHY -" $nt "\n---------------\n" >> $out_fn


# Solution for timing the loop was found here: https://askubuntu.com/a/431184

# Timing the loop this way adds some overhead due to an extra bash instance, but
# it shouldn't affect our conclusions given that we're talking about operations
# that take minutes.

function loop {
    for d in `ls -d ngsphy*`
    do
        cd $d
        # Run NGSphy for this one folder:
        $NGSPHY --log ERROR -s settings_${nt}.txt
        cd ..
    done
}

export -f loop

# Run NGSphy for all folders, suppressing all output, and writing output from
# /usr/bin/time to $out_fn:
echo loop | /usr/bin/time -l /bin/bash 1> /dev/null 2>> $out_fn



echo -e "\n\n" >> $out_fn



