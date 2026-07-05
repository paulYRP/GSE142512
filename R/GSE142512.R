GSE142512 <- function(platform = c("450K", "EPIC"), metadata = FALSE) {
    platform <- match.arg(platform)
    title <- switch(platform,
        "450K" = "GSE142512_GPL13534_450K",
        "EPIC" = "GSE142512_GPL21145_EPIC"
    )

    hub <- ExperimentHub::ExperimentHub()

    if (metadata) {
        return(ExperimentHub::listResources(
            hub, "GSE142512", filterBy = title))
    }

    resources <- ExperimentHub::loadResources(
        hub, "GSE142512", filterBy = title)

    if (!length(resources)) {
        stop(
            "No GSE142512 ExperimentHub resources were found. ",
            "The resource may not yet be available in the active ",
            "ExperimentHub snapshot.",
            call. = FALSE
        )
    }

    if (length(resources) != 1L) {
        stop(
            "Expected one GSE142512 resource but found ",
            length(resources), ". Use metadata = TRUE to inspect matches.",
            call. = FALSE
        )
    }

    resources[[1L]]
}
