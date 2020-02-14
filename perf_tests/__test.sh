#!/usr/bin/env bash



# pacbio, then illumina, then indelible, then ngsphy tests:
echo -e "\n---------\npacbio\n---------\n" && \
for i in 1 10 100
do
    Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/pacbio/__test.R $i
    echo $i
done && \
echo -e "\n---------\nillumina\n---------\n" && \
for i in 0.1 1 10
do
    Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/illumina/__test.R $i
    echo $i
done && \
echo -e "\n---------\nseq-gen\n---------\n" && \
for s in 2 20
do
    for m in 0.001 0.01 0.1
    do
        Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/seq-gen/__test.R $s $m
        echo $s $m
    done
done && \
echo -e "\n---------\nindelible\n---------\n" && \
for s in 2 20
do
    for m in 0.001 0.01 0.1
    do
        Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/indelible/__test.R $s $m
        echo $s $m
    done
done && \
echo -e "\n---------\nngsphy\n---------\n" && \
for s in 2 20
do
    for m in 0.001 0.01 0.1
    do
        for r in 0.1 1 10
        do
            Rscript ~/GitHub/Wisconsin/jlp_ms/perf_tests/ngsphy/__test.R $s $m $r
            echo $s $m $r
        done
    done
done
