context("test-n-chain")

library(coda)
data(line)
example_jags_model$recompile()

test_that("n_chain returns integer", {
    expect_is(n_chain(line), "integer")
    expect_is(n_chain(line$line1), "integer")
    expect_is(n_chain(mcmc_to_dt(line)), "integer")
    # expect_is(n_chain(mcmc_to_dt(line$line1)), "integer")
    expect_is(n_chain(example_stan_model), "integer")
    expect_is(n_chain(example_jags_model), "integer")
})

test_that("n_chain returns NULL", {
    expect_null(n_chain(NULL))
})

test_that("n_chain returns error when class not known", {
    expect_error(n_chain(iris))
    expect_error(n_chain(100))
    expect_error(n_chain("wat"))
})

test_that("n_chain returns one number only", {
    expect_length(n_chain(line), 1)
    expect_length(n_chain(line$line1), 1)
    expect_length(n_chain(mcmc_to_dt(line)), 1)
    # expect_length(n_chain(mcmc_to_dt(line$line1)), 1)
    expect_length(n_chain(example_stan_model), 1)
    expect_length(n_chain(example_jags_model), 1)
})

test_that("n_chain returns number greater than 0 and less than infinity", {
    expect_gt(n_chain(line), 0)
    expect_gt(n_chain(line$line1), 0)
    expect_gt(n_chain(mcmc_to_dt(line)), 0)
    # expect_gt(n_chain(mcmc_to_dt(line$line1)), 0)
    expect_gt(n_chain(example_stan_model), 0)
    expect_gt(n_chain(example_jags_model), 0)

    expect_lt(n_chain(line), Inf)
    expect_lt(n_chain(line$line1), Inf)
    expect_lt(n_chain(mcmc_to_dt(line)), Inf)
    # expect_lt(n_chain(mcmc_to_dt(line$line1)), Inf)
    expect_lt(n_chain(example_stan_model), Inf)
    expect_lt(n_chain(example_jags_model), Inf)
})
