metadata <- data.frame(
    Title = c(
        "GSE142512_GPL13534_450K",
        "GSE142512_GPL21145_EPIC"
    ),
    Description = c(
        paste(
            "Processed peripheral blood DNA methylation data from GEO accession",
            "GSE142512. The resource is represented as a",
            "RangedSummarizedExperiment with beta, M, and CN assays for 184",
            "samples from 84 subjects profiled on the Illumina",
            "HumanMethylation450 array."
        ),
        paste(
            "Processed peripheral blood DNA methylation data from GEO accession",
            "GSE142512. The resource is represented as a",
            "RangedSummarizedExperiment with beta, M, and CN assays for 211",
            "samples from 90 subjects profiled on the Infinium",
            "MethylationEPIC array."
        )
    ),
    BiocVersion = "3.24",
    Genome = "hg19",
    SourceType = "IDAT",
    SourceUrl = "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE142512",
    SourceVersion = "May 31 2024",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = TRUE,
    DataProvider = "GEO",
    Maintainer = "Paul Ruiz Pinto <ruizpint@qut.edu.au>",
    RDataClass = "RangedSummarizedExperiment",
    DispatchClass = "Rds",
    RDataPath = c(
        "records/21198533/files/GSE142512_GPL13534_450K.rds",
        "records/21198533/files/GSE142512_GPL21145_EPIC.rds"
    ),
    Location_Prefix = "https://zenodo.org/",
    Tags = c(
        paste(c(
            "GSE142512", "GPL13534", "450K", "DNAMethylation",
            "MethylationArray", "ExperimentHub", "SummarizedExperiment",
            "RangedSummarizedExperiment"
        ), collapse = ":"),
        paste(c(
            "GSE142512", "GPL21145", "EPIC", "DNAMethylation",
            "MethylationArray", "ExperimentHub", "SummarizedExperiment",
            "RangedSummarizedExperiment"
        ), collapse = ":")
    ),
    Notes = paste(
        "Zenodo DOI 10.5281/zenodo.21198533; source publication DOI",
        "10.1038/s41598-020-60758-0; peripheral blood GSE142512 processed",
        "resource."
    ),
    stringsAsFactors = FALSE
)

write.csv(metadata, file.path("inst", "extdata", "metadata.csv"),
    row.names = FALSE)
