library(coda)
data(line)

set.seed(4000)
N <- 20
x <- sort(runif(n = N))
y <- rnorm(n = N,
           mean = 2*x + 1,
           sd = 0.25)
dat <- data.frame(x = x, y = y)

# Then, we simulate some values for predicting
M <- 10
x_pred <- seq(from = min(x),
              to = max(x),
              length.out = M)

# Next, we fit the model, specified as
jags_model <-
    "model{
    # model block
    for (i in 1:n){
        y[i] ~ dnorm(mu[i], tau_y)
        mu[i] <- beta_0 + beta_1*x[i]
    }

    # prediction block
    for (i in 1:m){
        y_pred[i] ~ dnorm(mu_pred[i], tau_y)
        mu_pred[i] <- beta_0 + beta_1*x_pred[i]
    }

    # priors
    beta_0 ~ dunif(-1e12, 1e12)
    beta_1 ~ dunif(-1e12, 1e12)
    tau_y <- exp(2*log_sigma)
    log_sigma ~ dunif(-1e12, 1e12)
}"

library(rjags)
example_jags_model <- jags.model(file = textConnection(jags_model),
                                 data = list(n = N,
                                x = x,
                                y = y,
                                m = M,
                                x_pred = x_pred),
                    n.chains = 3)

usethis::use_data(example_jags_model)
