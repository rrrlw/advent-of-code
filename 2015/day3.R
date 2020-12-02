library(magrittr)

#####INPUT#####
fin <- file("day3.in", "r")
directions <- readLines(fin)
close(fin)

#####PART 1#####
hash <- function(x, y) {as.integer(10000 * x + y)}
unhash <- function(loc) { # this function not actually used
  val <- loc / 10000
  x <- round(val)
  y <- 10000 * (val - x)
  
  c(x, y) %>%
    as.integer()
}

houses_visited <- function(moves) {
  curr_x <- 0
  curr_y <- 0
  locs <- vapply(X = moves,
                 FUN.VALUE = integer(1),
                 FUN = function(curr_move) {
                   curr_x <<- curr_x + switch(curr_move,
                                              `<` = -1,
                                              `>` = 1,
                                              0)
                   
                   curr_y <<- curr_y + switch(curr_move,
                                              `^` = 1,
                                              `v` = -1,
                                              0)
                   
                   hash(curr_x, curr_y)
                 })
  
  no_dup <- unique(locs)
  if (0 %in% no_dup) {
    no_dup
  } else {
    c(0, no_dup)
  }
}

directions %>%
  strsplit(split = "", fixed = TRUE) %>%
  unlist() %>%
  houses_visited() %>%
  length() %>%
  print()

#####PART 2#####
directions <- directions %>%
  strsplit(split = "", fixed = TRUE) %>%
  unlist()

santa_index <- seq(from = 1, to = length(directions), by = 2)

santa_houses <- directions[santa_index] %>%
  houses_visited()
robo_houses <- directions[-santa_index] %>%
  houses_visited()

unique(c(santa_houses, robo_houses)) %>%
  length() %>%
  print()
