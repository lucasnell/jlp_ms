#!/usr/bin/env bash

# used to generate tree:
# scrm 8 20 -T -seed 1829812441 253160851 137767610 > scrm.tree
# cat scrm.tree | tail +4 | grep -v // > seq-gen.tree
# 
# -m GTR # GTR substitution model
# -fe # pi_tcag = rep(0.25, 4)
# -l 10000 # length of sequence
# -r 0.1,0.1,0.1,0.1,0.1,0.1 # values for GTR matrix
# -q # Quiet
# -a 1 # shape of Gamma for site variability

# seq-gen -m GTR -fe -q -l 100000 -r 0.1,0.1,0.1,0.1,0.1,0.1 -a 1 < seq-gen.tree > seq-gen_out
seq-gen -m HKY -l 10000000 -a 1 -s 0.1 < seq-gen.tree > seq-gen_out/seqfile



# to run and time:
# time ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen.sh


# 20 x 10e6 ref: >2 GB memory, ~ 3.5 min