#' Diagnostic: Calculate the effective sample size for each chain and parameter
#'
#'
#' @param x mcmc.list object or dataframe creatd by `mcmc_to_dt`
#' @param aggregate_chains a logical indicating whether to aggregate chains (the way `coda::effectSize` does, the default) or report effective sample sizes for each parameter for each chain
#'
#' @return a data.table data frame with the effective sample size for each parameter and, optionally, chain
#' 
#' @export
#'
#' @examples
#' library(coda)
#' data(line)
#' line_ess <- diag_ess(line)
#' line_ess
#' coda::effectiveSize(line)

diag_ess <- function(x, aggregate_chains = TRUE){
    
    if (inherits(x, "mcmc.list")) {
        x <- mcmc_to_dt(x)
    }
    
    my_by <- "parameter"
    
    if (!aggregate_chains){
        my_by <- c("chain", my_by)
    } 
    
    x_ess <- x[ , .(ess = make_ess(value)) ,
                by = list(chain, parameter)]

    if (aggregate_chains){
        x_ess <- x_ess[ , .(ess = sum(ess)) , by = parameter ]
    } 
    
    data.table::setcolorder(x_ess, c(my_by, "ess"))
    
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
