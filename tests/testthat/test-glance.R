context("test-glance")

library(coda)
data(line)
gl <- glance(line)

test_that("glance returns a dataframe", {
    expect_is(gl, "data.frame")
})

test_that("glance has the right names", {
    expect_equal(names(gl),
                 c("n_chains",
                   "n_iter",
                   "n_var",
                   "ess_lower",
                   "ess_upper",
                   "rhat_lower",
                   "rhat_upper"))
})

test_that("glance has the right dimensions", {
    expect_equal(nrow(gl), 1)
    expect_equal(ncol(gl), 7)
})
