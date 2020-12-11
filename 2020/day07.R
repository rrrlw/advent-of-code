library(magrittr)

#####INPUT#####
fin <- file("day7.in", "r")
rules <- readLines(fin) %>%
  gsub(pattern = ".", replacement = "", fixed = TRUE)
close(fin)

#####UTILITY FUNCTIONS#####
process_rules <- function(rule) {
  rule_list <- list()
  
  parts <- rule %>%
    strsplit(split = " contain ", fixed = TRUE)
  
  for (curr_rule in parts) {
    container <- curr_rule[1] %>%
      gsub(pattern = " bags", replacement = "", fixed = TRUE)
    
    contents <- curr_rule[2] %>%
      strsplit(split = ", ", fixed = TRUE) %>%
      unlist() %>%
      gsub(pattern = " bags{0,1}", replacement = "") %>%
      gsub(pattern = "[0-9]+ ", replacement = "") %>%
      subset(. != "no other")
    
    rule_list[[container]] <- contents
  }
  
  rule_list
}

memoize <- logical(0)
contains <- function(container, content, rule_list) {
  if (container %in% names(memoize)) {
    
  } else if (content %in% rule_list[[container]]) {
    memoize[container] <<- TRUE
  
  } else {
    ans <- FALSE
    for (curr_content in rule_list[[container]]) {
      ans <- or(ans, contains(curr_content, content, rule_list))
    }
    memoize[container] <<- ans
  }
  
  return(memoize[container])
}

get_num <- function(content) {
  gsub(content,
       pattern = "[^0-9]+",
       replacement = "") %>%
    as.integer()
}

without_num <- function(content) {
  gsub(content,
       pattern = "[0-9]+ ",
       replacement = "")
}

process_num <- function(rules) {
  num_list <- list()
  
  parts <- rules %>%
    strsplit(split = " contain ", fixed = TRUE)
  
  for (curr_rule in parts) {
    container <- curr_rule[1] %>%
      gsub(pattern = " bags", replacement = "", fixed = TRUE)
    
    contents <- curr_rule[2] %>%
      strsplit(split = ", ", fixed = TRUE) %>%
      unlist() %>%
      gsub(pattern = " bags{0,1}", replacement = "")
    
    curr_contents <- data.frame(
      Num = get_num(contents),
      Type = without_num(contents)
    )
    
    num_list[[container]] <- curr_contents
  }
  
  num_list
}

memoize_num <- integer(0)
bags_in <- function(container, num_list) {
  if (container %in% names(memoize_num)) {
    
  } else {
    ans <- 1
    go_thru <- num_list[[container]]
    
    for (i in seq_len(nrow(go_thru))) {
      if (is.na(go_thru$Num[i])) next
      
      ans <- ans + go_thru$Num[i] * bags_in(go_thru$Type[i], num_list)
    }
    memoize_num[container] <<- ans
  }
  
  return(memoize_num[container])
}

#####PART 1#####
rule_list <- process_rules(rules)
counter <- 0
bag_types <- names(rule_list)
for (curr_bag in bag_types) {
  if (contains(curr_bag, "shiny gold", rule_list)) {
    counter <- counter + 1
  }
}
print(counter)

#####PART 2#####
num_list <- process_num(rules)
bags_in("shiny gold", num_list) %>%
  subtract(1) %>% # the bag itself doesn't count
  print()
