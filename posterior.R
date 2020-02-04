library(coda)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw())
library(colorspace)
library(gridExtra)

load("MCMC_all.rda")

parnames <- c("mu[r]~(days^{-1})", "sigma[r]", "mu[G]~(days)", "sigma[G]", "mu[kappa]", "sigma[kappa]")

gelman.diag(MCMC_all)

MCMC_data <- lapply(MCMC_all, function(x) {
  dd <- as.data.frame(x)
  dd <- setNames(dd, parnames)
  dd$nn <- 1:nrow(dd)
  dd
}) %>%
  bind_rows(.id="chain") 

## there's probably a better way of doing this
## e.g., gather and use facet_wrap
## but I want to customize y axis titles...

g1 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `mu[r]~(days^{-1})`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(mu[r]~(days^{-1}))) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

g2 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `sigma[r]`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(sigma[r])) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

g3 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `mu[G]~(days)`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(mu[G]~(days))) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

g4 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `sigma[G]`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(sigma[G])) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

g5 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `mu[kappa]`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(mu[kappa])) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

g6 <- ggplot(MCMC_data) +
  geom_line(aes(nn, `sigma[kappa]`, col=chain)) +
  scale_x_continuous("MCMC steps (thinned every 400 steps)", expand=c(0, 0),
                     breaks=c(0, 100, 200, 300, 400), limits=c(0, 500)) +
  scale_y_continuous(expression(sigma[kappa])) +
  scale_colour_manual(values=colorspace::qualitative_hcl(4)) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  )

gmcmc <- arrangeGrob(g1, g2, g3, g4, g5, g6, nrow=3)

ggsave("posterior_chain.pdf", gmcmc, width=8, height=8)

MCMC_summ <- gather(MCMC_data, key, value, -nn, -chain) %>%
  mutate(key=factor(key, levels=parnames))

gpost <- ggplot(MCMC_summ) +
  geom_density(aes(value, col=chain), position="identity") +
  facet_wrap(~key, scale="free", nrow=3,
             labeller = label_parsed)  +
  scale_x_continuous("Parameter values", limits=c(0, NA), expand=c(0, 0)) +
  scale_y_continuous("Posterior density") +
  theme(
    panel.grid = element_blank(),
    legend.position = "none",
    strip.background = element_blank()
  )

ggsave("posterior_dist.pdf", gpost, width=8, height=8)
