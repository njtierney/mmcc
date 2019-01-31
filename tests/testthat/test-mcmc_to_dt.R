context("mcmc_to_dt")

library(coda)
data(line)

test_that("mcmc_to_dt returns a dataframe and datatable", {
  expect_is(mcmc_to_dt(line), "data.frame")
  expect_is(mcmc_to_dt(line), "data.table")
})

test_that("mcmc_to_dt has the right names", {
  expect_equal(names(mcmc_to_dt(line)),
               c("iteration",
                 "chain",
                 "parameter",
                 "value"))
})

test_that("mcmc_to_dt has the right dimensions", {
  expect_equal(nrow(mcmc_to_dt(line)), 1200)
  expect_equal(ncol(mcmc_to_dt(line)), 4)
})

