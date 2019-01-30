#' @importFrom magrittr %>%
NULL

#' @importFrom generics tidy
#' @export
generics::tidy

#' @importFrom generics glance
#' @export
generics::glance

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
