library(coda)
library(dplyr)
library(tidyr)

load("MCMC_all.rda")

MCMC_all %>%
  lapply(as.data.frame) %>%
  bind_rows %>%
  setNames(c("mu_r", "sigma_r", "mu_G", "sigma_G", "mu_kappa", "sigma_kappa")) %>%
  gather(key, value) %>%
  group_by(key) %>%
  summarize(
    est=median(value),
    lwr=quantile(value, 0.025),
    upr=quantile(value, 0.975)
  )
