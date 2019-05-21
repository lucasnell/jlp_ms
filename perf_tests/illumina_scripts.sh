#!/usr/bin/env bash

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

i=1

(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep7.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep3.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 4) &> \
    illumina_out/runs/jackalope_10Mreads_4threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep6.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 4) &> \
    illumina_out/runs/jackalope_1Mreads_4threads_rep5.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 4) &> \
    illumina_out/runs/jackalope_100Mreads_4threads_rep1.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 100 1) &> \
    illumina_out/runs/jackalope_100Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 10 1) &> \
    illumina_out/runs/jackalope_10Mreads_1threads_rep4.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep9.out
echo $i

i=(($i + 1))
(/usr/bin/time -l Rscript ./illumina.R 1 1) &> \
    illumina_out/runs/jackalope_1Mreads_1threads_rep8.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 100 1) &> \
    illumina_out/runs/art_100Mreads_1threads_rep10.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 1 1) &> \
    illumina_out/runs/art_1Mreads_1threads_rep2.out
echo $i

i=(($i + 1))
(/usr/bin/time -l ./illumina.sh 10 1) &> \
    illumina_out/runs/art_10Mreads_1threads_rep3.out

