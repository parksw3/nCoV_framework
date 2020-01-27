load("sample_data.rda")
load("MCMC_all.rda")

kappa <- unlist(unlist(MCMC_all[,5]))

R0_kappa <- lapply(sample_data, function(x) {
  R <- (1+kappa*x$rho)^(1/kappa)
  
  data.frame(
    est=median(R),
    lwr=quantile(R, 0.025),
    upr=quantile(R, 0.975)
  )
}) %>%
  bind_rows(.id="study") %>%
  mutate(
    type="kappa"
  )

save("R0_kappa", file="R0_kappa.rda")
