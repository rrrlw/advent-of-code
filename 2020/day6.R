library(magrittr)

#####INPUT#####
fin <- file("day6.in", "r")
choices <- readLines(fin)
close(fin)

#####UTILITY FUNCTIONS#####
split_parts <- function(choices) {
  choices %>%
    paste(collapse = "\n") %>%
    strsplit(split = "\n\n", fixed = TRUE) %>%
    unlist() %>%
    as.list() %>%
    lapply(FUN = function(curr) {
      strsplit(curr, split = "\n", fixed = TRUE)[[1]]
    })
}
anyone <- function(vec) {
  vec %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist() %>%
    unique() %>%
    length()
}
everyone <- function(vec) {
  freqs <- vec %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist() %>%
    table()
  
  freqs[freqs == length(vec)] %>%
    length()
}

#####PART 1#####
split_parts(choices) %>%
  lapply(FUN = anyone) %>%
  unlist() %>%
  sum() %>%
  print()

#####PART 2#####
split_parts(choices) %>%
  lapply(FUN = everyone) %>%
  unlist() %>%
  sum() %>%
  print()
