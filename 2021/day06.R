library(magrittr)

#####INPUT#####
fin <- file("day06.in", open = "r")
vals <- readLines(fin) %>%
  strsplit(split = ",", fixed = TRUE) %>%
  unlist %>%
  as.integer
close(fin)

#####UTILITY#####
# first 9 days of 1 lantern fish at counter value 1
INIT_STATE <- c(1, 1, 2, 2, 2, 2, 2, 2, 2)
sim_fish <- function(init_vals, num_days) {
  num_days <- num_days + 1 # arbitrary adjustment based on problem setup
  ans <- vector(mode = "integer", length = as.integer(num_days))
  
  # hard code first 9 days
  ans[1:9] <- INIT_STATE
  counter_day <- 10
  
  # use recurrence relation to calculate remaining days
  while (counter_day <= num_days) {
    ans[counter_day] <- ans[counter_day - 7] + ans[counter_day - 9]
    counter_day <- counter_day + 1
  }
  
  # each initial fish is independent; keep adding based on their initial value
  counter_fish <- 0
  for (curr_fish in init_vals) {
    # account for initial counter value when simulating
    counter_fish <- counter_fish + ans[num_days - curr_fish + 1]
  }
  
  counter_fish
}

#####PART 1#####
vals %>%
  sim_fish(num_days = 80) %>%
  print

#####PART 2#####
options(scipen = 25)
vals %>%
  sim_fish(num_days = 256) %>%
  print
