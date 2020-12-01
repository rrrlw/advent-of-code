library(tidyverse)

#####INPUT#####
fin <- file("day1.in", open = "r")
vals <- readLines(fin)
close(fin)

#####PART 1#####
vals %>%
  expand.grid(vals) %>%
  mutate(Var1 = as.numeric(levels(Var1))[Var1],
         Var2 = as.integer(levels(Var2))[Var2],
         Sum = Var1 + Var2,
         Prod = Var1 * Var2) %>%
  filter(Sum == 2020) %>%
  pull(Prod) %>%
  unique() %>%
  print()

#####PART 2#####
vals %>%
  expand.grid(vals, vals) %>%
  mutate(Var1 = as.numeric(levels(Var1))[Var1],
         Var2 = as.numeric(levels(Var2))[Var2],
         Var3 = as.numeric(levels(Var3))[Var3],
         Sum = Var1 + Var2 + Var3,
         Prod = Var1 * Var2 * Var3) %>%
  filter(Sum == 2020) %>%
  pull(Prod) %>%
  unique() %>%
  print()
