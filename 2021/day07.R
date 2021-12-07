library(magrittr)

#####INPUT#####
fin <- file("day07.in", open = "r")
vals <- readLines(fin) %>%
  strsplit(split = ",", fixed = TRUE) %>%
  unlist %>%
  as.integer
close(fin)

#####UTILITY#####
dist_part2 <- function(val1, vals) {
  adj_vals <- abs(vals - val1)
  sum(adj_vals * (adj_vals + 1) / 2)
}

#####PART 1#####
# median to optimize L1 norm
vals %>%
  median %>%
  subtract(vals) %>%
  abs %>%
  sum %>%
  print

#####PART 2#####
# mean to optimize L2 norm (kinda); min of the floor vs ceil
poss1 <- vals %>%
  mean %>%
  ceiling %>%
  dist_part2(vals) %>%
  abs %>%
  sum
poss2 <- vals %>%
  mean %>%
  floor %>%
  dist_part2(vals) %>%
  abs %>%
  sum
print(min(poss1, poss2))
