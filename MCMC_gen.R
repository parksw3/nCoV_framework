library(MCMCpack)
load("sample_data.rda")

rpar <- sapply(sample_data, function(x) {
  mm <- mean(x$r)
  shape <- mm^2/var(x$r)
  rate <- shape/mm
  
  c(shape=shape, rate=rate, mm=mm)
})

priorfun <- function(theta) {
  
  
  sum(dgamma(theta[1:nstudy], shape=rpar[1,], rate=rpar[2,], log=TRUE)) +
    dgamma(theta[nstudy+1], 0.1, 0.1, log=TRUE) +
    dgamma(theta[nstudy+2], 0.1, 0.1, log=TRUE)
}

postfun <- function(theta,
                    nstudy=6) {
  mean <- theta[nstudy+1]
  shape <- theta[nstudy+2]
  rate <- shape/mean
  
  ll <- sum(dgamma(theta[1:nstudy], shape=shape, rate=rate, log=TRUE)) +
    priorfun(theta, nstudy=nstudy)
  
  if (is.na(ll) || is.nan(ll)) {
    return(-Inf)
  }  
  
  ll
}

reslist <- vector('list', 4)

for (i in 1:4) {
  reslist[[i]] <- MCMCmetrop1R(postfun,
                               theta.init=c(rpar[3,], mean(rpar[3,]), 10),
                               thin=200,
                               burnin=40000,
                               mcmc=40000,
                               verbose=20000,
                               seed=i)
  
}

MCMC_r <- as.mcmc.list(reslist)

save("MCMC_r", file="MCMC_r.rda")
