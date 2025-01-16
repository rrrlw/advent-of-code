#####SETUP#####
# libraries
library(tidyverse)

# get info about all aunts
aunt_data <- readLines("day16.in")
aunt_df <- data.frame(children = integer(0),
                      cats = integer(0),
                      samoyeds = integer(0),
                      pomeranians = integer(0),
                      akitas = integer(0),
                      vizslas = integer(0),
                      goldfish = integer(0),
                      trees = integer(0),
                      cars = integer(0),
                      perfumes = integer(0))

matched_vals <- str_extract_all(string = aunt_data,
                                pattern = "[a-z]+: [0-9]+")

# put into data frame for easy filtering later
for (i in seq_along(aunt_data)) {
  curr_vals <- matched_vals[[i]] %>%
    unlist %>%
    str_extract(pattern = "[a-z]+") %>%
    unlist
  
  num_vals <- matched_vals[[i]] %>%
    unlist %>%
    str_extract(pattern = "[0-9]+") %>%
    unlist
  
  for (j in seq_along(curr_vals)) {
    aunt_df[i, curr_vals[j]] <- num_vals[j]
  }
}

#####PART 1#####
# Part 1: identify correct row given info provided in problem
# children: 3
# cats: 7
# samoyeds: 2
# pomeranians: 3
# akitas: 0
# vizslas: 0
# goldfish: 5
# trees: 3
# cars: 2
# perfumes: 1
aunt_df %>%
  mutate(aunt_num = 1:nrow(aunt_df)) %>%
  filter(is.na(children) | children == 3) %>%
  filter(is.na(cats) | cats == 7) %>%
  filter(is.na(samoyeds) | samoyeds == 2) %>%
  filter(is.na(pomeranians) | pomeranians == 3) %>%
  filter(is.na(akitas) | akitas == 0) %>%
  filter(is.na(vizslas) | vizslas == 0) %>%
  filter(is.na(goldfish) | goldfish == 5) %>%
  filter(is.na(trees) | trees == 3) %>%
  filter(is.na(cars) | cars == 2) %>%
  filter(is.na(perfumes) | perfumes == 1) %>%
  pull(aunt_num) %>%
  paste0(" Sue (part 1)")

#####PART 2#####
# Part 2: identify correct row given info provided in problem
# children: 3
# cats > 7
# samoyeds: 2
# pomeranians < 3
# akitas: 0
# vizslas: 0
# goldfish < 5
# trees > 3
# cars: 2
# perfumes: 1
aunt_df %>%
  mutate(aunt_num = 1:nrow(aunt_df)) %>%
  filter(is.na(children) | children == 3) %>%
  filter(is.na(cats) | cats > 7) %>%
  filter(is.na(samoyeds) | samoyeds == 2) %>%
  filter(is.na(pomeranians) | pomeranians < 3) %>%
  filter(is.na(akitas) | akitas == 0) %>%
  filter(is.na(vizslas) | vizslas == 0) %>%
  filter(is.na(goldfish) | goldfish < 5) %>%
  filter(is.na(trees) | trees > 3) %>%
  filter(is.na(cars) | cars == 2) %>%
  filter(is.na(perfumes) | perfumes == 1) %>%
  pull(aunt_num) %>%
  paste0(" Sue (part 2)")
