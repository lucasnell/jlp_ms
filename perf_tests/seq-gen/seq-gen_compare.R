#'
#' The code below shows that jackalope is producing at least as many
#' mutations as seq-gen.
#'

Rcpp::sourceCpp(code =
"#include <RcppArmadillo.h>
#include <string>
#include <vector>

//[[Rcpp::depends(RcppArmadillo)]]
//[[Rcpp::plugins(cpp11)]]

using namespace Rcpp;

//[[Rcpp::export]]
std::vector<int> comp_strings(const std::vector<std::string>& strings) {

    size_t n_str = strings.size();
    if (n_str == 0) stop(\"empty vector\");
    size_t n_chr = strings[0].size();
    for (size_t i = 1; i < n_str; i++) {
        if (strings[i].size() != n_chr) stop(\"not all the same length\");
    }

    std::vector<int> M;
    M.reserve((n_str * (n_str - 1)) / 2);
    for (size_t i = 0; i < (n_str-1); i++) {
        for (size_t j = (i+1); j < n_str; j++) {
            M.push_back(0);
            for (size_t k = 0; k < n_chr; k++) {
                if (strings[i][k] != strings[j][k]) M.back()++;
            }
        }
    }

    return M;
}
")

sg_diffs <- function() {

    system(paste("cd ~/GitHub/Wisconsin/jlp_ms/perf_tests &&",
                 "seq-gen -q -m HKY -l 1000 -a 1 -s 0.001 <",
                 "in_files/seq-gen.tree > seq-gen_out/seqfile_1000"))

    sg <- readLines("seq-gen_out/seqfile_1000")
    sg <- paste(sg, collapse = "\n")
    sg <- strsplit(sg, " 8 1000\n")[[1]]
    sg <- strsplit(sg, "\n")[-1]
    names(sg) <- ref$names()


    sg_seqs <- lapply(sg, function(x) sapply(x, function(y) substr(gsub("\\s+", "", y),
                                                                   2, 1e9L),
                                             USE.NAMES = FALSE))
    names(sg_seqs) <- ref$names()

    sg_diffs_ <- sapply(lapply(sg_seqs, comp_strings), sum)
    names(sg_diffs_) <- NULL

    return(sg_diffs_)
}

jlp_diffs <- function() {
    vars <- create_variants(ref,
                            vars_gtrees(fn = "in_files/scrm.tree"),
                            # mean mutation rate of 0.001:
                            sub = sub_HKY85(rep(0.25, 4), 0.004, 0.006),
                            gamma_mats = site_var(ref, shape = 1, region_size = 100),
                            n_threads = nt)

    jlp_seqs <- lapply(1:vars$n_seqs(),
                       function(s) {
                           sapply(1:vars$n_vars(), function(v) vars$sequence(v, s))
                       })
    jlp_diffs_ <- sapply(lapply(jlp_seqs, comp_strings), sum)

    return(jlp_diffs_)
}




sgd <- do.call(c, replicate(100, sg_diffs(), FALSE))
jlpd <- do.call(c, replicate(100, jlp_diffs(), FALSE))

mean(sgd); mean(jlpd)
{
    par(mfrow = c(2, 1))
    hist(sgd, xlim = c(0, max(c(sgd, jlpd))))
    hist(jlpd, xlim = c(0, max(c(sgd, jlpd))))
}
t.test(sgd, jlpd)
