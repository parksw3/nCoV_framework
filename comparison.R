library(ggplot2); theme_set(theme_bw())
library(gridExtra)
source("../data/estimate.R")

g0 <- ggplot(Rdata) +
  geom_point(aes(est, study)) +
  geom_segment(aes(lwr, study, xend=upr, yend=study)) +
  scale_x_continuous("Basic reproductive number") +
  theme(
    axis.title.y = element_blank()
  )

g1 <- ggplot(rdata) +
  geom_point(aes(est, study)) +
  geom_segment(aes(lwr, study, xend=upr, yend=study)) +
  scale_x_continuous("Exponential growth rate") +
  theme(
    axis.title.y = element_blank()
  )

g2 <- ggplot(gdata) +
  geom_point(aes(est, study)) +
  geom_segment(aes(lwr, study, xend=upr, yend=study)) +
  scale_x_continuous("Mean generation time") +
  theme(
    axis.title.y = element_blank()
  )

g3 <- ggplot(kappadata) +
  geom_point(aes(est, study)) +
  # geom_segment(aes(lwr, study, xend=upr, yend=study)) +
  scale_x_continuous("Squared coefficient of variation") +
  theme(
    axis.title.y = element_blank()
  )

gtot <- arrangeGrob(g0, g1, g2, g3, nrow=2)

ggsave("comparison.pdf", gtot, width=8, height=4)
