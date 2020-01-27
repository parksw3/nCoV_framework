set.seed(101)

n <- 10000

r <- rgamma(n, shape=5, rate=5/0.15)
g <- rgamma(n, shape=10, rate=10/8.5)
kappa <- rgamma(n, shape=10, rate=10/0.35)

quantile(r, c(0.025, 0.975))
quantile(g, c(0.025, 0.975))
quantile(kappa, c(0.025, 0.975))

R0 <- (1+g*r*kappa)^(1/kappa)

median(R0)
quantile(R0, c(0.025, 0.975))
