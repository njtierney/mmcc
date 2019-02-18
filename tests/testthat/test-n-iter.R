context("test-n-iter")

library(coda)
data(line)
example_jags_model$recompile()

test_that("n_iter returns integer", {
    expect_is(n_iter(line), "integer")
    expect_is(n_iter(line$line1), "integer")
    expect_is(n_iter(mcmc_to_dt(line)), "integer")
    # expect_is(n_iter(mcmc_to_dt(line$line1)), "integer")
    expect_is(n_iter(example_stan_model), "integer")
    expect_is(n_iter(example_jags_model), "integer")
})

test_that("n_iter returns NULL", {
    expect_null(n_iter(NULL))
})

test_that("n_iter returns error when class not known", {
    expect_error(n_iter(iris))
    expect_error(n_iter(100))
    expect_error(n_iter("wat"))
})

test_that("n_iter returns one number only", {
    expect_length(n_iter(line), 1)
    expect_length(n_iter(line$line1), 1)
    expect_length(n_iter(mcmc_to_dt(line)), 1)
    # expect_length(n_iter(mcmc_to_dt(line$line1)), 1)
    expect_length(n_iter(example_stan_model), 1)
    expect_length(n_iter(example_jags_model), 1)
})

test_that("n_iter returns number greater than 0 and less than infinity", {
    expect_gt(n_iter(line), 0)
    expect_gt(n_iter(line$line1), 0)
    expect_gt(n_iter(mcmc_to_dt(line)), 0)
    # expect_gt(n_iter(mcmc_to_dt(line$line1)), 0)
    expect_gt(n_iter(example_stan_model), 0)
    expect_gt(n_iter(example_jags_model), 0)

    expect_lt(n_iter(line), Inf)
    expect_lt(n_iter(line$line1), Inf)
    expect_lt(n_iter(mcmc_to_dt(line)), Inf)
    # expect_lt(n_iter(mcmc_to_dt(line$line1)), Inf)
    expect_lt(n_iter(example_stan_model), Inf)
    expect_lt(n_iter(example_jags_model), Inf)
})
