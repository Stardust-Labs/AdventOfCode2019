# Day 04 - Secure Container

## Puzzle 01

### Puzzle:

You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.

However, they do remember a few key facts about the password:

    It is a six-digit number.
    The value is within the range given in your puzzle input.
    Two adjacent digits are the same (like 22 in 122345).
    Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).

Other than the range rule, the following are true:

    111111 meets these criteria (double 11, never decreases).
    223450 does not meet these criteria (decreasing pair of digits 50).
    123789 does not meet these criteria (no double).

How many different passwords within the range given in your puzzle input meet these criteria?

### Solution Requirements:
Generate a list of all valid codes within the given input range.  Code validity is defined within the puzzle.

#### Input
Range of positive six-digit integers.

#### Output
List of valid codes within the input range.

#### Answer
Number of valid codes within the input range.

### Result:
Successfully calculated the number of valid passwords within the given parameters.

## Puzzle 02

### Puzzle:
An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.

Given this additional criterion, but still ignoring the range rule, the following are now true:

    112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
    123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
    111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).

How many different passwords within the range given in your puzzle input meet all of the criteria?

### Solution Requirements:
Using the same `Password` class from the first part, alter the `isValid` method with the new requirements and generate an updated list of valid passwords within the input range.

#### Input
Range of positive six-digit integers.

#### Output
List of valid codes within the input range.

#### Answer
Number of valid codes within the input range.

### Result:
Successfully generated the number of valid codes after 1 failure.  Failure was caused by accounting for a unique false state in the `isValid` method but not the true equivalent of that unique state.
