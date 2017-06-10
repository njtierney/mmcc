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


