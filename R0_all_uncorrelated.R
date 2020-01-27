load("sample_data.rda")
load("MCMC_all.rda")

r <- sample(unlist(unlist(MCMC_all[,1])), replace=FALSE)
gbar <- sample(unlist(unlist(MCMC_all[,3])), replace=FALSE)
kappa <- sample(unlist(unlist(MCMC_all[,5])), replace=FALSE)

R0_all_uncorrelated <- lapply(sample_data, function(x) {
  R <- (1+kappa*gbar*r)^(1/kappa)
  
  data.frame(
    est=median(R),
    lwr=quantile(R, 0.025),
    upr=quantile(R, 0.975)
  )
}) %>%
  bind_rows(.id="study") %>%
  mutate(
    type="allu"
  )

save("R0_all_uncorrelated", file="R0_all_uncorrelated.rda")
