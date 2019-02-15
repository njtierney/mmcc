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
    
    if (inherits(x, "mcmc.list")) {
        x_dt <- mcmc_to_dt(x)
    }
    
    rhat <- coda::gelman.diag(x, ...)

    rhat_range <- range(rhat$psrf[ , 1])
    rhat_lower <- rhat_range[1]
    rhat_upper <- rhat_range[2]

    ess <- diag_ess(x_dt, ... )
    ess_range <- range(ess$ess)
    ess_lower <- ess_range[1]
    ess_upper <- ess_range[2]

    mcpar <- attr(x, "mcpar")
    
    # calculate chain length
    
    data.frame(
        n_chains = n_chain(x),
        n_iter = coda::niter(x),
        n_var = n_var(x),
        n_thin = attribute(x, "mcpar")
        iter_lower = min(x_dt$iteration),
        iter_upper = max(x_dt$iteration),
        ess_lower,
        ess_upper,
        rhat_lower,
        rhat_upper
    )
}
