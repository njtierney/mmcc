context("test-mcmc_to_dt-stan")

tidy_stan <- mcmc_to_dt(example_stan_model)


test_that("mcmc_to_dt.stan returns a dataframe and datatable", {
    expect_is(tidy_stan, "data.frame")
    expect_is(tidy_stan, "data.table")
})

test_that("mcmc_to_dt.stan has the right names", {
    expect_equal(names(tidy_stan),
                 c("iteration",
                   "chain",
                   "parameter",
                   "value"))
})

test_that("mcmc_to_dt.stan has the right dimensions", {
    expect_equal(nrow(tidy_stan), 120)
    expect_equal(ncol(tidy_stan), 4)
})

