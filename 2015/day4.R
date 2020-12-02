library(digest)
library(magrittr)

#####INPUT#####
fin <- file("day4.in", "r")
val <- readLines(fin)
close(fin)

#####UTILITY FUNCTION(S)#####
first_with_prefix <- function(code, prefix, update = 100000) {
  curr <- 1
  found <- FALSE
  while (!found) {
    curr_msg <- paste0(code, as.character(curr)) %>%
      digest(algo = "md5", serialize = FALSE)
    
    if (startsWith(curr_msg, prefix)) {
      found <- TRUE
    } else {
      curr <- curr + 1
    }
    
    if (curr %% update == 0) {
      print(paste("DONE WITH", curr))
    }
  }
  
  curr
}

#####PART 1#####
val %>%
  first_with_prefix(prefix = "00000") %>%
  print()

#####PART 2#####
val %>%
  first_with_prefix(prefix = "000000") %>%
  print()
