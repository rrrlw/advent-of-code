library(magrittr)

#####INPUT#####
fin <- file("day08.in", open = "r")
input_line <- readLines(fin) %>%
  strsplit(split = " | ", fixed = TRUE) %>%
  lapply(FUN = function(chr) strsplit(chr, split = " ", fixed = TRUE) %>% unlist)
patterns <- input_line %>%
  lapply(FUN = function(chr) chr[1:10])
tester <- input_line %>%
  lapply(FUN = function(chr) chr[11:length(chr)])
close(fin)

#####UTILITY#####
get_wire_pairs <- function(patterns) {
  freq_table <- patterns %>%
    strsplit(split = "") %>%
    unlist %>%
    table
  
  ans <- vector(mode = "character", length = 7L)
  names(ans) <- c("a", "b", "c", "d", "e", "f", "g")
  
  # find b
  ans["b"] <- names(ans)[which(freq_table == 6)]
  
  # find e
  ans["e"] <- names(ans)[which(freq_table == 4)]
  
  # find f
  ans["f"] <- names(ans)[which(freq_table == 9)]
  
  # find c & a
  chrs <- names(ans)[which(freq_table == 8)]
  one_val <- patterns[which(nchar(patterns) == 2)]
  if (chrs[1] %in% unlist(strsplit(one_val, split = "", fixed = TRUE))) {
    ans["c"] <- chrs[1]
    ans["a"] <- chrs[2]
  } else {
    ans["c"] <- chrs[2]
    ans["a"] <- chrs[1]
  }
  
  # find d & g
  chrs <- names(ans)[which(freq_table == 7)]
  seven_val <- patterns[which(nchar(patterns) == 4)]
  if (chrs[1] %in% unlist(strsplit(seven_val, split = "", fixed = TRUE))) {
    ans["d"] <- chrs[1]
    ans["g"] <- chrs[2]
  } else {
    ans["d"] <- chrs[2]
    ans["g"] <- chrs[1]
  }
  
  return(setNames(names(ans), ans))
}

digits <- c("abcefg",   # 0
            "cf",       # 1
            "acdeg",    # 2
            "acdfg",    # 3
            "bcdf",     # 4
            "abdfg",    # 5
            "abdefg",   # 6
            "acf",      # 7
            "abcdefg",  # 8
            "abcdfg")   # 9

get_digit <- function(test_seq, match_pair) {
  split_test <- test_seq %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist
  ans <- match_pair[split_test] %>%
    sort %>%
    paste(collapse = "")
  
  as.integer(which(digits == ans) - 1)
}

#####PART 1#####
counts <- rep(0, 10)
names(counts) <- as.character(0:9)
tmp_del <- lapply(
  X = seq_len(length(input_line)),
  FUN = function(i) {
    match_pair <- get_wire_pairs(patterns[[i]])
    digits <- vapply(tester[[i]],
                     USE.NAMES = FALSE,
                     FUN.VALUE = integer(1),
                     FUN = function(i) get_digit(i, match_pair)) %>%
      as.character
    freq <- table(digits)
    counts[digits] <<- counts[digits] + freq[digits]
    return(0L)
  }
)

counts[c("1", "4", "7", "8")] %>%
  sum %>%
  print

#####PART 2#####
lapply(
  X = seq_len(length(input_line)),
  FUN = function(i) {
    match_pair <- get_wire_pairs(patterns[[i]])
    digits <- vapply(tester[[i]],
                     USE.NAMES = FALSE,
                     FUN.VALUE = integer(1),
                     FUN = function(i) get_digit(i, match_pair)) %>%
      as.character %>%
      paste(collapse = "") %>%
      as.integer
  }
) %>%
  unlist %>%
  sum
