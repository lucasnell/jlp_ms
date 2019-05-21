#!/usr/bin/env bash

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

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

len=$(($1 * 1000000))
len=$(($len / 20))


# genome size `len`:
seq-gen -m HKY -l $len -q -fe -a 1 -s 0.001 < in_files/seq-gen.tree > seq-gen_out/seqfile



# genome size 200e6 (`-l 10000000`): 3m42.280s
# genome size 20e6 (`-l 1000000`): 0m21.221s
# genome size 2e6 (`-l 100000`): 0m2.171s
