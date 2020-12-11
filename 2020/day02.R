library(magrittr)

#####UTILITY FUNCTIONS#####
get_params <- function(line) {
  params <- gsub(pattern = "[^0-9a-z]", replacement = " ", x = line) %>%
    strsplit(split = " ", fixed = TRUE) %>%
    unlist()
  
  list(min = as.integer(params[1]),
       max = as.integer(params[2]),
       let = params[3],
       pass= params[5])
}

valid_first <- function(line) {
  params <- get_params(line)
  freqs <- params$pass %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist() %>%
    table()
  
  as.logical(freqs[params$let] >= params$min & freqs[params$let] <= params$max)
}

valid_second <- function(line) {
  params <- get_params(line)
  
  num_appear <- params$pass %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist() %>%
    extract(c(params$min, params$max)) %>%
    equals(params$let) %>%
    sum(na.rm = TRUE)
  
  num_appear == 1
}

#####INPUT#####
fin <- file("day2.in", "r")
passwords <- readLines(fin)
close(fin)

#####PART 1#####
vapply(X = passwords,
       FUN.VALUE = logical(1),
       FUN = valid_first) %>%
  sum(na.rm = TRUE) %>%
  print()

#####PART 2#####
vapply(X = passwords,
       FUN.VALUE = logical(1),
       FUN = valid_second) %>%
  sum(na.rm = TRUE) %>%
  print()
