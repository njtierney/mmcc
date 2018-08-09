#' Glance upon your mcmclist to get summary information
#'
#' This provides a one-row dataframe with information on number of chains, the
#'     number of variables, the number of iterations, and the lower and upper
#'     values for effective sample size (ess), and rhat.
#'
#' @param x an mcmc.list object
#' @param ... (optional) additional arguments to pass
#'
#' @return a one-row dataframe of summary information of the mcmc model
#' @export
#'
#' @examples
#'
#' library(coda)
#' data(line)
#' glance(line)
#'
glance.mcmc.list <- function(x, ...){
    rhat <- coda::gelman.diag(x, ...)

    rhat_range <- range(rhat$psrf[ , 1])
    rhat_lower <- rhat_range[1]
    rhat_upper <- rhat_range[2]

    ess <- coda::effectiveSize(x)
    ess_range <- range(ess)
    ess_lower <- ess_range[1]
    ess_upper <- ess_range[2]

    data.frame(
        n_chains = coda::nchain(x),
        n_iter = coda::niter(x),
        n_var = coda::nvar(x),
        ess_lower,
        ess_upper,
        rhat_lower,
        rhat_upper
    )
}
