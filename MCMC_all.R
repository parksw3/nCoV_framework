library(MCMCpack)
load("sample_data.rda")

nsample <- 100000

priorfun <- function(theta) {
  sum(dnorm(theta[-c(1, 3, 5)], 0, 10, log=TRUE)) +
    dgamma(theta[1], 2, 2*7, log=TRUE) +
    dgamma(theta[3], 2, 2/7, log=TRUE) +
    dgamma(theta[5], 2, 2/0.5, log=TRUE)
}

sample_data$`Majumder et al. (2020)`$kappa <- 0.02

postfun <- function(theta) {
  if (any(theta < 0))
    return(-Inf)
  
  ## theta[2], theta[4], theta[6] are sd
  mean_r <- theta[1]
  shape_r <- mean_r^2/theta[2]^2
  rate_r <- shape_r/mean_r
  
  mean_gbar <- theta[3]
  shape_gbar <- mean_gbar^2/theta[4]^2
  rate_gbar <- shape_gbar/mean_gbar
  
  mean_kappa <- theta[5]
  shape_kappa <- mean_kappa^2/theta[6]^2
  rate_kappa <- shape_kappa/mean_kappa
  
  ss <- sample(nsample, 1)
  
  r <- sapply(sample_data, function(x) x$r[ss])
  gbar <- sapply(sample_data, function(x) x$gbar[ss])
  kappa <- sapply(sample_data, function(x) x$kappa[ss])
  
  ll <- sum(dgamma(r, shape=shape_r, rate=rate_r, log=TRUE)) +
    sum(dgamma(gbar, shape=shape_gbar, rate=rate_gbar, log=TRUE)) +
    sum(dgamma(kappa, shape=shape_kappa, rate=rate_kappa, log=TRUE)) +
    priorfun(theta)
  
  if (is.na(ll) || is.nan(ll)) {
    return(-Inf)
  }
  
  ll
}

V <- matrix(0, 6, 6)
diag(V) <- c(2e-3, 0.004, 0.3, 0.3, 0.1, 0.1)/10

reslist <- vector('list', 4)

for (i in 1:4) {
  reslist[[i]] <- MCMCmetrop1R(postfun,
                               theta.init=c(0.2, 0.1, 8, 1, 0.5, 0.5),
                               thin=1000,
                               burnin=500000,
                               mcmc=500000,
                               verbose=100000,
                               seed=i,
                               V=V)
}

MCMC_all <- as.mcmc.list(reslist)

save("MCMC_all", file="MCMC_all.rda")
