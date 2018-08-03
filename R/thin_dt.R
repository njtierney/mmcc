#' thin_dt
#'
#' post-hoc thinning of MCMC chains which have been converted to a data.table
#'
#' @param dt an object of class "data.table" returned from `mcmc_to_dt`
#' @param thin thinning interval
#'
#' @return a data.table dataframe
#' @export
#' @examples
#' library(coda)
#' data(line)
#' mcmc_dt <- mcmc_to_dt(line)
#' thin_dt(mcmc_dt, thin = 10)
#' thin_dt(mcmc_dt, thin = 2)
#' thin_dt(mcmc_dt, thin = 20)
thin_dt <- function(dt, thin=1){

    dt_thinned <- dt[  iteration %% thin == 1 , ]

    # return it
    return(dt_thinned)

}

