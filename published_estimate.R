Rdata <- data.frame(
  study=c("Bedford et al. (2020)", "Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder and Mandl (2020)", "Liu et al. (2020)"),
  est=c(NA, 2.5, 2.2, 3.8, 5.47, NA, 2.92),
  lwr=c(1.5, 1.5, 1.4, 3.6, 4.16, 2, 2.28),
  upr=c(3.5, 3.5, 3.8, 4, 7.1, 3.1, 3.67)
)

Rdata_adj <- data.frame(
  study=c("Bedford et al. (2020)", "Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder and Mandl (2020)", "Liu et al. (2020)"),
  est=c(NA, 2.5, 2.2, 3.8, 5.47, NA, 2.92),
  lwr=c(qunif(0.025, 1.5, 3.6), 1.5, qgamma(0.025, 12, 12/2.2), 3.6, 4.16, exp(0.114 * qunif(0.025, 6, 10)), 2.28),
  upr=c(qunif(0.975, 1.5, 3.6), 3.5, qgamma(0.975, 12, 12/2.2), 4, 7.1, exp(0.114 * qunif(0.975, 6, 10)), 3.67)
)

gdata <- data.frame(
  study=c("Bedford et al. (2020)", "Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder and Mandl (2020)", "Liu et al. (2020)"),
  est=c(10, 8.4, NA, 7.6, NA, NA, 8.4),
  lwr=c(10, 8.4, 7, 7.6, 7.6, 6, 8.4),
  upr=c(10, 8.4, 14, 7.6, 8.4, 10, 8.4)
)

kappadata <- data.frame(
  study=c("Bedford et al. (2020)", "Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder and Mandl (2020)", "Liu et al. (2020)"),
  est=c(1, NA, 0.5, 0.5, 0.2, 0, 0.2)
)
