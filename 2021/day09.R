library(magrittr)

#####INPUT#####
fin <- file("day09.in", open = "r")
vals <- readLines(fin)
nrow <- length(vals)
ncol <- nchar(vals[1])
vals <- vals %>%
  strsplit(split = "", fixed = TRUE) %>%
  unlist %>%
  as.integer %>%
  matrix(ncol = ncol, byrow = TRUE)
close(fin)

#####UTILITY#####
find_low <- function(mat) {
  ans <- list()
  counter <- 1
  for (i in seq_len(nrow(mat))) {
    for (j in seq_len(ncol(mat))) {
      # check left
      if (j > 1 && mat[i, j] >= mat[i, j - 1]) next
      
      # check right
      if (j < ncol(mat) && mat[i, j] >= mat[i, j + 1]) next
      
      # check up
      if (i > 1 && mat[i, j] >= mat[i - 1, j]) next
      
      # check down
      if (i < nrow(mat) && mat[i, j] >= mat[i + 1, j]) next
      
      # made it so far - add to list of low points
      ans[[counter]] <- c(i, j)
      counter <- counter + 1
    }
  }
  return(ans)
}

mark_basin <- function(mat, loc, val) {
  mat[loc[1], loc[2]] <- val
  
  # check left
  if (loc[2] > 1 && mat[loc[1], loc[2] - 1] < 9) {
    mat <- mark_basin(mat, c(loc[1], loc[2] - 1), val)
  }
  
  # check right
  if (loc[2] < ncol(mat) && mat[loc[1], loc[2] + 1] < 9) {
    mat <- mark_basin(mat, c(loc[1], loc[2] + 1), val)
  }
  
  # check up
  if (loc[1] > 1 && mat[loc[1] - 1, loc[2]] < 9) {
    mat <- mark_basin(mat, c(loc[1] - 1, loc[2]), val)
  }
  
  # check down
  if (loc[1] < nrow(mat) && mat[loc[1] + 1, loc[2]] < 9) {
    mat <- mark_basin(mat, c(loc[1] + 1, loc[2]), val)
  }
  
  return(mat)
}

#####PART 1#####
low_points <- vals %>%
  find_low

low_points %>%
  lapply(FUN = function(curr) vals[curr[1], curr[2]] + 1) %>%
  unlist %>%
  sum

#####PART 2#####
counter <- 100
for (i in low_points) {
  vals <- mark_basin(vals, i, counter)
  counter <- counter + 1
}

vals[vals != 9] %>%
  as.integer %>%
  table %>%
  sort(decreasing = TRUE) %>%
  head(n = 3) %>%
  prod
