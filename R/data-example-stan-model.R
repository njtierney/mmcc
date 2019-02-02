#' Example STAN Model
#'
#' This is an example STAN model to use for examples in the `mmcc` package. It
#'     was created with the example code given below in examples.
#'
#' @name example_stan_model
#' @docType data
#' @usage data(example_stan_model)
#' @keywords data
#' @examples
#' \dontrun{
#'     library(rstan)
#'     scode <- "
#'     parameters {
#'     real y[2];
#'     }
#'     model {
#'     y[1] ~ normal(0, 1);
#'     y[2] ~ double_exponential(0, 2);
#'     }
#'     "
#'     example_stan_model <- stan(model_code = scode,
#'                                iter = 10,
#'                                verbose = FALSE)
#' }
#'
#' mcmc_to_dt(example_stan_model)
"example_stan_model"
