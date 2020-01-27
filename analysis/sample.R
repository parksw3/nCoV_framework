sample_imai <- function(n=1) {
  # qgamma(0.025, 20, 20/2.5)
  # qgamma(0.975, 20, 20/2.5)
  dplyr::data_frame(
    gbar=8.4,
    kappa=0.5,
    R=rgamma(n, 20, rate=20/2.5),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_majumder <- function(n=1) {
  # qgamma(0.025, 20, 20/2.5)
  # qgamma(0.975, 20, 20/2.5)
  dplyr::data_frame(
    gbar=runif(n, min=6,max=10),
    kappa=0,
    r=log(2)/gbar,
    R=exp(r*gbar),
    rho=r*gbar
  )
}
