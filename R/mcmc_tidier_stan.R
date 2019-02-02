#' MCMC tidiers (draft) for STAN
#'
#' @inheritParams mcmc_to_dt
#'
#' @export
#'
#' @examples
#'  mcmc_to_dt(example_stan_model)
#'
mcmc_to_dt.stanfit <- function(mcmc_object, ...){

    samples_data <- purrr::map(mcmc_object@sim$samples, as.data.frame)

    n_chain <- mcmc_object@sim$chains
    n_iter <- mcmc_object@sim$iter

    # convert to data.table
    tidy_fit_stan <- samples_data %>%
        dplyr::bind_rows() %>%
        tibble::as_tibble() %>%
        dplyr::mutate(chain = rep(1:n_chain, each = n_iter),
                      iteration = rep(1:n_iter, 4)) %>%
        tidyr::gather(key = "parameter",
                      value = "value",
                      -chain,
                      -iteration) %>%
        dplyr::select(iteration,
                      chain,
                      parameter,
                      value)
    tidy_fit_stan

}
