#' Return a tidy data summary of an MCMC object
#'
#' `tidy.mcmc.list` is a function that behaves like those from `broom`. It takes
#'   an mcmc.list object from `coda.samples` and return a data frame that
#'   summarises each parameters with its mean and quantiles and returns the output
#'   as a data.table object. This can be called as `tidy`. Currently summarises
#'   over all chains.
#'
#' @param x object of class "mcmc.list", as you would find with fitting a model
#'   using `jags.model()`, and `coda.samples`.
#' @param conf_level level of the credible interval to be calculuated
#' @param chain whether or not to summarise each parameter for each chain
#' @param colnames which parameters we want from `mcmc_object`, if `NULL` then all
#'   columns get selected
#' @param ... extra arguments
#'
#' @author Sam Clifford, \email{sj.clifford@@gmail.com}
#'
#' @import data.table
#' @importFrom broom tidy
#'
#' @return a data.table containing parameter summaries
#'
#' @export
#'
tidy.mcmc.list <- function(x,
                           conf_level = 0.95,
                           chain = FALSE,
                           colnames = NULL,
                           ...){

    # set credible interval quantiles to use
    q <- c((1 - conf_level)/2,
           1 - (1 - conf_level)/2)

    # convert from mcmc.list to data.table
    x_dt <- mcmc_to_dt(x, colnames = colnames)


    my_by <- "parameter"

    if (chain){
        my_by <- c(my_by, "chain")
    }

    x_dt_s <- x_dt[ , list(mean = mean(value),
                           sd = stats::sd(value),
                           q1 = stats::quantile(value, q[1]),
                           median = stats::median(value),
                           q2 = stats::quantile(value, q[2])),
                    by = my_by]

    data.table::setnames(x_dt_s,
                         old = c("q1", "q2"),
                         new = sprintf("%2.1f%%", q * 100))

    return(x_dt_s)
}

