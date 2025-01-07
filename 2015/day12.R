#####SETUP#####
library(tidyverse)

#####UTILITY#####
# setup pattern for number
num_pattern <- "-{0,1}[0-9]+"

# extract all number matches
extract_nums <- function(str) {
  str_match_all(string = str,
                pattern = num_pattern)
}

# get sum of all extracted numbers
sum_extracted_nums <- function(extract_nums) {
  # convert to simple vector & return numeric sum
  extract_nums %>%
    unlist %>%
    as.numeric %>%
    sum
}

#####PART 1#####
# get input
input_vals <- readLines("day12.in")

# process
answer <- input_vals %>%
  extract_nums %>%
  sum_extracted_nums

# output
print(answer)

#####PART 2#####
