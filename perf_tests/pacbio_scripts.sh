#!/usr/bin/env bash

cd ~/GitHub/Wisconsin/jlp_ms/perf_tests

i=1

(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 10 1) &> \
    pacbio_out/runs/simlord_10kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep3.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep5.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep4.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 1 1) &> \
    pacbio_out/runs/simlord_1kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 4) &> \
    pacbio_out/runs/jackalope_1kreads_4threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep10.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 1 1) &> \
    pacbio_out/runs/jackalope_1kreads_1threads_rep8.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep2.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep6.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 4) &> \
    pacbio_out/runs/jackalope_100kreads_4threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l ./pacbio.sh 100 1) &> \
    pacbio_out/runs/simlord_100kreads_1threads_rep9.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 4) &> \
    pacbio_out/runs/jackalope_10kreads_4threads_rep1.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 100 1) &> \
    pacbio_out/runs/jackalope_100kreads_1threads_rep7.out
echo $i

i=$(($i + 1))
(/usr/bin/time -l Rscript ./pacbio.R 10 1) &> \
    pacbio_out/runs/jackalope_10kreads_1threads_rep4.out

