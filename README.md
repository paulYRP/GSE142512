[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21198533.svg)](https://doi.org/10.5281/zenodo.21198533)
# GSE142512


`GSE142512` is a Bioconductor ExperimentHub data package for processed DNA
methylation resources derived from GEO Series GSE142512.

The package provides access to two Zenodo-hosted
`RangedSummarizedExperiment` resources:

- `GSE142512_GPL13534_450K`: Illumina HumanMethylation450 data with 485,512
  CpG loci and 184 samples.
- `GSE142512_GPL21145_EPIC`: Infinium MethylationEPIC data with 865,859 CpG
  loci and 211 samples.

Both resources include beta, M, and CN assays, hg19 genomic ranges, and
sample-level phenotype metadata.

The source study is:

Johnson RK, Vanderlinden LA, Dong F, Carry PM, Seifert J, Waugh K, Shorrosh H,
Fingerlin T, Frohnert BI, Yang IV, Kechris K, Rewers M, Norris JM.
Longitudinal DNA methylation differences precede type 1 diabetes. Scientific
Reports. 2020;10:3721. doi:10.1038/s41598-020-60758-0.

The hosted files are available from Zenodo:

https://zenodo.org/records/21198533

The source GEO record is:

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE142512

The resources can be queried with:

```r
library(ExperimentHub)
hub <- ExperimentHub()
query(hub, "GSE142512")
```

or loaded through the package helpers:

```r
library(GSE142512)
se450k <- GSE142512(platform = "450K")
seEPIC <- GSE142512(platform = "EPIC")
```

The same resources can also be loaded with their resource-title accessors:

```r
se450k <- GSE142512_GPL13534_450K()
seEPIC <- GSE142512_GPL21145_EPIC()
```
