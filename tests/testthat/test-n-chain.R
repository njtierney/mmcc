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
