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
#' @param conf_level level of the credible interval to be calculated.
#'   Can be multiple values.
#' @param chain whether or not to summarise each parameter for each chain
#' @param colnames which parameters we want from `mcmc_object`, if `NULL` then all
#'   columns get selected
#' @param ... extra arguments
#'
#' @author Sam Clifford, \email{sj.clifford@@gmail.com}
#'
#' @import data.table
#'
#' @return a data.table containing parameter summaries
#'
#' @export
#'
#' @examples
#' library(coda)
#' data(line)
#' tidy(line)
#' # Optionally ask for a subset of parameters with a vector of `colnames`,
#' # and summarise for each chain:
#' tidy(line,
#'      chain = TRUE,
#'      colnames=c("alpha"))
#' # can provide two levels of confidence:
#' tidy(line, conf_level = c(0.95, 0.50))
#' tidy(line, conf_level = c(0.95))
#' tidy(line, conf_level = c(0.89, 0.25))
tidy.mcmc.list <- function(x,
                           conf_level = c(0.95),
                           chain = FALSE,
                           colnames = NULL,
                           ...){

    if (any(conf_level >= 1)) {
        stop("Confidence level needs to be below 1, it is", conf_level)
    }

    # set credible interval quantiles to use

    q <- c((1 - conf_level)/2,
           1 - (1 - conf_level)/2)
    q <- sort(q)

    # convert from mcmc.list to data.table
    x_dt <- mcmc_to_dt(x, colnames = colnames)


    my_by <- "parameter"

    if (chain){
        my_by <- c(my_by, "chain")
    }

    if (length(conf_level) > 2 ) {
        stop("conf_level is ",
             conf_level,
             " it must either be length 1 or 2 and it is length",
             length(conf_level)
             )
    }

    if (length(conf_level) == 2) {

    x_dt_s <- x_dt[ , list(mean = mean(value),
                           sd = stats::sd(value),
                           q1 = stats::quantile(value, q[1]),
                           q2 = stats::quantile(value, q[2]),
                           median = stats::median(value),
                           q3 = stats::quantile(value, q[3]),
                           q4 = stats::quantile(value, q[4])),
                    by = my_by]

    data.table::setnames(x_dt_s,
                         old = c("q1", "q2", "q3", "q4"),
                         new = sprintf("%2.1f%%", q * 100))
    return(x_dt_s)

    } else if (length(conf_level) == 1) {
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
}

