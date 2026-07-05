\name{GSE142512}
\alias{GSE142512}
\alias{GSE142512_GPL13534_450K}
\alias{GSE142512_GPL21145_EPIC}
\title{Load GSE142512 ExperimentHub resources}
\usage{
GSE142512(platform = c("450K", "EPIC"), metadata = FALSE)

GSE142512_GPL13534_450K(metadata = FALSE)

GSE142512_GPL21145_EPIC(metadata = FALSE)
}
\arguments{
\item{platform}{\code{character(1)}. Platform to load. Use \code{"450K"} for
the GPL13534 Illumina HumanMethylation450 resource or \code{"EPIC"} for the
GPL21145 Infinium MethylationEPIC resource.}
\item{metadata}{\code{logical(1)}. If \code{TRUE}, return ExperimentHub
metadata for the matching resource. If \code{FALSE}, load the matching
resource.}
}
\value{
When \code{metadata = FALSE}, a \code{RangedSummarizedExperiment}. When
\code{metadata = TRUE}, the matching ExperimentHub metadata.
}
\description{
Convenience helpers for loading processed GSE142512 DNA methylation resources
from \pkg{ExperimentHub}.
}
\details{
The package registers two ExperimentHub resources:
\code{GSE142512_GPL13534_450K} and \code{GSE142512_GPL21145_EPIC}. Each
resource contains beta, M, and CN assays with hg19 genomic ranges and
sample-level phenotype metadata.

The resource-title accessors are generated from
\file{inst/extdata/metadata.csv} when the package is loaded.
}
\examples{
metadata_file <- system.file("extdata", "metadata.csv", package = "GSE142512")
metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)
metadata[, c("Title", "Genome", "RDataClass")]

if (interactive()) {
    library(GSE142512)
    GSE142512(platform = "450K", metadata = TRUE)
    se450k <- GSE142512(platform = "450K")
    seEPIC <- GSE142512(platform = "EPIC")
    se450k
    seEPIC
}
}
\seealso{
\code{\link[ExperimentHub]{ExperimentHub}},
\code{\link[ExperimentHub]{listResources}},
\code{\link[ExperimentHub]{loadResources}}
}
\keyword{datasets}
