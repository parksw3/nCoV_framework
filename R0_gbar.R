load("sample_data.rda")
load("MCMC_all.rda")

gbar <- unlist(unlist(MCMC_all[,3]))

R0_gbar <- lapply(sample_data, function(x) {
  R <- (1+x$kappa*gbar*x$r)^(1/x$kappa)
  
  if (all(x$kappa == 0))
    R <- exp(gbar*x$r)
  
  data.frame(
    est=median(R),
    lwr=quantile(R, 0.025),
    upr=quantile(R, 0.975)
  )
}) %>%
  bind_rows(.id="study") %>%
  mutate(
    type="gbar"
  )

save("R0_gbar", file="R0_gbar.rda")
