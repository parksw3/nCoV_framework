library(coda)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=16))
library(gridExtra)
library(tikzDevice)

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
    type="none"
  )
  
  dd_r <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=quantile((1+median(kappa)*median(gbar)*x)^(1/median(kappa)), 0.025),
    upr=quantile((1+median(kappa)*median(gbar)*x)^(1/median(kappa)), 0.975),
    type="$\\mu_r$"
  )
  
  dd_gbar <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=quantile((1+median(kappa)*gbar*median(x))^(1/median(kappa)), 0.025),
    upr=quantile((1+median(kappa)*gbar*median(x))^(1/median(kappa)), 0.975),
    type="$\\mu_G$"
  )
  
  dd_kappa <- data.frame(
    est=(1+median(kappa)*median(gbar)*median(x))^(1/median(kappa)),
    lwr=quantile((1+kappa*median(gbar)*median(x))^(1/kappa), 0.025),
    upr=quantile((1+kappa*median(gbar)*median(x))^(1/kappa), 0.975),
    type="$\\mu_\\kappa$"
  )
  
  dd_all <- data.frame(
    est=median((1+kappa*gbar*x)^(1/kappa)),
    lwr=quantile((1+kappa*gbar*x)^(1/kappa), 0.025),
    upr=quantile((1+kappa*gbar*x)^(1/kappa), 0.975),
    type="all"
  )
  
  dd_combine <- rbind(dd, dd_r, dd_gbar, dd_kappa, dd_all)
  
  dd_combine
}

dd_combine <- compfun(r)

dd_combine2 <- compfun((r + median(r)*3)/4) %>%
  mutate(
    type=as.character(type),
    type=ifelse(type=="$\\mu_r$", "$\\hat{\\mu}_r$", type),
    type=factor(type, levels=type)
  )

g1 <- ggplot(dd_combine) +
  geom_point(aes(type, est), size=5) +
  geom_errorbar(aes(type, min=lwr, max=upr), width=0, lwd=2) +
  xlab("Uncertainty type") +
  ggtitle("A. Baseline") +
  scale_y_continuous("Basic reproductive number", limits=c(2, 4.6), expand=c(0, 0)) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line()
  )

g2 <- ggplot(dd_combine2) +
  geom_point(aes(type, est), size=5) +
  geom_errorbar(aes(type, min=lwr, max=upr), width=0, lwd=2) +
  xlab("Uncertainty type") +
  ggtitle("B. Reduced uncertainty in $r$") +
  scale_y_continuous("Basic reproductive number", limits=c(2, 4.6), expand=c(0, 0)) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line()
  )

tikz(file = "figure2.tex", width = 8, height = 4, standAlone = T)
grid.arrange(g1, g2, nrow=1)
dev.off()
tools::texi2dvi('figure2.tex', pdf = T, clean = T)
