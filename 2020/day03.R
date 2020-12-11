library(magrittr)

#####INPUT#####
fin <- file("day3.in", "r")
tree_map <- readLines(fin)
close(fin)

#####PART 1#####
next_loc <- function(loc, slope, grid_w) {
  loc <- loc + slope
  
  while (loc[1] > grid_w) {
    loc[1] <- loc[1] - grid_w
  }
  
  loc
}
get_tree_count <- function(grid, start, slope) {
  grid_width <- nchar(grid[1])
  curr_loc <- start
  counter <- 0
  while (curr_loc[2] <= length(grid)) {
    # see if tree in current spot
    if (substr(grid[curr_loc[2]], curr_loc[1], curr_loc[1]) == "#") {
      counter <- counter + 1
    }
    
    # move
    curr_loc <- next_loc(curr_loc, slope, grid_width)
  }
  
  counter
}

get_tree_count(tree_map, c(1, 1), c(3, 1)) %>%
  print()

#####PART 2#####
prod(get_tree_count(tree_map, c(1, 1), c(1, 1)),
     get_tree_count(tree_map, c(1, 1), c(3, 1)),
     get_tree_count(tree_map, c(1, 1), c(5, 1)),
     get_tree_count(tree_map, c(1, 1), c(7, 1)),
     get_tree_count(tree_map, c(1, 1), c(1, 2))) %>%
  print()
