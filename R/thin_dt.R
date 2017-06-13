#' thin_dt
#'
#' post-hoc thinning of MCMC chains which have been converted to a data.table
#'
#' @param dt an object of class "data.table" returned from `mcmc_to_dt`
#' @param thin thinning interval
#'
#' @return a data.table dataframe
#' @export
#'
mcmc_to_dt <- function(dt, thin=1){

    dt_thinned <- dt[ , iteration %% thin == 1 ]

    # return it
    return(dt_thinned)

}

