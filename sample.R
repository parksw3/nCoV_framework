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
  dplyr::data_frame(
    gbar=runif(n, min=6,max=10),
    kappa=0,
    r=runif(n, max=log(2)/6, min=log(3.1)/10),
    R=exp(r*gbar),
    rho=r*gbar
  )
}

sample_read <- function(n=1) {
  # qgamma(0.025, 1400, 1400/3.8)
  # qgamma(0.975, 1400, 1400/3.8)
  
  dplyr::data_frame(
    gbar=7.6,
    kappa=0.5,
    R=rgamma(n, 1400, rate=1400/3.8),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_riou <- function(n=1) {
  # qgamma(0.05, 12, 12/2.5)
  # qgamma(0.95, 12, 12/2.5)
  # qgamma(0.5, 12, 12/2.5)
  
  dplyr::data_frame(
    gbar=runif(n, 7, 14),
    kappa=0.5,
    R=rgamma(n, 12, rate=12/2.5),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_zhao <- function(n=1) {
  # qgamma(0.025, 50, 50/5.47)
  # qgamma(0.975, 50, 50/5.47)
  
  dplyr::data_frame(
    gbar=runif(n, 7.6, 8.4),
    kappa=0.2,
    R=rgamma(n, 50, rate=50/5.47),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_liu <- function(n=1) {
  # qgamma(0.025, 65, 65/2.92)
  # qgamma(0.975, 65, 65/2.92)
  
  dplyr::data_frame(
    gbar=8.4,
    kappa=(3.8/8.4)^2,
    R=rgamma(n, 65, rate=65/2.92),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}
