library(magrittr)
library(dplyr)
library(stringr)

#####INPUT#####
fin <- file("day5.in", "r")
df_str <- data.frame(Val = readLines(fin))
close(fin)

#####UTILITY FUNCTIONS#####
num_vowels <- function(chr) {
  strsplit(chr, split = "", fixed = TRUE) %>%
    lapply(FUN = function(curr_chr) {
      grep(curr_chr, pattern = "[aeiou]") %>%
        length()
    }) %>%
    unlist()
}

double_letter <- function(chr) {
  grepl(chr, pattern = "(.)\\1")
}

forbidden <- function(chr) {
  grepl(chr, pattern = "(ab|cd|pq|xy)")
}

pair_twice <- function(chr) {
  str_detect(chr, pattern = "(..).*\\1")
}

single_middle_repeat <- function(chr) {
  str_detect(chr, pattern = "(.).\\1")
}

#####PART 1#####
df_str %>%
  filter(num_vowels(Val) >= 3 & double_letter(Val) & !forbidden(Val)) %>%
  nrow() %>%
  print()

#####PART 2#####
df_str %>%
  filter(pair_twice(Val) & single_middle_repeat(Val)) %>%
  nrow() %>%
  print()