#' @export
#' @rdname mcmc-dims
n_iter <- function(x){
    UseMethod("n_iter")
}

#' @export
n_iter.default <- function(x){
    stop_not_right_for_mmcc()
}

#' @export
n_iter.mcmc <- function(x){
    if (is.matrix(x)) {
        nrow(x)
    } else {
        length(x)
    }
}

#' @export
n_iter.mcmc.list <- function(x){
    if (is.matrix(x[[1]])) {
        nrow(x[[1]])
    } else {
        length(x[[1]])
    }
}

#' @export
n_iter.NULL <- function(x){
    NULL
}

n_iter.data.table <- function(x){
    max(x$iteration)
}

n_iter.stanfit <- function(x){
    x@sim$iter
}

n_iter.jags <- function(x){
    x$iter()
}
