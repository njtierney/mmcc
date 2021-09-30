library(coda)
data(line)

test_that("n_sims returns integer", {
    expect_is(n_sims(line), "integer")
    expect_is(n_sims(line$line1), "integer")
    expect_is(n_sims(mcmc_to_dt(line)), "integer")
    expect_is(n_sims(example_stan_model), "integer")
    expect_is(n_sims(example_jags_model), "integer")
})

test_that("n_sims returns NULL", {
    expect_identical(n_sims(NULL), integer(0))
})

test_that("n_sims returns error when class not known", {
    expect_error(n_sims(iris))
    expect_error(n_sims(100))
    expect_error(n_sims("wat"))
})

test_that("n_sims returns one number only", {
    expect_length(n_sims(line), 1)
    expect_length(n_sims(line$line1), 1)
    expect_length(n_sims(mcmc_to_dt(line)), 1)
    # expect_length(n_iter(mcmc_to_dt(line$line1)), 1)
    expect_length(n_sims(example_stan_model), 1)
    expect_length(n_sims(example_jags_model), 1)
})
