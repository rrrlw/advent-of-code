library(magrittr)

#####INPUT#####
fin <- file("day05.in", open = "r")
vals <- readLines(fin) %>%
  strsplit(split = " -> ", fixed = TRUE) %>%
  lapply(FUN = function(str_vec) {
    str_vec %>%
      paste(collapse = ",") %>%
      strsplit(split = ",", fixed = TRUE) %>%
      unlist %>%
      as.integer
  })
close(fin)

#####UTILITY#####
hash_spot <- function(x, y) {
  as.integer(x * 1000000 + y)
}
hash_int <- function(num) {
  c(num / 1000000, num %% 1000000) %>%
    as.integer
}

line_to_spots <- function(x1, y1, x2, y2, part = 1) {
  # vertical line
  if (x1 == x2) {
    y_val <- seq(from = y1, to = y2)
    x_val <- rep(x1, length(y_val))
    return(hash_spot(x_val, y_val))
  
  # horizontal line
  } else if (y1 == y2) {
    x_val <- seq(from = x1, to = x2)
    y_val <- rep(y1, length(x_val))
    return(hash_spot(x_val, y_val))
  
  # diagonal line valid for part 2
  } else if (part == 2) {
    x_val <- seq(from = x1, to = x2)
    y_val <- seq(from = y1, to = y2)
    return(hash_spot(x_val, y_val))
    
  # invalid line for part 1
  } else {
    return(integer(0))
  }
}

#####PART 1#####
curr_spots <- list()
for (i in seq_len(length(vals))) {
  curr_input <- vals[[i]]
  curr_spots[[i]] <- line_to_spots(curr_input[1], curr_input[2],
                                   curr_input[3], curr_input[4])
}
curr_spots %>%
  unlist %>%
  table %>%
  is_greater_than(1) %>%
  sum

#####PART 2#####
curr_spots <- list()
for (i in seq_len(length(vals))) {
  curr_input <- vals[[i]]
  curr_spots[[i]] <- line_to_spots(curr_input[1], curr_input[2],
                                   curr_input[3], curr_input[4],
                                   part = 2)
}
curr_spots %>%
  unlist %>%
  table %>%
  is_greater_than(1) %>%
  sum
