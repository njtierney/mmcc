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

    samples_data <- data.table::rbindlist(mcmc_object@sim$samples)

    n_chain <- mcmc_object@sim$chains

    n_iter <- mcmc_object@sim$iter

    tidy_fit_dt <-
        data.table::data.table(
            samples_data, # drop lp__
            iteration = rep(1:n_iter, 4),
            chain = rep(1:n_chain, each = n_iter)
        )

    dt_melt <- data.table::melt.data.table(
        data = tidy_fit_dt,
        id.vars = c("iteration",
                    "chain"))

    data.table::setnames(dt_melt, c("iteration",
                                    "chain",
                                    "parameter",
                                    "value"))

    # change the order of the columns
    data.table::setcolorder(dt_melt, c("iteration",
                                       "chain",
                                       "parameter",
                                       "value"))

    # arrange the row order
    data.table::setorder(dt_melt,
                         parameter,
                         chain,
                         iteration)


    dt_melt



}
