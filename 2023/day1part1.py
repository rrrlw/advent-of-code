# utility functions
def first_digit(input_str):
    for curr_ch in input_str:
        if curr_ch.isdigit():
            return curr_ch
    
    return -1

def last_digit(input_str): return first_digit(reversed(input_str))

# input & process line-by-line
counter = 0
with open("day1.in", "r") as fin:
    for line in fin:
        curr = int(first_digit(line) + last_digit(line))
        counter += curr

# output
print(counter)