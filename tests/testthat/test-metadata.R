test_that("ExperimentHub metadata has the required schema", {
    metadata_file <- system.file(
        "extdata", "metadata.csv",
        package = "GSE142512",
        mustWork = TRUE
    )
    metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)

    required_columns <- c(
        "Title", "Description", "BiocVersion", "Genome", "SourceType",
        "SourceUrl", "SourceVersion", "Species", "TaxonomyId",
        "Coordinate_1_based", "DataProvider", "Maintainer", "RDataClass",
        "DispatchClass", "RDataPath", "Location_Prefix", "Tags", "Notes"
    )

    expect_identical(nrow(metadata), 2L)
    expect_setequal(names(metadata), required_columns)
    expect_false(anyDuplicated(metadata$Title) > 0L)
    expect_false(anyNA(metadata))
    expect_false(any(vapply(metadata, is.character, logical(1L)) &
        vapply(metadata, function(x) any(!nzchar(x)), logical(1L))))
})

test_that("ExperimentHub metadata describes both published resources", {
    metadata_file <- system.file(
        "extdata", "metadata.csv",
        package = "GSE142512",
        mustWork = TRUE
    )
    metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)
    rownames(metadata) <- metadata$Title

    expected_titles <- c(
        "GSE142512_GPL13534_450K",
        "GSE142512_GPL21145_EPIC"
    )
    expect_setequal(metadata$Title, expected_titles)
    expect_true(all(metadata$Genome == "hg19"))
    expect_true(all(metadata$Species == "Homo sapiens"))
    expect_true(all(metadata$TaxonomyId == 9606L))
    expect_true(all(metadata$Coordinate_1_based))
    expect_true(all(metadata$RDataClass == "RangedSummarizedExperiment"))
    expect_true(all(metadata$DispatchClass == "Rds"))
    expect_true(all(grepl("GSE142512", metadata$SourceUrl, fixed = TRUE)))
    expect_true(all(grepl("GSE142512", metadata$Tags, fixed = TRUE)))

    resource_urls <- paste0(metadata$Location_Prefix, metadata$RDataPath)
    expect_true(all(grepl("^https://zenodo\\.org/records/", resource_urls)))
    expect_identical(
        basename(metadata["GSE142512_GPL13534_450K", "RDataPath"]),
        "GSE142512_GPL13534_450K.rds"
    )
    expect_identical(
        basename(metadata["GSE142512_GPL21145_EPIC", "RDataPath"]),
        "GSE142512_GPL21145_EPIC.rds"
    )
    expect_match(
        metadata["GSE142512_GPL13534_450K", "Description"],
        "184 samples",
        fixed = TRUE
    )
    expect_match(
        metadata["GSE142512_GPL21145_EPIC", "Description"],
        "211 samples",
        fixed = TRUE
    )
})
