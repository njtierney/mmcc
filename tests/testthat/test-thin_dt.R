context("test-thin_dt")

library(coda)
data(line)

mcmc_dt <- mcmc_to_dt(line)

thin_dt_2 <- thin_dt(mcmc_dt, thin = 2)
thin_dt_10 <- thin_dt(mcmc_dt, thin = 10)
thin_dt_20 <- thin_dt(mcmc_dt, thin = 20)

var_names <- c("iteration",
               "chain",
               "parameter",
               "value")

test_that("thin_dt returns a dataframe", {
    expect_is(thin_dt_2, "data.frame")
    expect_is(thin_dt_10, "data.frame")
    expect_is(thin_dt_20, "data.frame")
})

test_that("thin_dt has the right names", {
    expect_equal(names(thin_dt_2), var_names)
    expect_equal(names(thin_dt_10), var_names)
    expect_equal(names(thin_dt_20), var_names)
})

test_that("thin_dt has the right dimensions", {
    expect_equal(nrow(thin_dt_2), 600)
    expect_equal(ncol(thin_dt_2), 4)

    expect_equal(nrow(thin_dt_10), 120)
    expect_equal(ncol(thin_dt_10), 4)

    expect_equal(nrow(thin_dt_20), 60)
    expect_equal(ncol(thin_dt_20), 4)
})
