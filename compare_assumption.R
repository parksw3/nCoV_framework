library(coda)
library(ggplot2); theme_set(theme_bw())
library(see)
library(dplyr)
library(gridExtra)
library(tikzDevice)
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

gdata2 <- sample_data %>%
  lapply(function(x) {
    data.frame(
      est=median(x$gbar),
      lwr=quantile(x$gbar, 0.025),
      upr=quantile(x$gbar, 0.975)
    )
  }) %>%
  bind_rows(.id="study")

kappadata2 <- sample_data %>%
  lapply(function(x) {
    data.frame(
      est=median(x$kappa),
      lwr=quantile(x$kappa, 0.025),
      upr=quantile(x$kappa, 0.975)
    )
  }) %>%
  bind_rows(.id="study")

avg_r <- data.frame(
  est=unlist(unlist(MCMC_all[,1])),
  anon="Pooled estimate"
) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

quantile(avg_r$est, c(0.025, 0.5, 0.975))

avg_gen <- data.frame(
  est=unlist(unlist(MCMC_all[,3])),
  anon="Pooled estimate"
) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

quantile(avg_gen$est, c(0.025, 0.5, 0.975))

avg_kappa <- data.frame(
  est=unlist(unlist(MCMC_all[,5])),
  anon="Pooled estimate"
) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

quantile(avg_kappa$est, c(0.025, 0.5, 0.975))

rdata3 <- mutate(merge(rdata2, study_number)) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

g1 <- ggplot(rdata3) +
  geom_point(aes(anon, est, col=anon), size=2) +
  geom_errorbar(aes(anon, ymin=lwr, ymax=upr, col=anon), lwd=0.7, width=0) +
  geom_violinhalf(data=avg_r, aes(anon, est, col=anon, fill=anon), alpha=0.2, width=1) +
  scale_color_manual(values=c("red", "orange", "purple", "purple", "purple", "purple", "purple", 1)) +
  scale_fill_manual(values=c("red", "orange", "purple", "purple", "purple", "purple", "purple", 1)) +
  scale_y_continuous(expression(Exponential~growth~rate~(days^{-1}))) +
  coord_flip() +
  theme(
    axis.title.y = element_blank(),
    legend.position = "none"
  )

gdata3 <- mutate(merge(gdata2, study_number)) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1)))
  )

g2 <- ggplot(gdata3) +
  geom_point(aes(anon, est, col=anon), size=2) +
  geom_errorbar(aes(anon, ymin=lwr, ymax=upr, col=anon), lwd=0.7, width=0) +
  geom_violinhalf(data=avg_gen, aes(anon, est, col=anon, fill=anon), alpha=0.2, width=1) +
  scale_color_manual(values=c("red", "black", "black", "black", "black", "orange", "orange", "orange")) +
  scale_fill_manual(values=c("red", "black", "black", "black", "black", "orange", "orange", "orange")) +
  scale_y_continuous("Mean generation interval (days)") +
  coord_flip() +
  theme(
    axis.title.y = element_blank(),
    legend.position = "none"
  )

kappadata3 <- mutate(merge(kappadata2, study_number)) %>%
  mutate(
    anon=factor(anon, levels=c("Pooled estimate", paste0("Study ", 7:1))),
    est=ifelse(anon=="Study 2", 0.5, est)
  )

g3 <- ggplot(kappadata3) +
  geom_point(aes(anon, est, col=anon), size=2, shape=c(16, 2, 16, 16, 16, 16, 16)) +
  geom_errorbar(aes(anon, ymin=lwr, ymax=upr, col=anon), lwd=0.7, width=0) +
  geom_violinhalf(data=avg_kappa, aes(anon, est, col=anon, fill=anon), alpha=0.2, width=1) +
  scale_color_manual(values=c("red", "black", "black", "black", "black", "black", "black", "black")) +
  scale_fill_manual(values=c("red", "black", "black", "black", "black", "black", "black", "black")) +
  scale_y_continuous("Generation-interval dispersion") +
  coord_flip() +
  theme(
    axis.title.y = element_blank(),
    legend.position = "none"
  )

gtot <- arrangeGrob(g1, g2, g3, nrow=1)

tikz(file = "compare_assumption.tex", width = 10, height = 3, standAlone = T)
plot(gtot)
dev.off()
tools::texi2dvi('compare_assumption.tex', pdf = T, clean = T)
