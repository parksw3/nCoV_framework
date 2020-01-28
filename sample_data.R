source("sample_author.R")

nsample <- 100000

set.seed(101)
sample_data <- list(
  `Imai et al. (2020)`=sample_imai(nsample),
  `Liu et al. (2020)`=sample_liu(nsample),
  `Majumder et al. (2020)`=sample_majumder(nsample),
  `Read et al. (2020)`=sample_read(nsample),
  `Riou and Althaus (2020)`=sample_riou(nsample),
  `Zhao et al. (2020)`=sample_zhao(nsample)
)

save(sample_data, file="sample_data.rda")
