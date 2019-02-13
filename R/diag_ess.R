#' Diagnostic: Calculate the effective sample size for each chain and parameter
#'
#'
#' @param x mcmc.list object or dataframe creatd by `mcmc_to_dt`
#'
#' @return a data.table data frame with the effective sample size for each chain and parameter
#' 
#' @export
#'
#' @examples
#' library(coda)
#' data(line)
#' line_ess <- diag_ess(line)
#' line_ess

diag_ess <- function(x){
    
    if (inherits(x, "mcmc.list")) {
        x <- mcmc_to_dt(x)
    }
    
    x_ess <- x[ , .(ess = make_ess(value)) , by = list(chain, parameter)]

    data.table::setcolorder(x_ess, c("chain",
                                    "parameter",
                                    "ess"))
    
    x_ess
    
}

make_ess <- function(x){
    spec <- stats::spectrum(x = x,
                            method = "ar",
                            plot = FALSE)$spec[1]
    ans <- ifelse(spec == 0, 
                  0, 
                  length(x) * stats::var(x)/spec)
    return(ans)
}
