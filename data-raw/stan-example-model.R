# create example stan model to use with package

library(rstan)
scode <- "
parameters {
real y[2];
}
model {
y[1] ~ normal(0, 1);
y[2] ~ double_exponential(0, 2);
}
"
example_stan_model <- stan(model_code = scode, iter = 10, verbose = FALSE)

use_data(example_stan_model)
