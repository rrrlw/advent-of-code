from __future__ import annotations

def first_house_part1(target: int) -> int:
    """
    Part 1: Each elf e delivers 10*e presents to every house that is a multiple of e.
    Find the smallest house number with at least `target` presents.
    """
    limit = max(1, target // 10)  # heuristic lower bound; we'll grow if needed
    while True:
        presents = [0] * (limit + 1)
        for elf in range(1, limit + 1):
            step = elf
            add = 10 * elf
            for house in range(elf, limit + 1, step):
                presents[house] += add
        # find answer within current limit
        for house in range(1, limit + 1):
            if presents[house] >= target:
                return house
        # not found? double and try again
        limit *= 2


def first_house_part2(target: int) -> int:
    """
    Part 2: Each elf e visits only 50 houses (e, 2e, ..., 50e) and delivers 11*e presents.
    Find the smallest house number with at least `target` presents.
    """
    # Heuristic bound; we will grow as needed
    limit = max(1, target // 11)
    while True:
        presents = [0] * (limit + 1)
        for elf in range(1, limit + 1):
            max_house = min(limit, elf * 50)
            add = 11 * elf
            for house in range(elf, max_house + 1, elf):
                presents[house] += add
        for house in range(1, limit + 1):
            if presents[house] >= target:
                return house
        limit *= 2


def solve(input_str: str) -> tuple[int, int]:
    """
    Input: single positive integer target (e.g., 29000000)
    Output: (answer_part1, answer_part2)
    """
    target = int(input_str.strip())
    return first_house_part1(target), first_house_part2(target)


if __name__ == "__main__":
    import sys
    input_val = sys.stdin.read()
    print(input_val)
    ans1, ans2 = solve(input_val)
    print(ans1)
    print(ans2)
