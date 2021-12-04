library(magrittr)

#####INPUT#####
fin <- file("day04.in", open = "r")
vals <- readLines(fin) %>%
  paste(collapse = "\n") %>%
  strsplit(split = "\n\n", fixed = TRUE) %>%
  unlist
nums <- vals[1] %>%
  strsplit(split = ",", fixed = TRUE) %>%
  unlist %>%
  as.integer
boards <- vals[2:length(vals)] %>%
  strsplit(split = "[\n ]+") %>%
  lapply(FUN = as.integer) %>%
  lapply(FUN = function(a) a <- a[!is.na(a)])
close(fin)

#####UTILITY#####
INFINITY <- 1e9
board_turns <- function(board) {
  ans <- rep(INFINITY, 25)
  
  for (i in seq_len(length(nums))) {
    if (nums[i] %in% board) {
      ans[which(board == nums[i])] <- i
    }
  }
  
  ans
}

horiz_win_min_turns <- function(board_turns) {
  ans <- INFINITY
  for (i in seq(from = 1, to = 25, by = 5)) {
    curr_row <- seq(from = i, to = i + 4, by = 1)
    curr_turns <- max(board_turns[curr_row])
    if (curr_turns < ans) ans <- curr_turns
  }
  ans
}
vert_win_min_turns <- function(board_turns) {
  ans <- INFINITY
  for (i in 1:5) {
    curr_col <- seq(from = i, to = 25, by = 5)
    curr_turns <- max(board_turns[curr_col])
    if (curr_turns < ans) ans <- curr_turns
  }
  ans
}

board_score_turns <- function(board) {
  turns <- board_turns(board)
  num_turns <- min(horiz_win_min_turns(turns), vert_win_min_turns(turns))
  score <- board[which(turns == num_turns)] * sum(board[which(turns > num_turns)])
  c(num_turns, score)
}

#####PART 1#####
mins <- rep(INFINITY, 2)
calc <- lapply(boards, board_score_turns)
for (i in calc) {
  if (i[1] < mins[1]) mins <- i
}
print(mins[2])

#####PART 2#####
maxs <- rep(0, 2)
for (i in calc) {
  if (i[1] > maxs[1]) maxs <- i
}
print(maxs[2])