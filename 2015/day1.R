library("magrittr")

#####INPUT#####
fin <- file("day1.in", "r")
input <- readLines(fin)
close(fin)

#####PART 1#####
input %>%
  strsplit("", fixed = TRUE) %>%
  unlist() %>%
  gsub(pattern = "(", replacement = "1", fixed = TRUE) %>%
  gsub(pattern = ")", replacement = "-1", fixed = TRUE) %>%
  as.integer() %>%
  sum() %>%
  print()

#####PART 2#####
min_neg <- function(vec) {which(vec < 0) %>% min()}
input %>%
  strsplit("", fixed = TRUE) %>%
  unlist() %>%
  gsub(pattern = "(", replacement = "1", fixed = TRUE) %>%
  gsub(pattern = ")", replacement = "-1", fixed = TRUE) %>%
  as.integer() %>%
  cumsum() %>%
  min_neg() %>%
  print()
