
<!-- README.md is generated from README.Rmd. Please edit that file -->
dsmcmc
======

**License:** [MIT](https://opensource.org/licenses/MIT)

ds mcmc provides custom functions written in data.table for tidying up mcmc.list objects.

At this stage there is just one function `tidy_mcmc` that does the data and puts the data into the format

|  iteration|  chain| parameter  |       value|
|----------:|------:|:-----------|-----------:|
|          1|      1| alpha\[1\] |    1.700768|
|          2|      1| alpha\[1\] |    8.033261|
|          3|      1| alpha\[1\] |  -12.140878|
|          4|      1| alpha\[1\] |   -3.977267|
|          5|      1| alpha\[1\] |   -3.884905|
|          6|      1| alpha\[1\] |  -10.399122|

...

|  iteration|  chain| parameter    |       value|
|----------:|------:|:-------------|-----------:|
|        495|      3| y\_pred\[1\] |    1.700768|
|        496|      3| y\_pred\[1\] |    8.033261|
|        497|      3| y\_pred\[1\] |  -12.140878|
|        498|      3| y\_pred\[1\] |   -3.977267|
|        499|      3| y\_pred\[1\] |   -3.884905|
|        500|      3| y\_pred\[1\] |  -10.399122|

Install
=======

install from github using:

``` r
# install.packages("devtools")
devtools::install_github("njtierneydsmcmc")
```

Why dsmcmc?
===========

Full credit does to [Sam Clifford](https://samclifford.info/) for the name.

To lift directly from [wikipedia](https://en.wikipedia.org/wiki/Dal_Segno):

> In music, D.S. al coda instructs the musician to go back to the sign, and when Al coda or To coda is reached jump to the coda symbol.

This package works with `coda.samples`, where it tidies the data, for each chain. This repetitive action of cleaning and repeating for each chain is where the inspiration from the name comes from.

Additionally, it has several backronyms:

-   data science mcmc
-   descriptive statistics mcmc

and so on.

Future work
===========

-   Create summaries for each parameter
-   Perform diagnostic summaries for convergence
-   provide a suite of plotting in plotly, for speed, and interactivity.

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
