library(magrittr)

#####INPUT#####
fin <- file("day10.in", "r")
nums <- readLines(fin) %>%
  as.integer()
close(fin)

#####PART 1#####
nums <- nums %>%
  c(0, max(nums) + 3) %>%
  sort()
consec <- nums %>%
  sort() %>%
  diff()

num_diff1 <- sum(consec == 1)
num_diff3 <- sum(consec == 3)
print(num_diff1 * num_diff3)

#####PART 2#####
# assumes min(nums) is equal to 1
ways <- numeric(max(nums))
ways[1] <- 1
if (2 %in% nums) {
  ways[2] <- ways[1] + 1
}
if (3 %in% nums) {
  ways[3] <- ways[1] + ways[2] + 1
}

indices <- seq_along(ways)
for (i in indices[indices > 3]) {
  if (i %in% nums) {
    ways[i] <- ways[i - 1] + ways[i - 2] + ways[i - 3]
  }
}
options(scipen = 999)
print(ways[max(nums)])
options(scipen = 0)
