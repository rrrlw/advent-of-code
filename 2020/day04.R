library(magrittr)

#####INPUT#####
fin <- file("day4.in", "r")
dataset <- readLines(fin)
close(fin)

#####PART 1#####
valid_passport <- function(pass_data) {
  grepl(x = pass_data, pattern = "byr:") &
    grepl(x = pass_data, pattern = "iyr:") &
    grepl(x = pass_data, pattern = "eyr:") &
    grepl(x = pass_data, pattern = "hgt:") &
    grepl(x = pass_data, pattern = "hcl:") &
    grepl(x = pass_data, pattern = "ecl:") &
    grepl(x = pass_data, pattern = "pid:")
}

curr_pass <- ""
curr_line <- 1
dataset <- c(dataset, "")
counter <- 0
while (curr_line <= length(dataset)) {
  # update current passport info
  curr_pass <- paste(curr_pass, dataset[curr_line])
    
  # end of current info - evaluate
  if (dataset[curr_line] == "") {
    if (valid_passport(curr_pass)) {
      counter <- counter + 1
    }
    curr_pass <- ""
  }
  
  curr_line <- curr_line + 1
}

print(counter)

#####PART 2#####
strip_ws <- function(chr) {
  gsub(pattern = " ", replacement = "", x = chr)
}
digits_only <- function(chr) {
  gsub(pattern = "[^0-9]", replacement = "", x = chr)
}
extra_valid_pass <- function(pass_data) {
  pass_data <- strsplit(pass_data, split = " ", fixed = TRUE)[[1]]
  pass_data <- strip_ws(pass_data)
  #print(pass_data)
  
  # go thru all elements
  for (i in seq_along(pass_data)) {
    # birth year
    if (grepl(x = pass_data[i], pattern = "byr:", fixed = TRUE)) {
      byr <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = byr, pattern = "^[0-9]{4}$")) {return(FALSE)}
      byr <- as.integer(byr)
      if (byr < 1920 | byr > 2002) {return(FALSE)}
    }
    
    # issue year
    if (grepl(x = pass_data[i], pattern = "iyr:", fixed = TRUE)) {
      iyr <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = iyr, pattern = "^[0-9]{4}$")) {return(FALSE)}
      iyr <- as.integer(iyr)
      if (iyr < 2010 | iyr > 2020) {return(FALSE)}
    }
    
    # expiration year
    if (grepl(x = pass_data[i], pattern = "eyr:", fixed = TRUE)) {
      eyr <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = eyr, pattern = "^[0-9]{4}$")) {return(FALSE)}
      eyr <- as.integer(eyr)
      if (eyr < 2020 | eyr > 2030) {return(FALSE)}
    }
    
    # height
    if (grepl(x = pass_data[i], pattern = "hgt:", fixed = TRUE)) {
      hgt <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = hgt, pattern = "^[0-9]{3}cm$") &
          !grepl(x = hgt, pattern = "^[0-9]{2}in$")) {return(FALSE)}
      
      hgt_num <- as.integer(digits_only(hgt))
      if (substr(hgt, nchar(hgt) - 1, nchar(hgt)) == "cm") {
        if (hgt_num < 150 | hgt_num > 193) {return(FALSE)}
      } else if (substr(hgt, nchar(hgt) - 1, nchar(hgt)) == "in") {
        if (hgt_num < 59 | hgt_num > 76) {return(FALSE)}
      }
    }
    
    # hair color
    if (grepl(x = pass_data[i], pattern = "hcl:", fixed = TRUE)) {
      hcl <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = hcl, pattern = "^#[0-9a-f]{6}")) {return(FALSE)}
    }
    
    # eye color
    if (grepl(x = pass_data[i], pattern = "ecl:", fixed = TRUE)) {
      ecl <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!(ecl %in% c("amb", "blu", "brn", "gry", "grn", "hzl", "oth"))) {
        return(FALSE)
      }
    }
    
    # pid
    if (grepl(x = pass_data[i], pattern = "pid:", fixed = TRUE)) {
      pid <- substr(x = pass_data[i], start = 5, stop = nchar(pass_data[i]))
      
      if (!grepl(x = pid, pattern = "^[0-9]{9}$")) {return(FALSE)}
    }
  }
  return(TRUE)
}

curr_pass <- ""
curr_line <- 1
counter <- 0
while (curr_line <= length(dataset)) {
  # update current passport info
  curr_pass <- paste(curr_pass, dataset[curr_line])
  
  # end of current info - evaluate
  if (dataset[curr_line] == "") {
    #print(curr_pass)
    if (valid_passport(curr_pass) & extra_valid_pass(curr_pass)) {
      counter <- counter + 1
    }
    curr_pass <- ""
  }
  
  curr_line <- curr_line + 1
}

print(counter)