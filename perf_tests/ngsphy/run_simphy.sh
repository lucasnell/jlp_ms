
cd ~/GitHub/Wisconsin/jlp_ms/perf_tests/ngsphy

Rscript -e 'set.seed(780345)
source("../indelible/write_tree.R")
tr <- ape::rcoal(8)
tr$tip.label <- gsub("^t", "", tr$tip.label)
# Make max node depth 1:
tr$edge.length <- tr$edge.length / max(ape::node.depth.edgelength(tr))
nexus_str <- paste("#NEXUS", "BEGIN TREES;",
                   paste("    tree 1 =", write_tree(tr)),
                   "END;\n",
                   sep = "\n")
writeLines(nexus_str, "spp_tree.tree")'

export simphy=~/Downloads/SimPhy_1.0.2/bin/simphy_mac64

# -RS i: Number of species tree replicates (i.e., study replicates).
# -RL *: Number of locus trees per species tree.
# -RG i: Number of gene trees per locus tree. (Not for general usage).
# -V [0,6]: Verbosity
# -O c: Common output prefix-name (for folders and files).

# -S c: Species tree (extended Newick format) (see 5.2.1).
# -SL *: Number of taxa.
# -ST *: Species tree height (time units).
# -SG *: Tree-wide generation time.
# -SU *: Tree-wide substitution rate.
# -SB *: Speciation rate (events/time unit).
# -SI *: Number of individuals per species.
# -SP *: Tree-wide effective population size.

# -OD b: Activates the SQLite database output.
# -OP b: Activates logging of sampled options.

# -CS i: Random number generator seed.


# From simulations, a substitution rate of 0.000571977 generates gene trees
# with an average maximum depth of 1

for i in {1..3}
do
    # (`bc` doesn't include preceding 0 in decimals)
    m=0`echo "scale=3; 10^-" $i | bc`
    u=0`echo $m "* 0.000571977" | bc -l`
    seed=$((i + 313277641))
    $simphy -RS 1 -RL F:20 -RG 10 -O simphy_${m} \
        -SR "spp_tree.tree" -SG F:1 -SI F:1 -SU F:$u -SP F:1000 \
        -OD 1 -OP 1 \
        -CS $seed
done




