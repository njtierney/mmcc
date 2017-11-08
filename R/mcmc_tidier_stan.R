#' MCMC tidiers (draft) for STAN
#'
#' @param stan_model a stan model
#'
#' @return a tidy dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' #### example 1
#' library(rstan)
#' scode <- "
#' parameters {
#' real y[2];
#' }
#' model {
#' y[1] ~ normal(0, 1);
#' y[2] ~ double_exponential(0, 2);
#' }
#' "
#' fit1 <- stan(model_code = scode, iter = 10, verbose = FALSE)
#'  mcmc_to_dt_stan(fit1)
#'  }


#'
mcmc_to_dt_stan <- function(stan_model){

    samples_data <- purrr::map(stan_model@sim$samples, as.data.frame)

    n_chain <- stan_model@sim$chains
    n_iter <- stan_model@sim$iter

    tidy_fit_stan <- samples_data %>%
        dplyr::bind_rows() %>%
        tibble::as_tibble() %>%
        dplyr::mutate(chain = rep(1:n_chain, each = n_iter),
                      iteration = rep(1:n_iter, 4)) %>%
        tidyr::gather(key = "variable",
                      value = "value",
                      -chain,
                      -iteration)
    tidy_fit_stan

}
