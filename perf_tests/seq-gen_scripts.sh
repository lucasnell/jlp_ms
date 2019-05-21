#!/usr/bin/env bash

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

i=1

(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 1) &> \
    seq-gen_out/runs/jackalope_200Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 4) &> \
    seq-gen_out/runs/jackalope_2Mb_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 20 1) &> \
    seq-gen_out/runs/seqgen_20Mb_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 2 1) &> \
    seq-gen_out/runs/jackalope_2Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 1) &> \
    seq-gen_out/runs/jackalope_20Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 200 4) &> \
    seq-gen_out/runs/jackalope_200Mb_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 2 1) &> \
    seq-gen_out/runs/seqgen_2Mb_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./seq-gen.R 20 4) &> \
    seq-gen_out/runs/jackalope_20Mb_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./seq-gen.sh 200 1) &> \
    seq-gen_out/runs/seqgen_200Mb_1threads_rep5.out

