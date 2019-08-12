

#'
#'
#' To do these tests, run the following:
#'
#' testthat::test_file("<path>/test_read_numbers.R")
#'
#'

suppressPackageStartupMessages({
    library(testthat)
    library(jackalope)
})


#' Temporary directory for all output files:
odir <- tempdir()

#' Vignette defaults for molecular evolution:
sub <- sub_TN93(pi_tcag = c(0.1, 0.2, 0.3, 0.4),
                alpha_1 = 0.0001, alpha_2 = 0.0002,
                beta = 0.00015)
ins <- indels(rate = 2e-5, max_length = 10)
del <- indels(rate = 1e-5, max_length = 40)


#' Phylogeny used for all simulations
#' (in comments, it was indicated that they used 50 species)
tree <- ape::rcoal(50)



#' =================================================================================
#' =================================================================================
#'
#' Run A:
#'     Read number - 10e6,
#'     Read Length - 250 bp,
#'     Genome length - 2 million bp
#'     Indels - Vignette default
#'     Paired end
#'
#' =================================================================================
#' =================================================================================


context("Run A")

refA <- create_genome(n_seqs = 10, len_mean = 2e6 / 10)

varsA <- create_variants(refA, vars_phylo(tree), sub, ins, del)

# On my machine, this took ~9.5 min
illumina(varsA, out_prefix = sprintf("%s/%s", odir, "ill-A"),
         n_reads = 10e6, paired = TRUE,
         read_length = 250, overwrite = TRUE)

# On my machine, this took ~2.5 min
test_that("no problems with Run A", {

    # Check that files for forward and reverse reads exist:
    expect_true(sprintf("%s_R1.fq", "ill-A") %in% list.files(odir))
    expect_true(sprintf("%s_R2.fq", "ill-A") %in% list.files(odir))

    # Because these FASTQ files are large, we won't read them into memory.
    fastq <- lapply(1:2, function(i) file(sprintf("%s/%s_R1.fq", odir, "ill-A", i), "r"))

    # I'll do the following checks by blocks of 100,000 reads:
    #   - Every 4th line (starting with the 1st) should always start with "@"
    #   - Every 4th line (starting with the 3rd) should only ever be "+"
    # I'll also count the total # lines in each file as I go
    block <- rep(list(NA_character_), 2)
    for (i in 1:2) {
        block[[i]] <- scan(fastq[[i]], "character", nmax = 100e3 * 4, quiet = TRUE)
    }
    # For numbers of lines:
    nl_fq <- c(0L, 0L)
    # For ID lines always starting with "@":
    all_ids <- c(TRUE, TRUE)
    # For all 3rd lines being "+":
    all_thirds <- c(TRUE, TRUE)
    while (all(sapply(block, length) > 0)) {
        for (i in 1:2) {
            nl <- length(block[[i]])
            nl_fq[i] <- nl_fq[i] + nl
            all_ids[i] <- all_ids[i] & all(grepl("^@", block[[i]][seq(1, nl, 4)]))
            all_thirds[i] <- all_thirds[i] & all(block[[i]][seq(3, nl, 4)] == "+")
            block[[i]] <- scan(fastq[[i]], "character", nmax = 100e3 * 4, quiet = TRUE)
        }
    }

    # Each FASTQ file should contain half the total reads and 4 lines per read
    n_lines <- 10e6 / 2 * 4
    expect_equal(nl_fq[1], n_lines)
    expect_equal(nl_fq[2], n_lines)

    expect_true(all(all_ids))
    expect_true(all(all_thirds))

    for (i in 1:2) close(fastq[[i]])

})



#' =================================================================================
#' =================================================================================
#'
#' Run B:
#'     Read number - 1e5
#'     Read length - 250 bp
#'     Genome length - 100k bp
#'     Indels - Vignette default
#'     Paired end
#'
#' =================================================================================
#' =================================================================================


context("Run B")

refB <- create_genome(n_seqs = 10, len_mean = 100e3 / 10)

varsB <- create_variants(refB, vars_phylo(tree), sub, ins, del)

illumina(varsB, out_prefix = sprintf("%s/%s", odir, "ill-B"),
         n_reads = 1e5, paired = TRUE,
         read_length = 250, overwrite = TRUE)


test_that("no problems with Run B", {

    # Check that files for forward and reverse reads exist:
    expect_true(sprintf("%s_R1.fq", "ill-B") %in% list.files(odir))
    expect_true(sprintf("%s_R2.fq", "ill-B") %in% list.files(odir))

    # Read FASTQ files into memory:
    fastq1 <- readLines(sprintf("%s/%s_R1.fq", odir, "ill-B"))
    fastq2 <- readLines(sprintf("%s/%s_R2.fq", odir, "ill-B"))

    # Each FASTQ file should contain half the total reads and 4 lines per read
    n_lines <- 1e5 / 2 * 4
    expect_length(fastq1, n_lines)
    expect_length(fastq2, n_lines)
    # Every 4th line (starting with the 1st) should always start with "@"
    expect_true(all(grepl("^@", fastq1[seq(1, n_lines, 4)])))
    expect_true(all(grepl("^@", fastq2[seq(1, n_lines, 4)])))
    # Every 4th line (starting with the 3rd) should only ever be "+"
    expect_identical(fastq1[seq(3, n_lines, 4)], rep("+", n_lines / 4))
    expect_identical(fastq2[seq(3, n_lines, 4)], rep("+", n_lines / 4))

})



