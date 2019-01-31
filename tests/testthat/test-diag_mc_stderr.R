context("test-diag_mc_stderr")

library(coda)
data(line)
r <- diag_mc_stderr(line, warn = FALSE)

test_that("diag_mc_stderr returns a dataframe", {
    expect_is(r, "data.frame")
    expect_is(r, "data.table")
})

test_that("diag_mc_stderr has the right names", {
    expect_equal(names(r),
                 c("parameter",
                   "chain",
                   "mean",
                   "value"))
})

test_that("diag_mc_stderr has the right dimensions", {
    expect_equal(nrow(r), 6)
    expect_equal(ncol(r), 4)
})

r_cube <- diag_mc_stderr(line, warn = FALSE, b_size = "cuberoot")
r_sqrt <- diag_mc_stderr(line, warn = FALSE, b_size = "sqroot")

test_that("diag_mc_stderr bsize works", {
    expect_equal(names(r_cube),
                 c("parameter",
                   "chain",
                   "mean",
                   "value"))

    expect_equal(names(r_sqrt),
                 c("parameter",
                   "chain",
                   "mean",
                   "value"))

    expect_equal(nrow(r_cube), 6)
    expect_equal(ncol(r_cube), 4)

    expect_equal(nrow(r_sqrt), 6)
    expect_equal(ncol(r_sqrt), 4)

})

test_that("diag_mc_stderr warn works", {
    expect_warning(diag_mc_stderr(line, warn = TRUE))
})

