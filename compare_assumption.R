library(ggplot2); theme_set(theme_bw())
library(gridExtra)
source("published_estimate.R")
source("study_number.R")

load("sample_data.rda")

load("MCMC_all.rda")

rdata2 <- sample_data %>%
  lapply(function(x) {
    data.frame(
      est=median(x$r),
      lwr=quantile(x$r, 0.025),
      upr=quantile(x$r, 0.975)
    )
  }) %>%
  bind_rows(.id="study")

avg_r <- data.frame(
  median=median(unlist(unlist(MCMC_all[,1]))),
  lwr=quantile(unlist(unlist(MCMC_all[,1])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,1])), 0.975),
  study="Average"
)

avg_gen <- data.frame(
  median=median(unlist(unlist(MCMC_all[,3]))),
  lwr=quantile(unlist(unlist(MCMC_all[,3])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,3])), 0.975),
  study="Average"
)

avg_kappa <- data.frame(
  median=median(unlist(unlist(MCMC_all[,5]))),
  lwr=quantile(unlist(unlist(MCMC_all[,5])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,5])), 0.975),
  study="Average"
)

g1 <- ggplot(merge(rdata2, study_number)) +
  geom_point(aes(est, anon)) +
  geom_segment(aes(lwr, anon, xend=upr, yend=anon)) +
  geom_point(data=avg_r, aes(median, study), col=2) +
  geom_segment(data=avg_r, aes(lwr, study, xend=upr, yend=study), col=2) +
  scale_x_continuous(expression(Exponentia~ growth~rate~(days^{-1}))) +
  theme(
    axis.title.y = element_blank()
  )

g2 <- ggplot(merge(gdata, study_number)) +
  geom_point(aes(est, anon)) +
  geom_segment(aes(lwr, anon, xend=upr, yend=anon)) +
  geom_point(data=avg_gen, aes(median, study), col=2) +
  geom_segment(data=avg_gen, aes(lwr, study, xend=upr, yend=study), col=2) +
  scale_x_continuous("Mean generation time (days)") +
  theme(
    axis.title.y = element_blank()
  )

g3 <- ggplot(merge(kappadata, study_number)) +
  geom_point(aes(est, anon)) +
  geom_point(data=avg_kappa, aes(median, study), col=2) +
  geom_segment(data=avg_kappa, aes(lwr, study, xend=upr, yend=study), col=2) +
  scale_x_continuous("Squared coefficient of variation") +
  theme(
    axis.title.y = element_blank()
  )

gtot <- arrangeGrob(g1, g2, g3, nrow=1)

ggsave("compare_assumption.pdf", gtot, width=12, height=3)
