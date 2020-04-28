sample_bedford <- function(n=1) {
  dplyr::data_frame(
    gbar=10,
    kappa=1,
    R=runif(n, 1.5, 3.5),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_imai <- function(n=1) {
  # pgamma(3.5, 18, 18/2.6)-pgamma(1.5, 18, 18/2.6)
  
  dplyr::data_frame(
    gbar=8.4,
    kappa=0.5,
    R=rgamma(n, 18, rate=18/2.6),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_majumder <- function(n=1) {
  dplyr::data_frame(
    gbar=runif(n, min=6,max=10),
    kappa=0,
    r=0.114,
    R=exp(r*gbar),
    rho=r*gbar
  )
}

sample_read <- function(n=1) {
  # pgamma(4, 1400, 1400/3.8) - pgamma(3.6, 1400, 1400/3.8)
  
  dplyr::data_frame(
    gbar=7.6,
    kappa=0.5,
    R=rgamma(n, 1400, rate=1400/3.8),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_riou <- function(n=1) {
  # pgamma(3.8, 12, 12/2.2) - pgamma(1.4, 12, 12/2.2)

  dplyr::data_frame(
    gbar=runif(n, 7, 14),
    kappa=0.5,
    R=rgamma(n, 12, rate=12/2.2),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}

sample_zhao <- function(n=1) {
  # pgamma(7.1, 54, 54/5.47) - pgamma(4.16, 54, 54/5.47)
  
  dplyr::data_frame(
    gbar=runif(n, 7.6, 8.4),
    kappa=0.2,
    R=rgamma(n, 54, rate=54/5.47),
    r=(R^kappa-1)/(kappa*8), ## using average gbar to calculate r; this better reflects what the authors do.
    rho=r*8
  )
}

sample_liu <- function(n=1) {
  # pgamma(3.67, 67, 67/2.92) - pgamma(2.28, 67, 67/2.92)
  
  dplyr::data_frame(
    gbar=8.4,
    kappa=(3.8/8.4)^2,
    R=rgamma(n, 67, rate=67/2.92),
    r=(R^kappa-1)/(kappa*gbar),
    rho=r*gbar
  )
}
