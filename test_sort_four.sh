# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_four.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:31:27 by migusant          #+#    #+#              #
#    Updated: 2025/05/24 17:42:07 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Function to test a sequence
test_sequence() {
    ops=$(./push_swap $1)
    op_count=$(echo -n "$ops" | grep -c '^')
    result=$(./push_swap $1 | ./.checker_linux $1)
    printf "%s -> %2d ops : %s\n" "[$1]" "$op_count" "$result"
}

# Function to test error cases (expects "Error\n" output)
test_error() {
    result=$(./push_swap $1 2>&1)
    if [ "$result" = "Error" ]; then
        printf "%s -> Error : OK\n" "[$1]"
    else
        printf "%s -> FAIL (Expected Error, got: %s)\n" "[$1]" "$result"
    fi
}

echo "Basic tests (all positive permutations):"
test_sequence " 1  2  3  4"                  # Already sorted
test_sequence " 1  2  4  3"                  # Last pair swapped
test_sequence " 1  3  2  4"                  # Middle pair swapped
test_sequence " 1  3  4  2"                  # Last number misplaced
test_sequence " 1  4  2  3"                  # Middle numbers misplaced
test_sequence " 1  4  3  2"                  # Last two reversed
test_sequence " 2  1  3  4"                  # First pair swapped
test_sequence " 2  1  4  3"                  # First and last pairs swapped
test_sequence " 2  3  1  4"                  # Third number misplaced
test_sequence " 2  3  4  1"                  # Last number misplaced
test_sequence " 2  4  1  3"                  # Middle numbers misplaced
test_sequence " 2  4  3  1"                  # Last two misplaced
test_sequence " 3  1  2  4"                  # First number misplaced
test_sequence " 3  1  4  2"                  # Mixed order
test_sequence " 3  2  1  4"                  # First three reversed
test_sequence " 3  2  4  1"                  # Mixed order
test_sequence " 3  4  1  2"                  # Split reversed
test_sequence " 3  4  2  1"                  # Last three reversed
test_sequence " 4  1  2  3"                  # First number misplaced
test_sequence " 4  1  3  2"                  # Mixed order
test_sequence " 4  2  1  3"                  # Mixed order
test_sequence " 4  2  3  1"                  # First and last misplaced
test_sequence " 4  3  1  2"                  # First half reversed
test_sequence " 4  3  2  1"                  # Fully reversed

echo -e "\nNegative numbers (all negative permutations):"
test_sequence "-1 -2 -3 -4"                  # Already sorted
test_sequence "-1 -2 -4 -3"                  # Last pair swapped
test_sequence "-1 -3 -2 -4"                  # Middle pair swapped
test_sequence "-1 -3 -4 -2"                  # Last number misplaced
test_sequence "-1 -4 -2 -3"                  # Middle numbers misplaced
test_sequence "-1 -4 -3 -2"                  # Last two reversed
test_sequence "-2 -1 -3 -4"                  # First pair swapped
test_sequence "-2 -1 -4 -3"                  # First and last pairs swapped
test_sequence "-2 -3 -1 -4"                  # Third number misplaced
test_sequence "-2 -3 -4 -1"                  # Last number misplaced
test_sequence "-2 -4 -1 -3"                  # Middle numbers misplaced
test_sequence "-2 -4 -3 -1"                  # Last two misplaced
test_sequence "-3 -1 -2 -4"                  # First number misplaced
test_sequence "-3 -1 -4 -2"                  # Mixed order
test_sequence "-3 -2 -1 -4"                  # First three reversed
test_sequence "-3 -2 -4 -1"                  # Mixed order
test_sequence "-3 -4 -1 -2"                  # Split reversed
test_sequence "-3 -4 -2 -1"                  # Last three reversed
test_sequence "-4 -1 -2 -3"                  # First number misplaced
test_sequence "-4 -1 -3 -2"                  # Mixed order
test_sequence "-4 -2 -1 -3"                  # Mixed order
test_sequence "-4 -2 -3 -1"                  # First and last misplaced
test_sequence "-4 -3 -1 -2"                  # First half reversed
test_sequence "-4 -3 -2 -1"                  # Fully reversed

echo -e "\nMixed numbers:"
test_sequence "-2 -1  0  1"                  # Sorted with negatives and zero
test_sequence " 1  0 -1 -2"                  # Reversed with negatives and zero
test_sequence "-1  1 -2  2"                  # Alternating positive/negative
test_sequence " 0 -1  1 -2"                  # Mixed with zero

echo -e "\nBig numbers:"
test_sequence " 2147483647  1          -1          0"    # Max int first
test_sequence "-2147483648  2147483647  0          1"    # Min and max
test_sequence " 0          -2147483648  2147483647 1"    # Zero with extremes
test_sequence " 2147483647 -2147483648  1          0"    # Extremes first

echo -e "\nRandom quartets:"
test_sequence " 42   -42   0    1  "          # Opposites with zero and one
test_sequence "-100   0    50   100"          # Spread out numbers
test_sequence " 1000 -1000 500 -500"        # Two pairs of opposites
test_sequence "-50    50  -25   25 "          # Symmetric around zero

echo -e "\nError cases:"
test_error "  2147483648 0             1  2"    # Greater than INT_MAX
test_error "  0         -2147483649    1  2"    # Less than INT_MIN
test_error "  42         42            1  2"    # Duplicate positive numbers
test_error "  0          1             0  2"    # Duplicate zeros
test_error " -42         1            -42 2"    # Duplicate negative numbers
test_error "  2          one           3  4"    # Non-numeric input
test_error "  1          2147483648abc 3  4"    # Invalid number format
test_error "  1        ++2             3  4"    # Double positive
test_error "--1          2             3  4"    # Double negative