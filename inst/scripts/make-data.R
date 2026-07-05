### =========================================================================
### GSE142512 RangedSummarizedExperiment resources
### -------------------------------------------------------------------------
###
### This script documents the processing used to create the Zenodo-hosted
### ExperimentHub resources:
###
###   GSE142512_GPL13534_450K.rds
###   GSE142512_GPL21145_EPIC.rds
###
### The large RDS files are not included in this package. They are hosted at:
###
###   https://zenodo.org/records/21198533
###
### The source GEO accession is:
###
###   https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE142512
###

suppressPackageStartupMessages({
    library(minfi)
    library(SummarizedExperiment)
    library(GenomicRanges)
    library(S4Vectors)
})

dir.create("rds", recursive = TRUE, showWarnings = FALSE)

required_cols <- c(
    "Sample_ID", "SID", "GID", "Tissue", "Sex", "T1D_Status", "T1D",
    "Age", "Timepoint", "Array", "Platform", "PlatformName",
    "Description", "Sentrix_ID", "Sentrix_Position", "Basename"
)

make_resource <- function(pheno_file, gset_file, platform, array,
        output_file, object_name) {
    pheno <- read.csv(pheno_file, check.names = FALSE)
    load(gset_file)

    if (!exists("GSet")) {
        stop("Expected object named 'GSet' in ", gset_file, call. = FALSE)
    }
    if (!inherits(GSet, "GenomicRatioSet")) {
        stop("The loaded object is not a GenomicRatioSet.", call. = FALSE)
    }

    missing_cols <- setdiff(required_cols, names(pheno))
    if (length(missing_cols)) {
        stop("Missing phenotype columns: ",
            paste(missing_cols, collapse = ", "), call. = FALSE)
    }
    if (anyDuplicated(pheno$Sample_ID)) {
        stop("Sample_ID contains duplicated values.", call. = FALSE)
    }
    if (anyDuplicated(pheno$Basename)) {
        stop("Basename contains duplicated values.", call. = FALSE)
    }
    if (any(is.na(pheno$Basename) | pheno$Basename == "")) {
        stop("Basename contains missing or empty values.", call. = FALSE)
    }

    sample_names <- colnames(GSet)
    if (is.null(sample_names)) {
        stop("The GSet does not have column names.", call. = FALSE)
    }
    if (!all(sample_names %in% pheno$Sample_ID)) {
        missing_from_pheno <- setdiff(sample_names, pheno$Sample_ID)
        stop("Some GSet samples are missing from phenotype data: ",
            paste(missing_from_pheno, collapse = ", "), call. = FALSE)
    }

    pheno <- pheno[match(sample_names, pheno$Sample_ID), ]
    if (!identical(pheno$Sample_ID, sample_names)) {
        stop("Sample order mismatch after matching phenotype table to GSet.",
            call. = FALSE)
    }

    beta <- minfi::getBeta(GSet)
    m <- minfi::getM(GSet)
    cn <- minfi::getCN(GSet)

    stopifnot(identical(dim(beta), dim(m)))
    stopifnot(identical(dim(beta), dim(cn)))
    stopifnot(identical(rownames(beta), rownames(m)))
    stopifnot(identical(rownames(beta), rownames(cn)))
    stopifnot(identical(colnames(beta), pheno$Sample_ID))

    row_ranges <- rowRanges(GSet)
    if (is.null(row_ranges) || length(row_ranges) != nrow(beta)) {
        stop("rowRanges(GSet) is missing or does not match the assays.",
            call. = FALSE)
    }
    if (is.null(names(row_ranges))) {
        names(row_ranges) <- rownames(beta)
    }
    mcols(row_ranges)$CpG <- rownames(beta)

    col_data <- DataFrame(pheno, row.names = pheno$Sample_ID)
    se <- SummarizedExperiment(
        assays = SimpleList(beta = beta, M = m, CN = cn),
        rowRanges = row_ranges,
        colData = col_data,
        metadata = list(
            title = "Longitudinal DNA methylation differences precede type 1 diabetes",
            geo_accession = "GSE142512",
            platform = platform,
            array = array,
            genome = "hg19",
            tissue = "peripheral blood",
            n_samples = ncol(beta),
            n_subjects = length(unique(pheno$SID)),
            expected_idat_files = nrow(pheno) * 2,
            phenotype_file = pheno_file,
            gset_file = gset_file,
            basename_column = "Basename",
            assays = c("beta", "M", "CN"),
            source_object = "GenomicRatioSet",
            object_name = object_name
        )
    )

    stopifnot(inherits(se, "RangedSummarizedExperiment"))
    stopifnot(ncol(se) == nrow(pheno))
    stopifnot(identical(colnames(se), pheno$Sample_ID))
    stopifnot(identical(rownames(se), rownames(beta)))
    stopifnot(all(c("SID", "Timepoint", "T1D_Status") %in%
        colnames(colData(se))))
    stopifnot(all(c("beta", "M", "CN") %in% assayNames(se)))

    saveRDS(se, output_file, compress = "xz")
    invisible(se)
}

make_resource(
    pheno_file = "data/preprocessingMinfiEwasWater/pheno450.csv",
    gset_file = "rData/GSet_450.RData",
    platform = "GPL13534",
    array = "Illumina HumanMethylation450",
    output_file = "rds/GSE142512_GPL13534_450K.rds",
    object_name = "GSE142512_450K"
)

make_resource(
    pheno_file = "data/preprocessingMinfiEwasWater/phenoEPIC.csv",
    gset_file = "rData/GSet_EPIC.RData",
    platform = "GPL21145",
    array = "Infinium MethylationEPIC",
    output_file = "rds/GSE142512_GPL21145_EPIC.rds",
    object_name = "GSE142512_EPIC"
)
