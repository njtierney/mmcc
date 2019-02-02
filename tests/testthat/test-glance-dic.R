context("test-glance-dic")

library(rjags)
model_dic <- dic.samples(example_jags_model, n.iter = 1000)
glance_model_dic <- glance(model_dic)

test_that("glance.dic returns a dataframe and a data.table", {
    expect_is(glance_model_dic, "data.frame")
    expect_is(glance_model_dic, "data.table")
})

test_that("glance.dic has the right names", {
    expect_equal(names(glance_model_dic),
                 c("type",
                   "deviance",
                   "penalty",
                   "deviance_penalised"))
})

test_that("glance.dic has the right dimensions", {
    expect_equal(nrow(glance_model_dic), 1)
    expect_equal(ncol(glance_model_dic), 4)
})
