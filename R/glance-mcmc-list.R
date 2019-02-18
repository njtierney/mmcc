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
    
    n_chains <- n_chain(x)
    
    if (n_chains > 1){
        mcpar <- attr(x[[1]], "mcpar")
    } else {
        mcpar <- attr(x, "mcpar")
    }
    
    
    # calculate chain length
    
    data.frame(
        n_chains = n_chains,
        n_iter = n_iter(x),
        n_var = n_var(x),
        n_thin = mcpar[3],
        iter_lower = mcpar[1],
        iter_upper = mcpar[2],
        ess_lower,
        ess_upper,
        rhat_lower,
        rhat_upper
    )
}
