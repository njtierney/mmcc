#' @title Return the number of simulations
#' @param x mcmc list
#' @return integer of number of simulations
#' @author Nicholas Tierney
#' @export
n_sims <- function(x) {
    n_chains <- n_chain(x)
    n_iterations <- n_iter(x)

    n_sims <- n_chains * n_iterations

    n_sims
}
