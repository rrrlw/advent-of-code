library(magrittr)

#####INPUT#####
fin <- file("day2.in", "r")
gifts <- readLines(fin)
close(fin)

#####PART 1#####
gift_area <- function(vec) {
  areas <- c(vec[1] * vec[2], vec[2] * vec[3], vec[1] * vec[3])
  sum(2 * areas) + min(areas)
}

gifts %>%
  strsplit(split = "x", fixed = TRUE) %>%
  lapply(FUN = as.integer) %>%
  lapply(FUN = gift_area) %>%
  unlist() %>%
  sum() %>%
  print()

#####PART 2#####
ribbon_len <- function(vec) {
  # perimeter
  vec <- sort(vec)
  peri <- sum(2 * vec[1:2])
  
  # bow
  bow <- prod(vec)
  
  peri + bow
}

gifts %>%
  strsplit(split = "x", fixed = TRUE) %>%
  lapply(FUN = as.integer) %>%
  lapply(FUN = ribbon_len) %>%
  unlist() %>%
  sum() %>%
  print()