library(coda)
library(dplyr)

load("sample_data.rda")
load("MCMC_all_kappa_01.rda")

r <- unlist(unlist(MCMC_all_kappa_01[,1]))
gbar <- unlist(unlist(MCMC_all_kappa_01[,3]))
kappa <- unlist(unlist(MCMC_all_kappa_01[,5]))

R0_all <- lapply(sample_data, function(x) {
  R <- (1+kappa*gbar*r)^(1/kappa)
  
  data.frame(
    est=median(R),
    lwr=quantile(R, 0.025),
    upr=quantile(R, 0.975)
  )
}) %>%
  bind_rows(.id="study") %>%
  mutate(
    type="all"
  )

R0_all
