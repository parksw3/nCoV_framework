library(ggplot2); theme_set(theme_bw())
library(dplyr)
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
  est=median(unlist(unlist(MCMC_all[,1]))),
  lwr=quantile(unlist(unlist(MCMC_all[,1])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,1])), 0.975),
  anon="Pooled estimate"
)

avg_gen <- data.frame(
  est=median(unlist(unlist(MCMC_all[,3]))),
  lwr=quantile(unlist(unlist(MCMC_all[,3])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,3])), 0.975),
  anon="Pooled estimate"
)

avg_kappa <- data.frame(
  est=median(unlist(unlist(MCMC_all[,5]))),
  lwr=quantile(unlist(unlist(MCMC_all[,5])), 0.025),
  upr=quantile(unlist(unlist(MCMC_all[,5])), 0.975),
  anon="Pooled estimate"
)

rdata3 <- mutate(merge(rdata2, study_number)) %>%
  bind_rows(avg_r) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

g1 <- ggplot(rdata3) +
  geom_point(aes(est, anon), col=c("orange", "purple", "purple", 1, "purple", "purple", "purple", 2),
             size=c(2, 2, 2, 2, 2, 2, 2, 4)) +
  geom_segment(aes(lwr, anon, xend=upr, yend=anon), col=c("orange", "purple", "purple", 1, "purple", "purple", "purple", 2),
               lwd=c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 1.2)) +
  scale_x_continuous(expression(Exponential~growth~rate~(days^{-1}))) +
  theme(
    axis.title.y = element_blank()
  )

gdata2 <- mutate(merge(gdata, study_number)) %>%
  bind_rows(avg_gen) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

g2 <- ggplot(gdata2) +
  geom_point(aes(est, anon), col=c(1, 1, 1, "orange", 1, "orange", "orange", 2),
             size=c(2, 2, 2, 2, 2, 2, 2, 4)) +
  geom_segment(aes(lwr, anon, xend=upr, yend=anon), col=c(1, 1, 1, "orange", 1, "orange", "orange", 2),
               lwd=c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 1.2)) +
  scale_x_continuous("Mean generation interval (days)") +
  theme(
    axis.title.y = element_blank()
  )

kappadata2 <- mutate(merge(kappadata, study_number)) %>%
  bind_rows(avg_kappa) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1))),
    est=ifelse(anon=="Study 2", 0.5, est)
  )

g3 <- ggplot(kappadata2) +
  geom_point(aes(est, anon), shape=c(16, 2, 16, 16, 16, 16, 16, 16),
             col=c(1, 1, 1, 1, 1, 1, 1, 2),
             size=c(2, 2, 2, 2, 2, 2, 2, 4)) +
  geom_segment(aes(lwr, anon, xend=upr, yend=anon), col=c(1, 1, 1, 1, 1, 1, 1, 2),
               lwd=c(0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 1.2)) +
  scale_x_continuous("Squared coefficient of variation",
                     breaks=c(0, 0.25, 0.5, 0.75, 1)) +
  theme(
    axis.title.y = element_blank()
  )

gtot <- arrangeGrob(g1, g2, g3, nrow=1)

ggsave("compare_assumption.pdf", gtot, width=10, height=3)
