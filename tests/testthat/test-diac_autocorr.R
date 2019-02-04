context("test-diac_autocorr")

library(coda)
data(line)
r <- diag_autocorr(line)

test_that("diag_autocorr returns a data.table", {
    expect_is(r, "data.frame")
    expect_is(r, "data.table")
})

test_that("diag_autocorr has the right names", {
    expect_equal(names(r),
                 c("chain",
                   "parameter",
                   "lag",
                   "acf"))
})

test_that("diag_autocorr has the right dimensions", {
    expect_equal(nrow(r), 150)
    expect_equal(ncol(r), 4)
})

r_lag_5 <- diag_autocorr(line, lags = 5)

test_that("diag_autocorr lag 5 works", {
    expect_equal(names(r_lag_5),
                 c("chain",
                   "parameter",
                   "lag",
                   "acf"))

    expect_equal(nrow(r_lag_5), 6)
    expect_equal(ncol(r_lag_5), 4)

})

r_lag_1_10 <- diag_autocorr(line, lags = 1:10)

test_that("diag_autocorr lag 1:10 works", {
    expect_equal(names(r_lag_1_10),
                 c("chain",
                   "parameter",
                   "lag",
                   "acf"))

    expect_equal(nrow(r_lag_1_10), 60)
    expect_equal(ncol(r_lag_1_10), 4)

})

r_lag_1_100_by_9 <- diag_autocorr(line, lags = seq(1L, 100L, by = 9L))

test_that("diag_autocorr lag 1:100 by 9 works", {
    expect_equal(names(r_lag_1_100_by_9),
                 c("chain",
                   "parameter",
                   "lag",
                   "acf"))

    expect_equal(nrow(r_lag_1_100_by_9), 72)
    expect_equal(ncol(r_lag_1_100_by_9), 4)

})
