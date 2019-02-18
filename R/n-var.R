#' @export
#' @rdname mcmc-dims
n_var <- function(x){
    UseMethod("n_var")
}

#' @export
n_var.default <- function(x){
    stop_not_right_for_mmcc()
}

#' @export
n_var.mcmc <- function(x){
    if (is.matrix(x)) {
        return(ncol(x))
    } else {
        return(1)
    }
}

#' @export
n_var.mcmc.list <- function(x){
    if (is.matrix(x[[1]])) {
        return(ncol(x[[1]]))
    } else {
        return(1)
    }
}

#' @export
n_var.NULL <- function(x){
    NULL
}

#' @export
n_var.data.table <- function(x){
    dplyr::n_distinct(x$parameter)
}

#' @export
n_var.stanfit <- function(x){
    # note - is "lp__" a parameter we care about?
    # what about y[1] and y[2]?
    length(x@model_pars)
}

#' @export
n_var.jags <- function(x){
    x$state() %>%
        purrr::pluck(1) %>%
        length()
}
