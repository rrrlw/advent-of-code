#####SETUP#####
library(tidyverse)

#####UTILITY FUNCTIONS#####
# necessary conversion for part 1
count_actual_chars <- function(str_val) {
  # remove first and last characters (quotes)
  str_replace(string = str_val, pattern = "^\"", replacement = "") %>%
    str_replace(pattern = "\"$", replacement = "") %>%
    # replace escaped characters with single char
    str_replace_all(pattern = "\\\\\\\\",
                    replacement = "z") %>%
    str_replace_all(pattern = "\\\\\\\"",
                    replacement = "z") %>%
    # replace hex characters with single char
    str_replace_all(pattern = "\\\\x[0-9a-f]{2}",
                    replacement = "z") %>%
    # return length of modified str
    nchar
}

# convenience function for part 1
calc_char_diff <- function(str_val) {
  nchar(str_val) - count_actual_chars(str_val)
}

# necessary conversion for part 2
count_inverse_actual_chars <- function(str_val) {
  # replace backslashes and quotes with additional chars
  str_replace_all(string = str_val, pattern = "\\\\", replacement = "\\\\\\\\") %>%
    str_replace_all(pattern = "\"", replacement = "\\\\\"") %>%
    # get length of modified string
    nchar %>%
    # account for additional outside double quotes at start & end
    magrittr::add(2)
}

# convenience function for part 2
calc_inverse_char_diff <- function(str_val) {
  count_inverse_actual_chars(str_val) - nchar(str_val)
}

#####PART 1#####
# input
input_str <- readLines("day8.in")

# process
ans1 <- vapply(X = input_str,
               FUN = calc_char_diff,
               FUN.VALUE = integer(1),
               USE.NAMES = FALSE) %>%
  sum

# output
print(paste("Part 1:", ans1))

#####PART 2#####
# process (input same as part 1)
ans2 <- vapply(X = input_str,
               FUN = calc_inverse_char_diff,
               FUN.VALUE = double(1),
               USE.NAMES = FALSE) %>%
  sum

# output
print(paste("Part 2:", ans2))