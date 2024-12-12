#####SETUP#####
# libraries
library(tidyverse)

# input file name (change for test data to actual input data)
input_file <- "day5.in"

# utility functions
first_index_of <- function(val, vec) {
  search_val <- which(val == vec)
  
  if (length(search_val) > 0) return(search_val[1])
  else return(NA)
}

get_indices <- function(vec_find, vec_in) {
  vapply(X = vec_find,
         FUN = function(val) first_index_of(val, vec_in),
         FUN.VALUE = integer(1),
         USE.NAMES = FALSE)
}

#####PART 1#####
# input
con <- file(input_file, "r")
temp <- readLines(con)
blank_index <- which(temp == "")
n_rows <- length(temp)
close(con)

input_order <- read.delim(input_file, header = FALSE, nrows = blank_index - 1, sep = "|") %>%
  as_tibble %>%
  rename(before = V1, after = V2)

# process
counter <- 0
for (curr_row in seq(from = blank_index + 1, to = n_rows)) {
  # get input row
  curr_input <- temp[curr_row] %>%
    strsplit(split = ",", fixed = TRUE) %>%
    unlist %>%
    as.integer
  curr_len <- length(curr_input)
  
  # calculate indices
  curr_df <- input_order %>%
    mutate(Before_Ind = get_indices(before, curr_input),
           After_Ind = get_indices(after, curr_input)) %>%
    filter(!is.na(Before_Ind)) %>%
    filter(!is.na(After_Ind)) %>%
    filter(Before_Ind > After_Ind)
  
  # check if any violations
  if (nrow(curr_df) > 0) next
  
  # if no violations, add to counter
  counter <- counter + curr_input[ceiling(curr_len / 2)]
}

# output
print(counter)
