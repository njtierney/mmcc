context("test-tidy")

library(coda)
data(line)

test_that("tidy returns a dataframe and datatable", {
    expect_is(tidy(line), "data.frame")
    expect_is(tidy(line), "data.table")
})

test_that("tidy has the right names", {
    expect_equal(names(tidy(line)),
                 c("parameter",
                   "mean",
                   "sd",
                   "2.5%",
                   "median",
                   "97.5%"))
})

test_that("tidy has the right dimensions", {
    expect_equal(nrow(tidy(line)), 3)
    expect_equal(ncol(tidy(line)), 6)
})


test_that("tidy chain option works", {
    expect_equal(nrow(tidy(line, chain = TRUE)), 6)
    expect_equal(ncol(tidy(line, chain = TRUE)), 7)
})

test_that("tidy colnames option works", {
    expect_equal(nrow(tidy(line, colnames = "alpha")), 1)
    expect_equal(ncol(tidy(line, colnames = "alpha")), 6)

    expect_equal(nrow(tidy(line, colnames = "beta")), 1)
    expect_equal(ncol(tidy(line, colnames = "beta")), 6)

    expect_equal(nrow(tidy(line, colnames = "sigma")), 1)
    expect_equal(ncol(tidy(line, colnames = "sigma")), 6)

})

test_that("tidy colnames and chain options work", {
    expect_equal(nrow(tidy(line, colnames = "alpha", chain = TRUE)), 2)
    expect_equal(ncol(tidy(line, colnames = "alpha", chain = TRUE)), 7)

    expect_equal(nrow(tidy(line, colnames = "beta", chain = TRUE)), 2)
    expect_equal(ncol(tidy(line, colnames = "beta", chain = TRUE)), 7)

    expect_equal(nrow(tidy(line, colnames = "sigma", chain = TRUE)), 2)
    expect_equal(ncol(tidy(line, colnames = "sigma", chain = TRUE)), 7)
})

test_that("tidy fails when conf_level is three numbers", {
    expect_error(tidy(line, conf_level = c(0.95, 0.50, 0.25)))
})

test_that("tidy fails when conf_level is greater than 1", {
    expect_error(tidy(line, conf_level = c(0.95, 50)))
})
