set.seed(101)

nsim <- 100000

r <- rgamma(nsim, 2, 2*7)
gbar <- rgamma(nsim, 2, 2/7) 
kappa <- rgamma(nsim, 2, 2/0.5)

R0 <- (1 + kappa * r * gbar)^(1/kappa)

quantile(R0, c(0.025, 0.975))
