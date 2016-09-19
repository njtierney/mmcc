#' mcmc_to_dt
#'
#' use data.table to return a tidy dataframe from an "mcmc.list" object
#'
#' @param mcmc_object an object of class "mcmc.list", as you would find with fitting a model using `jags.model()`, and `coda.samples`
#'
#' @return a data.table dataframe
#' @export
#'
  mcmc_to_dt <- function(mcmc_object){

  # how many chains?
  n_chain <- length(mcmc_object)

  # make a box to put the results in
  dt_box <- vector("list", n_chain)

  for (c in 1:n_chain) {

      # get the mcmc object
      mcmc_chain_c <- mcmc_object[c][[1]]

      # how many iterations?
      iterations <- 1:dim(mcmc_chain_c)[1]

      mcmc_dt <- data.table::data.table(Iteration = iterations,
                                        as.matrix(unclass(mcmc_chain_c)),
                                        check.names = FALSE,
                            # specify a new column for the chain number
                                        chain = c)

      # gather the columns so we end up with a column of
      dt_melt <- data.table::melt.data.table(data = mcmc_dt,
                                             id.vars = c("Iteration",
                                                         "chain"))

      # head(dt_melt)

      # reset the names
      data.table::setnames(dt_melt, c("iteration",
                                      "chain",
                                      "parameter",
                                      "value"))

      # head(dt_melt)

      # change the order of the columns
      data.table::setcolorder(dt_melt, c("iteration",
                                         "chain",
                                         "parameter",
                                         "value"))

      # arrange the row order
      data.table::setorder(dt_melt,
                           parameter,
                           chain,
                           iteration)

      # head(dt_melt)

      dt_box[[c]] <- dt_melt

  } # end loop

  # bind the loop together
  dt_mcmc <- data.table::rbindlist(dt_box)

  # return it
  return(dt_mcmc)

}
