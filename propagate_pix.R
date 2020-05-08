library(ggplot2); theme_set(theme_bw(base_size=16))
library(tikzDevice)

texname <- paste0(rtargetname, ".tex")

tikz(file = texname, standAlone = T)
print(g1)
print(g2)
