library(ggplot2); theme_set(theme_bw())
library(gridExtra)
source("published_estimate.R")

load("R0_r.rda")
load("R0_gbar.rda")
load("R0_kappa.rda")
load("R0_all.rda")

R0all <- Rdata %>%
  mutate(
    type="base"
  ) %>%
  bind_rows(
    R0_r, R0_gbar, R0_kappa, R0_all
  ) %>%
  mutate(
    type=factor(type, levels=c("base", "r", "gbar", "kappa", "all"),
                labels=c("base", "growth rate", "GI mean", "GI variation", "all"))
  )

g1 <- ggplot(R0all) +
  geom_point(aes(study, est, col=type), position=position_dodge(0.5)) +
  geom_errorbar(aes(study, ymin=lwr, ymax=upr, col=type), position=position_dodge(0.5),
                width=0) +
  scale_y_continuous("Basic reproductive number") +
  theme(
    axis.title.x = element_blank(),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave("compare_R0.pdf", g1, width=12, height=4)
