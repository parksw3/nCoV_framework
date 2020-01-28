library(MCMCpack)
load("sample_data.rda")

nsample <- 100000

priorfun <- function(theta) {
  sum(dgamma(theta, 0.1, 0.1, log=TRUE))
}

postfun <- function(theta) {
  mean_r <- theta[1]
  shape_r <- theta[2]
  rate_r <- shape_r/mean_r
  
  mean_gbar <- theta[3]
  shape_gbar <- theta[4]
  rate_gbar <- shape_gbar/mean_gbar
  
  rate_kappa <- 1/theta[5]
  
  ss <- sample(nsample, 1)
  
  r <- sapply(sample_data, function(x) x$r[ss])
  gbar <- sapply(sample_data, function(x) x$gbar[ss])
  kappa <- sapply(sample_data, function(x) x$kappa[ss])
  
  ll <- sum(dgamma(r, shape=shape_r, rate=rate_r, log=TRUE)) +
    sum(dgamma(gbar, shape=shape_gbar, rate=rate_gbar, log=TRUE)) +
    sum(dexp(kappa, rate=rate_kappa, log=TRUE)) +
    priorfun(theta)
  
  if (is.na(ll) || is.nan(ll)) {
    return(-Inf)
  }
  
  ll
}

V <- matrix(0, 5, 5)
diag(V) <- c(5e-3, 40, 0.5, 50, 0.03)

reslist <- vector('list', 4)

for (i in 1:4) {
  reslist[[i]] <- MCMCmetrop1R(postfun,
                               theta.init=c(0.2, 10, 8, 70, 0.2),
                               thin=200,
                               burnin=100000,
                               mcmc=100000,
                               verbose=50000,
                               seed=i,
                               V=V)
}

MCMC_all <- as.mcmc.list(reslist)

save("MCMC_all", file="MCMC_all.rda")
