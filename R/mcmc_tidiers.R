#' Convert `mcmc.list` to a tidy data.table object
#'
#' `mcmc_to_dt` use data.table to return a tidy dataframe from an "mcmc.list",
#'  or "stan" object.
#'
#' @param mcmc_object an object of class "mcmc.list", as you would find with
#'   fitting a model using `jags.model()`, and `coda.samples`, or "stan", from
#'   fitting a stan model.
#'
#' @param ... additional arguments
#'
#' @return a tidy data.table dataframe of MCMC sample
#' @export
mcmc_to_dt <- function(mcmc_object, ...){
  UseMethod("mcmc_to_dt")
}

#' Convert `mcmc.list` to a tidy data.table object
#'
#' `mcmc_to_dt` use data.table to return a tidy dataframe from an "mcmc.list",
#'  or "stan" object.
#'
#' @inheritParams mcmc_to_dt
#'
#' @param colnames which parameters we want from `mcmc_object`, if `NULL` then all
#'   columns get selected
#'
#' @examples
#' library(coda)
#' data(line)
#' mcmc_to_dt(line)
#'
#' @export
mcmc_to_dt.mcmc.list <- function(mcmc_object, ..., colnames = NULL){

  # how many chains?
  n_chain <- n_chain(mcmc_object)

  # which parameters are we summarising?
  data_colnames <- attr(mcmc_object[1][[1]], "dimnames")[[2]]

  mcpar <- attr(mcmc_object[[1]], "mcpar")
  iterations <- seq(mcpar[1], mcpar[2], by = mcpar[3])
  
  get_colnames <- function(x){
      grep(pattern = paste("^", x ,"($|\\[)", sep=""),
           x = data_colnames, # always executed within this environment
           value = T)
  }

  if (is.null(colnames)){
      colnames <- data_colnames
  } else {
      colnames <-
          as.character(
              unlist(
                  sapply(X = colnames,
                         FUN = get_colnames)))
  }

  # make a box to put the results in
  dt_box <- vector("list", n_chain)

  for (c in 1:n_chain) {

    # get the mcmc object
    mcmc_chain_c <- as.matrix(mcmc_object[c][[1]][,colnames])
    colnames(mcmc_chain_c) <- colnames

    # how many iterations?
    

    mcmc_dt <- data.table::data.table(
        Iteration = iterations,
        as.matrix(unclass(mcmc_chain_c)),
        check.names = FALSE,
        # specify a new column for the chain number
        chain = c)

    # gather the columns so we end up with a column of
    dt_melt <- data.table::melt.data.table(
        data = mcmc_dt,
        id.vars = c("Iteration",
                    "chain"))

    

    dt_box[[c]] <- dt_melt

  } # end loop

  # bind the loop together
  dt_mcmc <- data.table::rbindlist(dt_box)
  
  # reset the names
  data.table::setnames(dt_mcmc, c("iteration",
                                  "chain",
                                  "parameter",
                                  "value"))
  
  # set the order of the columns
  data.table::setcolorder(dt_mcmc, c("iteration",
                                     "chain",
                                     "parameter",
                                     "value"))
  
  # arrange the row order
  data.table::setorder(dt_mcmc,
                       parameter,
                       chain,
                       iteration)

  # return it
  return(dt_mcmc)

}

