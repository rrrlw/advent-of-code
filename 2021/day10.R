#####SETUP#####
library(magrittr)
library(dequer)

#####INPUT#####
fin <- file("day10.in", open = "r")
vals <- readLines(fin) %>%
  strsplit(split = "", fixed = TRUE)
close(fin)

#####UTILITY#####
OPEN <- c("(", "[", "{", "<")
CLOSE<- c(")", "]", "}", ">")
names(OPEN) <- CLOSE
names(CLOSE) <- OPEN
first_mistake <- function(line) {
  s <- stack()
  
  for (i in line) {
    
    if (i %in% OPEN) push(s, i)
    
    else if (i %in% CLOSE) {
      
      last <- pop(s)
      if (OPEN[i] != last) return(i)
      
    } else {
      stop(paste("UNEXPECTED CHAR:", i))
    }
  }
  
  return(" ")
}

complete_str <- function(line) {
  s <- stack()
  
  for (i in line) {
    
    if (i %in% OPEN) push(s, i)
    else if (i %in% CLOSE) pop(s)
    
  }
  
  ans <- ""
  while (length(s) > 0) {
    ans <- paste0(ans, CLOSE[pop(s)])
  }
  
  return(ans)
}

VALS1 <- c(")" = 3, "]" = 57, "}" = 1197, ">" = 25137, " " = 0)
get_points1 <- function(chr) {
  vapply(
    X = chr,
    USE.NAMES = FALSE,
    FUN.VALUE = numeric(1),
    FUN = function(curr) {
      VALS1[curr]
    }
  )
}

VALS2 <- c(")" = 1, "]" = 2, "}" = 3, ">" = 4)
get_points2 <- function(chr) {
  chr <- chr %>%
    strsplit(split = "", fixed = TRUE) %>%
    unlist
  
  counter <- 0
  
  for (i in chr) {
    counter <- counter * 5 + VALS2[i]
  }
  
  return(counter)
}

#####PART 1#####
vals %>%
  lapply(FUN = first_mistake) %>%
  lapply(FUN = get_points1) %>%
  unlist %>%
  sum

#####PART 2#####
incomplete <- lapply(X = vals, FUN = first_mistake) %>%
  unlist %>%
  equals(" ") %>%
  which

vals[incomplete] %>%
  lapply(FUN = complete_str) %>%
  lapply(FUN = get_points2) %>%
  unlist %>%
  median
