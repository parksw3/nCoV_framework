Rdata <- data.frame(
  study=c("Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder et al. (2020)"),
  est=c(2.5, 2.2, 3.8, 5.47, NA ),
  lwr=c(1.5, 1.4, 3.6, 4.16, 2),
  upr=c(3.5, 3.8, 4, 7.1, 3.3)
)

rdata <- data.frame(
  study=c("Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder et al. (2020)"),
  est=c((2.5^0.5 - 1)/(0.5 * 8.4), 
        (2.2^0.5 - 1)/(0.5 * 10.5),
        1/2*(-(1/4+1/3.6)+sqrt((1/4-1/3.6)^2+4*1.07*1/4)),
        (5.47^0.2 - 1)/(0.2 * 8),
        NA),
  lwr=c((1.5^0.5 - 1)/(0.5 * 8.4),
        (1.4^0.5 - 1)/(0.5 * 14),
        1/2*(-(1/4+1/3.6)+sqrt((1/4-1/3.6)^2+4*1.06*1/4)),
        (4.16^0.2 - 1)/(0.2 * 8),
        log(2)/10),
  upr=c((3.5^0.5 - 1)/(0.5 * 8.4),
        (3.8^0.5 - 1)/(0.5 * 7),
        1/2*(-(1/4+1/3.6)+sqrt((1/4-1/3.6)^2+4*1.09*1/4)),
        (7.1^0.2 - 1)/(0.2 * 8),
        log(3.3)/6)
)

gdata <- data.frame(
  study=c("Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder et al. (2020)"),
  est=c(8.4, NA, 7.6, NA, NA ),
  lwr=c(8.4, 7, 7.6, 7.6, 6),
  upr=c(8.4, 14, 7.6, 8.4, 10)
)

kappadata <- data.frame(
  study=c("Imai et al. (2020)", "Riou and Althaus (2020)", "Read et al. (2020)",
          "Zhao et al. (2020)", "Majumder et al. (2020)"),
  est=c(NA, 0.5, 0.5, 0.2, 0)
)
