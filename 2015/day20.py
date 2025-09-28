# setup
from math import floor
from math import sqrt

# utility function for prime factorization
def utility_prime_factors(n: int, test_factor: int):
    count = 0
    while n % test_factor == 0:
        n //= test_factor
        count += 1
    
    return (n, test_factor, count)

# prime factorization for an integer
def prime_factorize(n: int):
    # store prime factorization in list (of tuples: prime factor and power for that prime factor)
    ans = []

    # handle 2 & 3 separately
    check = utility_prime_factors(n, 2)
    if (check[2] > 0):
        n = check[0]
        ans.append((check[1], check[2]))
    
    check = utility_prime_factors(n, 3)
    if (check[2] > 0):
        n = check[0]
        ans.append((check[1], check[2]))

    # handle other odds of the form (6n - 1) and (6n + 1)
    i = 1
    upper_lim = (sqrt(n) + 1) / 6
    for i in range(1, floor(upper_lim)):
        check = utility_prime_factors(n, 6 * i - 1)
        if (check[2] > 0):
            n = check[0]
            ans.append((check[1], check[2]))

        check = utility_prime_factors(n, 6 * i + 1)
        if (check[2] > 0):
            n = check[0]
            ans.append((check[1], check[2]))

    # check if n is prime
    if n > 1: ans.append((n, 1))

    # return prime factorization
    return ans

# sum all factors of an integer (lower sigma of n, in number theory)
def sum_factors(n: int) -> int:
    # deal with edge case
    if n == 1: return 1

    # use number theory formula for lower case sigma of n using prime factorization
    prime_factors = prime_factorize(n)

    curr_contribution = 1
    for i in prime_factors:
        curr_factor = i[0]
        curr_power = i[1]

        curr_contribution *= (curr_factor ** (curr_power + 1) - 1) // (curr_factor - 1)

    return curr_contribution

# sum all factors of an integer (lower sigma of n, in number theory)
# ignore factors if greater multiple than 50x (part 2 constraint)
def sum_factors_2(n: int) -> int:
    # deal with edge case
    if n == 1: return 1

    # use number theory formula for lower case sigma of n using prime factorization
    prime_factors = prime_factorize(n)

    curr_contribution = 1
    for i in prime_factors:
        curr_factor = i[0]
        curr_power = i[1]

        # part 2 constraint
        if n // curr_factor > 50: next

        curr_contribution *= (curr_factor ** (curr_power + 1) - 1) // (curr_factor - 1)

    return curr_contribution

# house value based on how this problem defines it
def house_value(n: int) -> int: return sum_factors(n) * 10

# house value for part 2 of the problem
def house_value_2(n: int) -> int: return sum_factors_2(n) * 11

# problem input
input_val = 29000000

# input_val = 29M
# lower sigma(input_val) = 2.9M
# lower_sigma has limit superior n * loglogn * exp(Euler-Mascheroni)
# => 2.9M less than equal to ~ 1.781 * n * loglogn
# loglogn < 4.5 for n = 1M => 2.9M / (1.781 * 4.5) = ~362K less than equal to n
# start searching at 360K
for i in range(360000, 3600000):
    if house_value(i) >= input_val:
        print(i)
        break

print("DONE w/ part 1")

# IDK how this will affect the search, just start close to zero and end at the input value
for i in range(1000, input_val):
    if house_value_2(i) >= input_val:
        print(i)
        break

print("DONE w/ part 2")

## PROGRESS UPDATE = the following functions don't work (part 2): sum_factors_2 (enforce the 50 limit), house_value_2 (because of sum_factors_2), code after line 110 (because of house_value_2)
