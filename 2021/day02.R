library(magrittr)

#####INPUT#####
fin <- file("day02.in", open = "r")
vals <- readLines(fin) %>% strsplit(split = " ", fixed = TRUE)
close(fin)

#####PART 1#####
pos <- rep(0, 2)
for (moves in vals) {
  curr_val <- as.integer(moves[2])
  pos <- pos + switch(moves[1],
                      forward = c(curr_val, 0),
                      down = c(0, curr_val),
                      up = c(0, -curr_val))
}
print(prod(pos))

#####PART 2#####
pos <- rep(0, 3)
for (moves in vals) {
  curr_val <- as.integer(moves[2])
  pos <- pos + switch(moves[1],
                      forward = c(curr_val, curr_val * pos[3], 0),
                      down = c(0, 0, curr_val),
                      up = c(0, 0, -curr_val))
}
print(prod(pos[1:2]))
