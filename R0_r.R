load("sample_data.rda")
load("MCMC_all.rda")

r <- unlist(unlist(MCMC_all[,1]))

R0_r <- lapply(sample_data, function(x) {
  R <- (1+x$kappa*x$gbar*r)^(1/x$kappa)
  
  if (all(x$kappa == 0))
    R <- exp(x$gbar*r)
  
  data.frame(
    est=median(R),
    lwr=quantile(R, 0.025),
    upr=quantile(R, 0.975)
  )
}) %>%
  bind_rows(.id="study") %>%
  mutate(
    type="r"
  )

save("R0_r", file="R0_r.rda")
