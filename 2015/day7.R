library(magrittr)

#####INPUT#####
fin <- file("day7.in", "r")
commands <- readLines(fin)
close(fin)
vals <- integer(0)

#####UTILITY FUNCTIONS#####
digits_only <- function(chr) {
  gsub(x = chr,
       pattern = "[^0-9]",
       replacement = "")
}
alpha_only <- function(chr) {
  gsub(x = chr,
       pattern = "[^a-z]",
       replacement = "")
}
split_store <- function(command) {
  command %>%
    strsplit(split = " -> ") %>%
    unlist()
}
store_into <- function(val, var_name) {
  if (val < 0) { val <- val + 65536}
  vals[var_name] <<- val
}
process <- function(command) {
  parts <- split_store(command)
  store_into(val = eval_first(parts[1]),
             var_name = parts[2])
}
eval_first <- function(first) {
  if (grepl(x = first, pattern = " AND ", fixed = TRUE)) {
    do_and(first)
  } else if (grepl(x = first, pattern = " OR ", fixed = TRUE)) {
    do_or(first)
  } else if (grepl(x = first, pattern = "NOT ", fixed = TRUE)) {
    do_not(first)
  } else if (grepl(x = first, pattern = " LSHIFT ", fixed = TRUE)) {
    do_lshift(first)
  } else if (grepl(x = first, pattern = " RSHIFT ", fixed = TRUE)) {
    do_rshift(first)
  } else if (digits_only(first) == first) {
    as.integer(digits_only(first))
  } else if (alpha_only(first) == first) {
    as.integer(vals[first])
  }
}
eval_val <- function(val) {
  ans <- integer(length(val))
  for (i in seq_along(val)) {
    if (digits_only(val[i]) == val[i]) {
      ans[i] <- as.integer(val[i])
    } else {
      ans[i] <- vals[val[i]]
    }
  }
  as.integer(ans)
}
do_and <- function(first) {
  parts <- first %>%
    strsplit(split = " AND ", fixed = TRUE) %>%
    unlist() %>%
    eval_val()
  
  bitwAnd(parts[1], parts[2])
}
do_or <- function(first) {
  parts <- first %>%
    strsplit(split = " OR ", fixed = TRUE) %>%
    unlist() %>%
    eval_val()
  
  bitwOr(parts[1], parts[2])
}
do_lshift <- function(first) {
  parts <- first %>%
    strsplit(split = " LSHIFT ", fixed = TRUE) %>%
    unlist() %>%
    eval_val()
  
  bitwShiftL(parts[1], parts[2])
}
do_rshift <- function(first) {
  parts <- first %>%
    strsplit(split = " RSHIFT ", fixed = TRUE) %>%
    unlist() %>%
    eval_val()
  
  bitwShiftR(parts[1], parts[2])
}
do_not <- function(first) {
  part <- first %>%
    gsub(pattern = "NOT ", replacement = "", fixed = TRUE) %>%
    eval_val()
  
  bitwNot(part)
}

vars_only <- function(splits) {
  splits[alpha_only(splits) == splits]
}
all_vars_there <- function(command) {
  var_names <- command %>%
    gsub(pattern = " ->.*", replacement = "") %>%
    strsplit(split = " ", fixed = TRUE) %>%
    unlist() %>%
    vars_only()
  
  return(all(var_names %in% names(vals)))
}

#####PART 1#####
i <- 1
while (length(commands) > 0) {
  if (all_vars_there(commands[i])) {
    process(commands[i])
    commands <- commands[-i]
    if (i > length(commands)) i <- 1
  } else {
    i <- i + 1
    if (i > length(commands)) i <- 1
  }
}
ans_part1 <- vals["a"]
print(ans_part1)

#####PART 2#####
fin <- file("day7.in", "r")
commands <- readLines(fin)
close(fin)
vals <- integer(0)

i <- 1
while (length(commands) > 0) {
  # reset b if necessary
  if (endsWith(commands[i], "-> b")) {
    process(paste(ans_part1, "-> b"))
    commands <- commands[-i]
  } else if (all_vars_there(commands[i])) {
    process(commands[i])
    commands <- commands[-i]
    if (i > length(commands)) i <- 1
  } else {
    i <- i + 1
    if (i > length(commands)) i <- 1
  }
}
print(vals["a"])