library(magrittr)

#####INPUT#####
fin <- file("day5.in", "r")
seats <- readLines(fin)
close(fin)

#####UTILITY FUNCTIONS#####
seat_row <- function(seat) {
  seat %>%
    substr(start = 1, stop = 7) %>%
    gsub(pattern = "F", replacement = "0", fixed = TRUE) %>%
    gsub(pattern = "B", replacement = "1", fixed = TRUE) %>%
    strtoi(base = 2)
}
seat_col <- function(seat) {
  seat %>%
    substr(start = 8, stop = 10) %>%
    gsub(pattern = "L", replacement = "0", fixed = TRUE) %>%
    gsub(pattern = "R", replacement = "1", fixed = TRUE) %>%
    strtoi(base = 2)
}
seat_id <- function(seat) {
  seat_row(seat) * 8 + seat_col(seat)
}

#####PART 1#####
taken <- seat_id(seats)
taken %>%
  max() %>%
  print()

#####PART 2#####
all_seats <- seq(from = min(taken), to = max(taken), by = 1)
all_seats[!(all_seats %in% taken)] %>%
  print()