library(coda)
library(ggplot2); theme_set(theme_bw(base_size=18))

load("sample_data.rda")
load("MCMC_all.rda")

r <- unlist(unlist(MCMC_all[,1]))
gbar <- unlist(unlist(MCMC_all[,3]))
kappa <- unlist(unlist(MCMC_all[,5]))

compfun <- function(x) {
  dd <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    upr=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    type="base"
  )
  
  dd_r <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=quantile((1+median(kappa)*median(gbar)*x)^(1/median(kappa)), 0.025),
    upr=quantile((1+median(kappa)*median(gbar)*x)^(1/median(kappa)), 0.975),
    type="growth rate"
  )
  
  dd_gbar <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=quantile((1+median(kappa)*gbar*median(x))^(1/median(kappa)), 0.025),
    upr=quantile((1+median(kappa)*gbar*median(x))^(1/median(kappa)), 0.975),
    type="GI mean"
  )
  
  dd_both <- data.frame(
    est=median((1+median(kappa)*gbar*x)^(1/median(kappa))),
    lwr=quantile((1+median(kappa)*gbar*x)^(1/median(kappa)), 0.025),
    upr=quantile((1+median(kappa)*gbar*x)^(1/median(kappa)), 0.975),
    type="growth rate\n+\nGI mean"
  )
  
  dd_all <- data.frame(
    est=median((1+kappa*gbar*x)^(1/kappa)),
    lwr=quantile((1+kappa*gbar*x)^(1/kappa), 0.025),
    upr=quantile((1+kappa*gbar*x)^(1/kappa), 0.975),
    type="all"
  )
  
  dd_combine <- rbind(dd, dd_r, dd_gbar, dd_both, dd_all)
  
  dd_combine
}

dd_combine <- compfun(r)

g1 <- ggplot(dd_combine) +
  geom_point(aes(type, est), size=7) +
  geom_errorbar(aes(type, min=lwr, max=upr), width=0, lwd=2) +
  xlab("Uncertainty type") +
  scale_y_continuous("Basic reproductive number", limits=c(2, 4.6), expand=c(0, 0)) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line()
  )

ggsave("figure2.pdf", g1, width=8, height=4)
