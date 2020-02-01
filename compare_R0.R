library(ggplot2); theme_set(theme_bw())
library(gridExtra)
library(colorspace)
library(dplyr)
source("published_estimate.R")
source("study_number.R")

load("R0_r.rda")
load("R0_gbar.rda")
load("R0_kappa.rda")
load("R0_all.rda")

R0all <- Rdata_adj %>%
  mutate(
    type="base"
  ) %>%
  bind_rows(
    R0_r, R0_gbar, R0_kappa,
    mutate(filter(R0_all, study=="Imai et al. (2020)"))
  ) %>%
  mutate(
    type=factor(type, levels=c("base", "r", "gbar", "kappa", "all"),
                labels=c("base", "growth rate", "GI mean", "GI variation", "all"))
  ) %>%
  merge(study_number) %>%
  mutate(
    anon=ifelse(type=="all", "Pooled estimate", as.character(anon))
  )
  
R0all %>%
  filter(type!="all", type!="base") %>%
  mutate(
    width=upr-lwr
  ) %>%
  merge(summarize(group_by(Rdata_adj, study), bwidth=upr-lwr)) %>%
  mutate(
    ww=width>bwidth
  )

R0all %>%
  filter(type=="all") %>%
  mutate(
    width=upr-lwr
  ) %>%
  merge(summarize(group_by(Rdata, study), bwidth=upr-lwr)) %>%
  mutate(
    ww=width>bwidth
  )

all_col <- "#000000" ## black
g1 <- ggplot(R0all) +
  ## tried to collapse these two lines to one using annotate or other clever
  ## tricks, failed ...
  geom_hline(data=R0_all, aes(yintercept=lwr), lty=2, col=all_col, alpha=0.5) +
  geom_hline(data=R0_all, aes(yintercept=upr), lty=2, col=all_col, alpha=0.5) +
  geom_point(aes(anon, est, col=type, shape=type), position=position_dodge(0.5)) +
  geom_errorbar(aes(anon, ymin=lwr, ymax=upr, col=type), position=position_dodge(0.5),
                width=0) +
  scale_y_continuous("Basic reproductive number", breaks=c(2, 4, 6, 8, 10)) +
  ## scale_colour_discrete_qualitative() +
  scale_colour_manual(values=c(colorspace::qualitative_hcl(4),"#000000")) +
  theme(
    axis.title.x = element_blank(),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave("compare_R0.pdf", g1, width=6, height=4)
ggsave("compare_R0.png", g1, width=6, height=4)

