#' Example JAGS Model
#'
#' This is an example JAGS model to use for examples in the `mmcc` package. The
#'     model is fit as a basic linear regression, with uniform priors on beta0
#'     and beta1, where y is assumed to be normal, with mean mu and precision
#'     tau. The model is drawn from the vignette, "Model summaries for a
#'     Bayesian linear regression", and the code to generate it can be found in
#'     the `data-raw` folder.
#' @name example_jags_model
#' @docType data
#' @usage data(example_jags_model)
#' @keywords data
#' @examples
#'
#' glance(example_jags_model)
"example_jags_model"
