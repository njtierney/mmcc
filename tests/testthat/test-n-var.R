context("test-n-var")

library(coda)
data(line)
example_jags_model$recompile()

test_that("n_var returns integer", {
    expect_is(n_var(line), "integer")
    expect_is(n_var(line$line1), "integer")
    expect_is(n_var(mcmc_to_dt(line)), "integer")
    # expect_is(n_var(mcmc_to_dt(line$line1)), "integer")
    expect_is(n_var(example_stan_model), "integer")
    expect_is(n_var(example_jags_model), "integer")
})

test_that("n_var returns NULL", {
    expect_null(n_var(NULL))
})

test_that("n_var returns error when class not known", {
    expect_error(n_var(iris))
    expect_error(n_var(100))
    expect_error(n_var("wat"))
})

test_that("n_var returns one number only", {
    expect_length(n_var(line), 1)
    expect_length(n_var(line$line1), 1)
    expect_length(n_var(mcmc_to_dt(line)), 1)
    # expect_length(n_var(mcmc_to_dt(line$line1)), 1)
    expect_length(n_var(example_stan_model), 1)
    expect_length(n_var(example_jags_model), 1)
})

test_that("n_var returns number greater than 0 and less than infinity", {
    expect_gt(n_var(line), 0)
    expect_gt(n_var(line$line1), 0)
    expect_gt(n_var(mcmc_to_dt(line)), 0)
    # expect_gt(n_var(mcmc_to_dt(line$line1)), 0)
    expect_gt(n_var(example_stan_model), 0)
    expect_gt(n_var(example_jags_model), 0)

    expect_lt(n_var(line), Inf)
    expect_lt(n_var(line$line1), Inf)
    expect_lt(n_var(mcmc_to_dt(line)), Inf)
    # expect_lt(n_var(mcmc_to_dt(line$line1)), Inf)
    expect_lt(n_var(example_stan_model), Inf)
    expect_lt(n_var(example_jags_model), Inf)
})
