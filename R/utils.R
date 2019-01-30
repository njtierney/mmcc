#' @importFrom magrittr %>%
NULL

#' @importFrom generics tidy
#' @export
generics::tidy

#' @importFrom generics glance
#' @export
generics::glance

#' @importFrom graphics plot
#' @importFrom stats acf ts.plot

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(
    c("type",
      "deviance.penalised",
      "penalty",
      "deviance",
      "parameter",
      "chain",
      "iteration",
      "chain",
      "iteration",
      "iteration",
      "value")
)
