#####SETUP#####
library(tidyverse)

#####UTILITY#####
# calculate traveled distance in given amount of time
reindeer_distance <- function(total_time, speed, move_time, rest_time) {
  # full cycles
  full_cycles <- as.integer(total_time / (move_time + rest_time))
  full_dist <- full_cycles * speed * move_time
  
  # partial cycle
  part_cycles <- total_time %% (move_time + rest_time)
  part_moved_time <- min(part_cycles, move_time)
  part_dist <- part_moved_time * speed
  
  # return the sum of distance traveled in both
  full_dist + part_dist
}

#####PART 1#####
# get & process input
input_data <- data.frame(speed = numeric(9),
                         move_time = numeric(9),
                         rest_time = numeric(9))
input_str <- readLines("day14.in")
nums <- input_str %>%
  str_extract_all(pattern = "\\d+")

for (i in seq_len(length(input_str))) {
  extracted <- nums[[i]]
  
  input_data$speed[i] <- extracted[1] %>% as.numeric
  input_data$move_time[i] <- extracted[2] %>% as.numeric
  input_data$rest_time[i] <- extracted[3] %>% as.numeric
}

# get max distance
max_dist <- vapply(X = seq_len(nrow(input_data)),
                   FUN = function(i) {
                     reindeer_distance(
                       total_time = 2503,
                       speed = input_data$speed[i],
                       move_time = input_data$move_time[i],
                       rest_time = input_data$rest_time[i]
                     )
                   },
                   FUN.VALUE = numeric(1),
                   USE.NAMES = FALSE) %>%
  max

# output
print(max_dist)

#####PART 2#####
