library(magrittr)
library(dplyr)

#####UTILITY#####
binvec_to_b10 <- function(bin_vec) {
  bin_vec %>%
    as.character %>%
    paste(collapse = "") %>%
    strtoi(base = 2L)
}

filter_step_o2 <- function(df, pos) {
  df %>%
    filter(.[[pos]] == as.integer(median(.[[pos]] + 0.5)))
}

filter_step_co2 <- function(df, pos) {
  df %>%
    filter(.[[pos]] == as.integer(1 - median(.[[pos]])))
}

get_o2_rating <- function(df) {
  for (pos in seq_len(ncol(df))) {
    df <- filter_step_o2(df, pos)
    if (nrow(df) <= 1) break
  }
  binvec_to_b10(df)
}

get_co2_rating <- function(df) {
  for (pos in seq_len(ncol(df))) {
    df <- filter_step_co2(df, pos)
    if (nrow(df) <= 1) break
  }
  binvec_to_b10(df)
}

#####INPUT#####
fin <- file("day03.in", open = "r")
vals <- readLines(fin)
single_len <- nchar(vals[1])
vals <- vals %>%
  strsplit("", fixed = TRUE) %>%
  unlist %>%
  as.integer %>%
  matrix(ncol = single_len, byrow = TRUE)
close(fin)

#####PART 1#####
gamma_vec <- apply(X = vals, MARGIN = 2, FUN = median)
eps_vec <- 1 - gamma_vec
print(binvec_to_b10(gamma_vec) * binvec_to_b10(eps_vec))

#####PART 2#####
vals_df <- as.data.frame(vals)
print(get_o2_rating(vals_df) * get_co2_rating(vals_df))
