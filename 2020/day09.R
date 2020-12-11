library(magrittr)
library(dplyr)

#####INPUT#####
fin <- file("day9.in", "r")
vals <- readLines(fin) %>%
  as.numeric()
close(fin)

#####UTILITY FUNCTIONS#####
is_pair_sum <- function(num, nums) {
  num %in% (
    expand.grid(nums, nums) %>%
      mutate(Sum = Var1 + Var2) %>%
      pull(Sum)
  )
}
works <- function(vals, preamble) {
  vapply(X = seq_along(vals),
         FUN.VALUE = logical(1),
         FUN = function(curr_loc) {
           if (curr_loc <= preamble) return(TRUE)
           
           part <- vals[seq(from = curr_loc - preamble, to = curr_loc - 1, by = 1)]
           curr <- vals[curr_loc]
           
           is_pair_sum(curr, part) %>%
             return()
         })
}
weakness <- function(vals, start, need_sum) {
  if (vals[start] == need_sum) return(-1)
  
  counter <- 0
  i <- start
  while (counter < need_sum & i <= length(vals)) {
    counter <- counter + vals[i]
    i <- i + 1
  }
  
  if (counter == need_sum) {
    part <- vals[seq(from = start, to = i - 1, by = 1)]
    return(min(part) + max(part))
  } else {
    return(-1)
  }
}
is_weakness <- function(vals, need_sum) {
  vapply(X = seq_along(vals),
         FUN.VALUE = numeric(1),
         FUN = function(i) {
           weakness(vals, i, need_sum)
         })
}

#####PART 1#####
ans <- vals[!works(vals, preamble = 25)]
print(ans)

#####PART 2#####
weaks <- is_weakness(vals, ans)
print(weaks[weaks > 0])
