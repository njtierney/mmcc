#' MCMC tidiers (draft) for STAN
#'
#' @param stan_model a stan model
#'
#' @return a tidy dataframe
#' @export
#'
#' @examples
#'  mcmc_to_dt_stan(example_stan_model)
#'
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
