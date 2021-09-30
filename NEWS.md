# mmcc 0.0.9.9000 (2021/09/30)

## New Features 

* Implement dimension amounts for `n_var`, `n_iter` and `n_chain` #33
* Implement `n_sims` - #50

# mmcc 0.0.8.9600 (2019/02/13)

## New Features

* Implemented effective sample size diagnostic, `diag_ess`, (#34) which does not aggregate over chains

# mmcc 0.0.8.9500 (2019/02/13)

## Minor Changes

* Minor speed-ups (1.5x) in `diag_autocorr` gained by pulling the two `lapply` calls together and separating the chain and parameter values from the id column simultaneously.

# mmcc 0.0.8.9400 (2019/02/01)

## New Features

* added Sam's `diag_autocorr` function to calculate autocorrelation.
* `mcmc_to_dt` is now and S3 method, removing `mcmc_to_dt_stan()`, it just works on stan models now. And `mcmc_to_dt.stan()` is about 5 times faster.

## Minor Changes

* added `example_jags_model` as an example data set to use in package
* added `example_stan_model` as an example data set to use in package
* added tests for `thin_dt()` and `glance.dic()`

# mmcc 0.0.8.9200 (2019/01/30)

## New Features

- Add Haran et al's batch means function to diagnostics (#25)

## Minor Changes

- Updated to use generics instead of importing broom
- Removed greta vignette as the python/tensorflow build problems were stopping he package from building properly
- added test coverage

mmcc 0.0.7.9000 (2018/08/03)
=========================

## New Features

- Added `greta` vignette
- Added examples to the thin_dt, glance.mcmc.list, and other functions.

mmcc 0.0.6.9100 (2017/11/08)
=========================

## New Features

- added draft function for stan - mcmc_to_dt_stan, for cleaning up output from STAN.

mmcc 0.0.6.9001 (2017/06/13)
=========================

## Minor Changes

- changes name to `mmcc`

dsmcmc 0.0.5.9001 (2017/06/13)
=========================

## Minor Changes

- changes name to `mmcc`
- added `thin_dt`, to allow post hoc thinning of chains
- updated linear model vignette to show off `thin_dt` with trace plots

dsmcmc 0.0.5.9000 (2017/06/12)
=========================

## Minor Changes

- Changes `tidy` summaries to be lowercase.
- Added `broom` to Depends to make `tidy.mcmc.list` to work with `tidy`, since `@importFrom broom tidy` didn't really seem to work, and I want to be able to just call `tidy`.
- no longer import from stats
- Updated vignette to use `tidy` instead of `tidy.mcmc.list`
- Vignette and README style changes in line with tidyverse style.
  - Use `snake_case` where possible.
  - Added more whitespace to functions.

dsmcmc 0.0.4 (2017/06/10)
=========================

## New Features

- New vignette showing linear regression
- Suggests now includes `rjags` and `ggplot2` for vignette
- Column selection now uses regular expression matching so that matching on variables from array allows `beta` to extract `beta[1,1]`, `beta[1,2]`, etc. but not `beta.0`.

dsmcmc 0.0.3 (2017/06/10)
=========================

## New Features

- Summary of `mcmc.list` now done with a `tidy` method
- Can now select which columns are to be tidied/summarised
- `mcmc_to_dt` can be requested to summarise over all chains or by each chain.

dsmcmc 0.0.1 (2016/09/19)
=========================

## New features
- Added `tidy_mcmc` to tidy up `mcmc.list` objects
- Added a `NEWS.md` file to track changes to the package.


