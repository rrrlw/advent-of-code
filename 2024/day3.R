# setup
library(tidyverse)
library(stringr)

# input
input <- paste0(readLines("day3.in"), collapse = "")

#####PART 1#####
# process
matches <- str_extract_all(input, "mul\\(\\d{1,3},\\d{1,3}\\)")
counter <- 0

for (i in 1:length(matches[[1]])) {
  num_matches <- str_extract_all(matches[[1]][i], "\\d{1,3}")
  
  num1 <- as.integer(num_matches[[1]][1])
  num2 <- as.integer(num_matches[[1]][2])
  
  counter <- counter + (num1 * num2)
}

# output
print(counter)

#####PART 2#####
# process
matches_index <- str_locate_all(input, "mul\\(\\d{1,3},\\d{1,3}\\)")[[1]] %>%
  as.data.frame %>%
  mutate(val = matches[[1]],
         do = 1)

do_matches <- str_locate_all(input, "do\\(\\)")[[1]]
dont_matches <- str_locate_all(input, "don't\\(\\)")[[1]]
for (i in 1:nchar(input)) {
  if (i %in% do_matches[,1]) {
    matches_index[matches_index$start > i, ]$do <- 1
  } else if (i %in% dont_matches[,1]) {
    matches_index[matches_index$start > i, ]$do <- 0
  }
}

matches_index <- matches_index %>%
  mutate(val = gsub(pattern = "(mul\\(|\\))", replacement = "", x = val)) %>%
  separate_wider_delim(cols = val, delim = ",", names = c("num1", "num2")) %>%
  mutate(num1 = as.integer(num1),
         num2 = as.integer(num2),
         prod = num1 * num2 * do)

# output
matches_index %>%
  pull(prod) %>%
  sum %>%
  print
