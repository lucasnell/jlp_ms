#!/usr/bin/env bash

#
# This script is used inside `__test.R` to run the `ngsphy` version of an
# evolution and read simulation.
# It's not meant to be run directly.
#
# Inputs are...
# Inputs are (1) temporary directory containing configuration and tree files,
# (2) number of threads to use, and
# (3) output file for results from /usr/bin/time
#



export INDELIBLE=~/Downloads/INDELibleV1.03/src/
export PATH="$INDELIBLE:$PATH"


export PATH=~"/opt/anaconda3/bin:$PATH"
export NGSPHY=~/Downloads/ngsphy/scripts/ngsphy


# Needed to start ngsphy:
eval "$(conda shell.bash hook)"
conda activate py2


cd $1

export nt=$2
export out_fn=$3



echo -e "\n---------------\n>>> NGSPHY -" $nt "\n---------------\n" >> $out_fn


# Run NGSphy, suppressing its output, and writing output from /usr/bin/time to $out_fn:
/usr/bin/time -l $NGSPHY --log ERROR -s settings_${nt}.txt 1> /dev/null 2>> $out_fn

# Remove the output directory
rm -r NGSphy_output


echo -e "\n\n" >> $out_fn



