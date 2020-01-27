gamma <- 1/4
mu <- 1/3.6

f <- function(x) {
  (gamma * mu/(gamma-mu) * (exp(-mu * x) - exp(-gamma * x))) * (x - 7.6)^2
}

integrate(f, 0, 1000)

28.96/7.6^2
