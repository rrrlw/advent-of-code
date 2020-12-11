library(magrittr)

#####INPUT#####
fin <- file("day8.in", "r")
commands <- readLines(fin)
close(fin)
done <- length(commands) %>%
  logical()
accumulate <- 0
curr_line <- 1

#####UTILITY FUNCTIONS#####
nop <- function(line_num) {
  if (done[line_num]) {
    -1
  } else {
    done[line_num] <<- TRUE
    line_num + 1
  }
}
acc <- function(line_num, val) {
  if (done[line_num]) {
    -1
  } else {
    done[line_num] <<- TRUE
    accumulate <<- accumulate + val
    line_num + 1
  }
}
jmp <- function(line_num, val) {
  if (done[line_num]) {
    -1
  } else {
    done[line_num] <<- TRUE
    line_num + val
  }
}
process <- function(command) {
  parts <- command %>%
    strsplit(split = " ", fixed = TRUE) %>%
    unlist()
  
  instruct <- parts[1]
  val <- as.integer(parts[2])
  switch(instruct,
         `nop` = nop(curr_line),
         `acc` = acc(curr_line, val),
         `jmp` = jmp(curr_line, val))
}
do_all <- function(commands) {
  # run
  while (curr_line != -1 & curr_line <= length(commands)) {
    curr_line <<- process(commands[curr_line])
  }
  
  # return status and answer
  return(
    list(status = (curr_line != -1),
         accum = accumulate)
  )
}
switch_comm <- function(line_num) {
  if (startsWith(commands[line_num], "jmp")) {
    gsub(commands[line_num],
         pattern = "jmp",
         replacement = "nop",
         fixed = TRUE)
  } else if (startsWith(commands[line_num], "nop")) {
    gsub(commands[line_num],
         pattern = "nop",
         replacement = "jmp",
         fixed = TRUE)
  } else {
    commands[line_num]
  }
}

#####PART 1#####
do_all(commands)

#####PART 2#####
for (line_num in seq_along(commands)) {
  # reset counters
  accumulate <- 0
  curr_line <- 1
  done <- length(commands) %>%
    logical()
  
  commands[line_num] <- switch_comm(line_num)
  
  ans <- do_all(commands)
  if (ans$status) {
    print(ans$accum)
    break
  }
  
  commands[line_num] <- switch_comm(line_num)
}
