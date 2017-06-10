

#' tidy.mcmc.list
#'
#' Return a tidy data summary of an MCMC object
#'
#' @description A function that behaves like those from "broom", tidy.mcmc.list will take an mcmc.list object from coda.samples and return a data frame that summarises each parameters with its mean and quantiles and returns the output as a data.table object. This can be called as `tidy`. Currently summarises over all chains.
#'
#' @param mcmc_object an object of class "mcmc.list", as you would find with fitting a model using `jags.model()`, and `coda.samples`
#'
#' @param conf.level level of the credible interval to be calculuated
#' @param chain whether or not to summarise each parameter for each chain
#' @param colnames which parameters we want from `mcmc_object`, if `NULL` then all columns get selected
#'
#' @author Sam Clifford, \email{samuel.clifford@@qut.edu.au}
#'
#' @importFrom stats quantile
#' @importFrom stats sd
#' @importFrom stats median
#' @importFrom data.table data.table
#'
#' @return a data.table containing parameter summaries
#'
#' @export
#'

tidy.mcmc.list <- function (mcmc_object,
                            conf.level = 0.95,
                            chain=FALSE,
                            colnames=NULL){

    # set credible interval quantiles to use
    q <- c((1 - conf.level)/2, 1 - (1 - conf.level)/2)

    # convert from mcmc.list to data.table
    x.dt <- mcmc_to_dt(mcmc_object, colnames=colnames)

    my.by <- "parameter"

    if (chain){
        my.by <- c(my.by, "chain")
    }

    x.dt.s <- x.dt[, list(Mean = mean(value),
                          SD = sd(value),
                          q1 = quantile(value, q[1]),
                          Median = median(value),
                          q2 = quantile(value, q[2])),
                   by = my.by]

    data.table::setnames(x.dt.s, old = c("q1", "q2"),
                         new = sprintf("%2.1f%%", q * 100))

    return(x.dt.s)
}

