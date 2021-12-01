#####INPUT#####
fin <- file("day1.in", open = "r")
vals <- as.integer(readLines(fin))
close(fin)

#####PART 1#####
sum(diff(vals) > 0)

#####PART 2#####
sum(diff(vals, lag = 3) > 0)