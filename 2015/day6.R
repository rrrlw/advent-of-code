library(magrittr)

#####INPUT#####
fin <- file("day6.in", "r")
commands <- readLines(fin)
close(fin)
grid <- NULL

#####UTILITY FUNCTIONS#####
toggle <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- !grid[start[1]:end[1], start[2]:end[2]]
}

turn_on <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- TRUE
}

turn_off <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- FALSE
}

toggle2 <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- grid[start[1]:end[1], start[2]:end[2]] + 2
}
turn_on2 <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- grid[start[1]:end[1], start[2]:end[2]] + 1
}
turn_off2 <- function(start, end) {
  grid[start[1]:end[1], start[2]:end[2]] <<- grid[start[1]:end[1], start[2]:end[2]] - 1
  grid[grid < 0] <<- 0
}

extract_loc <- function(command) {
  command %>%
    gsub(pattern = "turn on ", replacement = "", fixed = TRUE) %>%
    gsub(pattern = "turn off ", replacement = "", fixed = TRUE) %>%
    gsub(pattern = "toggle ", replacement = "", fixed = TRUE) %>%
    gsub(pattern = "through ", replacement = "", fixed = TRUE) %>%
    strsplit(split = " ", fixed = TRUE) %>%
    unlist() %>%
    strsplit(split = ",", fixed = TRUE) %>%
    unlist() %>%
    as.integer() %>%
    add(1)
}

#####PART 1#####
grid <- matrix(FALSE, nrow = 1000, ncol = 1000)
for (curr in commands) {
  locs <- extract_loc(curr)
  
  if (startsWith(curr, "toggle")) {
    toggle(locs[1:2], locs[3:4])
  } else if (startsWith(curr, "turn on")) {
    turn_on(locs[1:2], locs[3:4])
  } else if (startsWith(curr, "turn off")) {
    turn_off(locs[1:2], locs[3:4])
  }
}
grid %>%
  sum() %>%
  print()

#####PART 2#####
grid <- matrix(0L, nrow = 1000, ncol = 1000)
for (curr in commands) {
  locs <- extract_loc(curr)
  
  if (startsWith(curr, "toggle")) {
    toggle2(locs[1:2], locs[3:4])
  } else if (startsWith(curr, "turn on")) {
    turn_on2(locs[1:2], locs[3:4])
  } else if (startsWith(curr, "turn off")) {
    turn_off2(locs[1:2], locs[3:4])
  }
}
grid %>%
  sum() %>%
  print()
