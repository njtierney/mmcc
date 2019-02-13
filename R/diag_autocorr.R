#' Diagnostic: Calculate the autocorrelation for each chain and parameter
#'
#'
#' @param x mcmc.list object or dataframe creatd by `mcmc_to_dt`
#' @param lags integer the lag value that you want to use
#'
#' @return a data.table data frame with the autocorrelation at each lag for each chain and parameter columns `lag`, `acf`, `chain`, and `parameter`
#' @export
#'
#' @examples
#' library(coda)
#' data(line)
#' line_acf <- diag_autocorr(line)
#' line_acf
diag_autocorr <- function(x, lags = NULL){
    
    if (inherits(x, "mcmc.list")) {
        x <- mcmc_to_dt(x)
    }
    
    max_iter <- max(x$iteration)
    
    if (is.null(lags)) {
        
        lag_max <- ceiling(10*log10(max_iter))
        lag_max <- min(lag_max, max_iter - 1)
        lags <- 0:lag_max
        
    } else {
        
        lag_max <- max(lags)
        lag_max <- min(lag_max, max_iter - 1)
        
    }
    
    x_split <- data.table:::split.data.table(x,
                                             list(x$chain,
                                                  x$parameter))
    x_acf <- lapply(x_split,
                    FUN = function(x){
                        with(acf(x$value,
                                 lag.max = lag_max,
                                 plot = FALSE),
                             data.frame(lag = lag,
                                        acf = acf))
                    })
    
    x_df <- data.table::rbindlist(x_acf,
                                  idcol = "id")
    
    x_df <- x_df[lag %in% lags, ]
    
    x_df[ , `:=` (chain =
                      as.numeric(
                          regmatches(id, 
                                     regexpr(pattern = "^[0-9]+",
                                             text =  id))),
                  parameter =  gsub(pattern = "^[0-9]\\.",
                                    replacement = "", 
                                    x = id),
                  id = NULL), ]
    
    
    data.table::setcolorder(x_df, c("chain",
                                    "parameter",
                                    "lag",
                                    "acf"))
    
    x_df
    
}