# Because this one doesn't take tons of time, I'll try it with sep. files, too.

illumina(varsB, out_prefix = sprintf("%s/%s", odir, "ill-B"),
         n_reads = 1e5, paired = TRUE,
         read_length = 250, overwrite = TRUE,
         sep_files = TRUE)

test_that("no problems with Run B - sep. files", {

    for (tt in tree$tip.label) {

        # Check that files for forward and reverse reads exist:
        expect_true(sprintf("%s_%s_R1.fq", "ill-B", tt) %in% list.files(odir))
        expect_true(sprintf("%s_%s_R2.fq", "ill-B", tt) %in% list.files(odir))

        # Read FASTQ files into memory:
        fastq1 <- readLines(sprintf("%s/%s_%s_R1.fq", odir, "ill-B", tt))
        fastq2 <- readLines(sprintf("%s/%s_%s_R2.fq", odir, "ill-B", tt))

        expect_equal(length(fastq1), length(fastq2))
        n_lines <- length(fastq1)
        # Every 4th line (starting with the 1st) should always start with "@"
        expect_true(all(grepl("^@", fastq1[seq(1, n_lines, 4)])))
        expect_true(all(grepl("^@", fastq2[seq(1, n_lines, 4)])))
        # Every 4th line (starting with the 3rd) should only ever be "+"
        expect_identical(fastq1[seq(3, n_lines, 4)], rep("+", n_lines / 4))
        expect_identical(fastq2[seq(3, n_lines, 4)], rep("+", n_lines / 4))

    }

})



#' =================================================================================
#' =================================================================================
#' Run C:
#'     Read number - 10e6
#'     Read length - 100 bp
#'     Genome length - 2 million bp
#'     indels - insertions: 2e-3, deletions: 1e-3
#'     Paired end
#' =================================================================================
#' =================================================================================


context("Run C")


refC <- create_genome(n_seqs = 10, len_mean = 2e6 / 10)

varsC <- create_variants(refC, vars_phylo(tree), sub,
                         ins = indels(rate = 2e-3, max_length = 10),
                         del = indels(rate = 1e-3, max_length = 40))

# On my machine, this took ~3.5 min
illumina(varsC, out_prefix = sprintf("%s/%s", odir, "ill-C"),
         n_reads = 10e6, paired = TRUE,
         read_length = 100, overwrite = TRUE)

test_that("no problems with Run C", {

    # Check that files for forward and reverse reads exist:
    expect_true(sprintf("%s_R1.fq", "ill-C") %in% list.files(odir))
    expect_true(sprintf("%s_R2.fq", "ill-C") %in% list.files(odir))

    # Because these FASTQ files are large, we won't read them into memory.
    fastq <- lapply(1:2, function(i) file(sprintf("%s/%s_R1.fq", odir, "ill-C", i), "r"))

    # I'll do the following checks by blocks of 100,000 reads:
    #   - Every 4th line (starting with the 1st) should always start with "@"
    #   - Every 4th line (starting with the 3rd) should only ever be "+"
    # I'll also count the total # lines in each file as I go
    block <- rep(list(NA_character_), 2)
    for (i in 1:2) {
        block[[i]] <- scan(fastq[[i]], "character", nmax = 100e3 * 4, quiet = TRUE)
    }
    # For numbers of lines:
    nl_fq <- c(0L, 0L)
    # For ID lines always starting with "@":
    all_ids <- c(TRUE, TRUE)
    # For all 3rd lines being "+":
    all_thirds <- c(TRUE, TRUE)
    while (all(sapply(block, length) > 0)) {
        for (i in 1:2) {
            nl <- length(block[[i]])
            nl_fq[i] <- nl_fq[i] + nl
            all_ids[i] <- all_ids[i] & all(grepl("^@", block[[i]][seq(1, nl, 4)]))
            all_thirds[i] <- all_thirds[i] & all(block[[i]][seq(3, nl, 4)] == "+")
            block[[i]] <- scan(fastq[[i]], "character", nmax = 100e3 * 4, quiet = TRUE)
        }
    }

    # Each FASTQ file should contain half the total reads and 4 lines per read
    n_lines <- 10e6 / 2 * 4
    expect_equal(nl_fq[1], n_lines)
    expect_equal(nl_fq[2], n_lines)

    expect_true(all(all_ids))
    expect_true(all(all_thirds))

    for (i in 1:2) close(fastq[[i]])

})


