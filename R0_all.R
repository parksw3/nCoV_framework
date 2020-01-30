library(coda)
library(dplyr)

load("sample_data.rda")
load("MCMC_all.rda")

r <- unlist(unlist(MCMC_all[,1]))
gbar <- unlist(unlist(MCMC_all[,3]))
kappa <- unlist(unlist(MCMC_all[,5]))

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

save("R0_all", file="R0_all.rda")
