test_that("GSE142512 loads the default 450K resource", {
    hub <- new.env(parent = emptyenv())
    resource <- structure(list(), class = "GSE142512_test_resource")

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(x, package, filterBy) {
            expect_identical(x, hub)
            expect_identical(package, "GSE142512")
            expect_identical(filterBy, "GSE142512_GPL13534_450K")
            list(resource)
        },
        .package = "ExperimentHub"
    )

    expect_identical(GSE142512(), resource)
})

test_that("GSE142512 returns EPIC metadata without loading the resource", {
    hub <- new.env(parent = emptyenv())
    expected <- data.frame(Title = "GSE142512_GPL21145_EPIC")

    local_mocked_bindings(
        ExperimentHub = function() hub,
        listResources = function(x, package, filterBy) {
            expect_identical(x, hub)
            expect_identical(package, "GSE142512")
            expect_identical(filterBy, "GSE142512_GPL21145_EPIC")
            expected
        },
        loadResources = function(...) {
            fail("loadResources() should not be called when metadata = TRUE")
        },
        .package = "ExperimentHub"
    )

    expect_identical(
        GSE142512(platform = "EPIC", metadata = TRUE),
        expected
    )
})

test_that("GSE142512 validates the requested platform", {
    expect_error(
        GSE142512(platform = "EPICv2"),
        "'arg' should be one of",
        fixed = TRUE
    )
})

test_that("GSE142512 reports missing and ambiguous resources", {
    hub <- new.env(parent = emptyenv())

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(...) list(),
        .package = "ExperimentHub"
    )
    expect_error(
        GSE142512(),
        "No GSE142512 ExperimentHub resources were found",
        fixed = TRUE
    )

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(...) list("first", "second"),
        .package = "ExperimentHub"
    )
    expect_error(
        GSE142512(platform = "EPIC"),
        "Expected one GSE142512 resource but found 2",
        fixed = TRUE
    )
})
