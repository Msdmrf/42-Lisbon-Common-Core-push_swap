# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_five.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 17:28:04 by migusant          #+#    #+#              #
#    Updated: 2025/05/24 17:44:39 by migusant         ###   ########.fr        #
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
# First group (sorted and near-sorted)
test_sequence "1 2 3 4 5"              # Already sorted
test_sequence "1 2 3 5 4"              # Last pair swapped
test_sequence "1 2 4 3 5"              # Middle pair swapped
test_sequence "1 2 4 5 3"              # Last number misplaced
test_sequence "1 2 5 3 4"              # Third position misplaced
test_sequence "1 2 5 4 3"              # Last two reversed

# Starting with 1
test_sequence "1 3 2 4 5"              # Second pair swapped
test_sequence "1 3 2 5 4"              # Mixed arrangement
test_sequence "1 3 4 2 5"              # One misplaced in middle
test_sequence "1 3 4 5 2"              # Last number misplaced
test_sequence "1 3 5 2 4"              # Mixed arrangement
test_sequence "1 3 5 4 2"              # Last two misplaced
test_sequence "1 4 2 3 5"              # Middle area misplaced
test_sequence "1 4 2 5 3"              # Mixed arrangement
test_sequence "1 4 3 2 5"              # Middle area reversed
test_sequence "1 4 3 5 2"              # Mixed arrangement
test_sequence "1 4 5 2 3"              # Last three mixed
test_sequence "1 4 5 3 2"              # Last three reversed
test_sequence "1 5 2 3 4"              # Second number misplaced
test_sequence "1 5 2 4 3"              # Mixed arrangement
test_sequence "1 5 3 2 4"              # Middle area mixed
test_sequence "1 5 3 4 2"              # Mixed arrangement
test_sequence "1 5 4 2 3"              # Last four mixed
test_sequence "1 5 4 3 2"              # Last four reversed

# Starting with 2
test_sequence "2 1 3 4 5"              # First pair swapped
test_sequence "2 1 3 5 4"              # First pair and last pair swapped
test_sequence "2 1 4 3 5"              # First pair and middle mixed
test_sequence "2 1 4 5 3"              # Mixed arrangement
test_sequence "2 1 5 3 4"              # Mixed arrangement
test_sequence "2 1 5 4 3"              # Mixed arrangement
test_sequence "2 3 1 4 5"              # Third position misplaced
test_sequence "2 3 1 5 4"              # Mixed arrangement
test_sequence "2 3 4 1 5"              # Fourth position misplaced
test_sequence "2 3 4 5 1"              # Last position misplaced
test_sequence "2 3 5 1 4"              # Mixed arrangement
test_sequence "2 3 5 4 1"              # Mixed arrangement
test_sequence "2 4 1 3 5"              # Mixed arrangement
test_sequence "2 4 1 5 3"              # Mixed arrangement
test_sequence "2 4 3 1 5"              # Mixed arrangement
test_sequence "2 4 3 5 1"              # Mixed arrangement
test_sequence "2 4 5 1 3"              # Mixed arrangement
test_sequence "2 4 5 3 1"              # Mixed arrangement
test_sequence "2 5 1 3 4"              # Mixed arrangement
test_sequence "2 5 1 4 3"              # Mixed arrangement
test_sequence "2 5 3 1 4"              # Mixed arrangement
test_sequence "2 5 3 4 1"              # Mixed arrangement
test_sequence "2 5 4 1 3"              # Mixed arrangement
test_sequence "2 5 4 3 1"              # Mixed arrangement

# Starting with 3
test_sequence "3 1 2 4 5"              # First number misplaced
test_sequence "3 1 2 5 4"              # Mixed arrangement
test_sequence "3 1 4 2 5"              # Mixed arrangement
test_sequence "3 1 4 5 2"              # Mixed arrangement
test_sequence "3 1 5 2 4"              # Mixed arrangement
test_sequence "3 1 5 4 2"              # Mixed arrangement
test_sequence "3 2 1 4 5"              # First three reversed
test_sequence "3 2 1 5 4"              # Mixed arrangement
test_sequence "3 2 4 1 5"              # Mixed arrangement
test_sequence "3 2 4 5 1"              # Mixed arrangement
test_sequence "3 2 5 1 4"              # Mixed arrangement
test_sequence "3 2 5 4 1"              # Mixed arrangement
test_sequence "3 4 1 2 5"              # Mixed arrangement
test_sequence "3 4 1 5 2"              # Mixed arrangement
test_sequence "3 4 2 1 5"              # Mixed arrangement
test_sequence "3 4 2 5 1"              # Mixed arrangement
test_sequence "3 4 5 1 2"              # First and last half split
test_sequence "3 4 5 2 1"              # Last half reversed
test_sequence "3 5 1 2 4"              # Mixed arrangement
test_sequence "3 5 1 4 2"              # Mixed arrangement
test_sequence "3 5 2 1 4"              # Mixed arrangement
test_sequence "3 5 2 4 1"              # Mixed arrangement
test_sequence "3 5 4 1 2"              # Mixed arrangement
test_sequence "3 5 4 2 1"              # Mixed arrangement

# Starting with 4
test_sequence "4 1 2 3 5"              # First number misplaced
test_sequence "4 1 2 5 3"              # Mixed arrangement
test_sequence "4 1 3 2 5"              # Mixed arrangement
test_sequence "4 1 3 5 2"              # Mixed arrangement
test_sequence "4 1 5 2 3"              # Mixed arrangement
test_sequence "4 1 5 3 2"              # Mixed arrangement
test_sequence "4 2 1 3 5"              # Mixed arrangement
test_sequence "4 2 1 5 3"              # Mixed arrangement
test_sequence "4 2 3 1 5"              # Mixed arrangement
test_sequence "4 2 3 5 1"              # Mixed arrangement
test_sequence "4 2 5 1 3"              # Mixed arrangement
test_sequence "4 2 5 3 1"              # Mixed arrangement
test_sequence "4 3 1 2 5"              # Mixed arrangement
test_sequence "4 3 1 5 2"              # Mixed arrangement
test_sequence "4 3 2 1 5"              # Mixed arrangement
test_sequence "4 3 2 5 1"              # Mixed arrangement
test_sequence "4 3 5 1 2"              # Mixed arrangement
test_sequence "4 3 5 2 1"              # Mixed arrangement
test_sequence "4 5 1 2 3"              # First two misplaced
test_sequence "4 5 1 3 2"              # Mixed arrangement
test_sequence "4 5 2 1 3"              # Mixed arrangement
test_sequence "4 5 2 3 1"              # Mixed arrangement
test_sequence "4 5 3 1 2"              # Mixed arrangement
test_sequence "4 5 3 2 1"              # Mixed arrangement

# Starting with 5
test_sequence "5 1 2 3 4"              # First number misplaced
test_sequence "5 1 2 4 3"              # Mixed arrangement
test_sequence "5 1 3 2 4"              # Mixed arrangement
test_sequence "5 1 3 4 2"              # Mixed arrangement
test_sequence "5 1 4 2 3"              # Mixed arrangement
test_sequence "5 1 4 3 2"              # Mixed arrangement
test_sequence "5 2 1 3 4"              # Mixed arrangement
test_sequence "5 2 1 4 3"              # Mixed arrangement
test_sequence "5 2 3 1 4"              # Mixed arrangement
test_sequence "5 2 3 4 1"              # Mixed arrangement
test_sequence "5 2 4 1 3"              # Mixed arrangement
test_sequence "5 2 4 3 1"              # Mixed arrangement
test_sequence "5 3 1 2 4"              # Mixed arrangement
test_sequence "5 3 1 4 2"              # Mixed arrangement
test_sequence "5 3 2 1 4"              # Mixed arrangement
test_sequence "5 3 2 4 1"              # Mixed arrangement
test_sequence "5 3 4 1 2"              # Mixed arrangement
test_sequence "5 3 4 2 1"              # Mixed arrangement
test_sequence "5 4 1 2 3"              # Mixed arrangement
test_sequence "5 4 1 3 2"              # Mixed arrangement
test_sequence "5 4 2 1 3"              # Mixed arrangement
test_sequence "5 4 2 3 1"              # Mixed arrangement
test_sequence "5 4 3 1 2"              # Mixed arrangement
test_sequence "5 4 3 2 1"              # Fully reversed

echo -e "\nNegative numbers (all negative permutations):"
# First group (sorted and near-sorted)
test_sequence "-1 -2 -3 -4 -5"         # Already sorted
test_sequence "-1 -2 -3 -5 -4"         # Last pair swapped
test_sequence "-1 -2 -4 -3 -5"         # Middle pair swapped
test_sequence "-1 -2 -4 -5 -3"         # Last number misplaced
test_sequence "-1 -2 -5 -3 -4"         # Third position misplaced
test_sequence "-1 -2 -5 -4 -3"         # Last two reversed

# Starting with -1
test_sequence "-1 -3 -2 -4 -5"         # Second pair swapped
test_sequence "-1 -3 -2 -5 -4"         # Mixed arrangement
test_sequence "-1 -3 -4 -2 -5"         # One misplaced in middle
test_sequence "-1 -3 -4 -5 -2"         # Last number misplaced
test_sequence "-1 -3 -5 -2 -4"         # Mixed arrangement
test_sequence "-1 -3 -5 -4 -2"         # Last two misplaced
test_sequence "-1 -4 -2 -3 -5"         # Middle area misplaced
test_sequence "-1 -4 -2 -5 -3"         # Mixed arrangement
test_sequence "-1 -4 -3 -2 -5"         # Middle area reversed
test_sequence "-1 -4 -3 -5 -2"         # Mixed arrangement
test_sequence "-1 -4 -5 -2 -3"         # Last three mixed
test_sequence "-1 -4 -5 -3 -2"         # Last three reversed
test_sequence "-1 -5 -2 -3 -4"         # Second number misplaced
test_sequence "-1 -5 -2 -4 -3"         # Mixed arrangement
test_sequence "-1 -5 -3 -2 -4"         # Middle area mixed
test_sequence "-1 -5 -3 -4 -2"         # Mixed arrangement
test_sequence "-1 -5 -4 -2 -3"         # Last four mixed
test_sequence "-1 -5 -4 -3 -2"         # Last four reversed

# Starting with -2
test_sequence "-2 -1 -3 -4 -5"         # First pair swapped
test_sequence "-2 -1 -3 -5 -4"         # First pair and last pair swapped
test_sequence "-2 -1 -4 -3 -5"         # First pair and middle mixed
test_sequence "-2 -1 -4 -5 -3"         # Mixed arrangement
test_sequence "-2 -1 -5 -3 -4"         # Mixed arrangement
test_sequence "-2 -1 -5 -4 -3"         # Mixed arrangement
test_sequence "-2 -3 -1 -4 -5"         # Third position misplaced
test_sequence "-2 -3 -1 -5 -4"         # Mixed arrangement
test_sequence "-2 -3 -4 -1 -5"         # Fourth position misplaced
test_sequence "-2 -3 -4 -5 -1"         # Last position misplaced
test_sequence "-2 -3 -5 -1 -4"         # Mixed arrangement
test_sequence "-2 -3 -5 -4 -1"         # Mixed arrangement
test_sequence "-2 -4 -1 -3 -5"         # Mixed arrangement
test_sequence "-2 -4 -1 -5 -3"         # Mixed arrangement
test_sequence "-2 -4 -3 -1 -5"         # Mixed arrangement
test_sequence "-2 -4 -3 -5 -1"         # Mixed arrangement
test_sequence "-2 -4 -5 -1 -3"         # Mixed arrangement
test_sequence "-2 -4 -5 -3 -1"         # Mixed arrangement
test_sequence "-2 -5 -1 -3 -4"         # Mixed arrangement
test_sequence "-2 -5 -1 -4 -3"         # Mixed arrangement
test_sequence "-2 -5 -3 -1 -4"         # Mixed arrangement
test_sequence "-2 -5 -3 -4 -1"         # Mixed arrangement
test_sequence "-2 -5 -4 -1 -3"         # Mixed arrangement
test_sequence "-2 -5 -4 -3 -1"         # Mixed arrangement

# Starting with -3
test_sequence "-3 -1 -2 -4 -5"         # First number misplaced
test_sequence "-3 -1 -2 -5 -4"         # Mixed arrangement
test_sequence "-3 -1 -4 -2 -5"         # Mixed arrangement
test_sequence "-3 -1 -4 -5 -2"         # Mixed arrangement
test_sequence "-3 -1 -5 -2 -4"         # Mixed arrangement
test_sequence "-3 -1 -5 -4 -2"         # Mixed arrangement
test_sequence "-3 -2 -1 -4 -5"         # First three reversed
test_sequence "-3 -2 -1 -5 -4"         # Mixed arrangement
test_sequence "-3 -2 -4 -1 -5"         # Mixed arrangement
test_sequence "-3 -2 -4 -5 -1"         # Mixed arrangement
test_sequence "-3 -2 -5 -1 -4"         # Mixed arrangement
test_sequence "-3 -2 -5 -4 -1"         # Mixed arrangement
test_sequence "-3 -4 -1 -2 -5"         # Mixed arrangement
test_sequence "-3 -4 -1 -5 -2"         # Mixed arrangement
test_sequence "-3 -4 -2 -1 -5"         # Mixed arrangement
test_sequence "-3 -4 -2 -5 -1"         # Mixed arrangement
test_sequence "-3 -4 -5 -1 -2"         # First and last half split
test_sequence "-3 -4 -5 -2 -1"         # Last half reversed
test_sequence "-3 -5 -1 -2 -4"         # Mixed arrangement
test_sequence "-3 -5 -1 -4 -2"         # Mixed arrangement
test_sequence "-3 -5 -2 -1 -4"         # Mixed arrangement
test_sequence "-3 -5 -2 -4 -1"         # Mixed arrangement
test_sequence "-3 -5 -4 -1 -2"         # Mixed arrangement
test_sequence "-3 -5 -4 -2 -1"         # Mixed arrangement

# Starting with -4
test_sequence "-4 -1 -2 -3 -5"         # First number misplaced
test_sequence "-4 -1 -2 -5 -3"         # Mixed arrangement
test_sequence "-4 -1 -3 -2 -5"         # Mixed arrangement
test_sequence "-4 -1 -3 -5 -2"         # Mixed arrangement
test_sequence "-4 -1 -5 -2 -3"         # Mixed arrangement
test_sequence "-4 -1 -5 -3 -2"         # Mixed arrangement
test_sequence "-4 -2 -1 -3 -5"         # Mixed arrangement
test_sequence "-4 -2 -1 -5 -3"         # Mixed arrangement
test_sequence "-4 -2 -3 -1 -5"         # Mixed arrangement
test_sequence "-4 -2 -3 -5 -1"         # Mixed arrangement
test_sequence "-4 -2 -5 -1 -3"         # Mixed arrangement
test_sequence "-4 -2 -5 -3 -1"         # Mixed arrangement
test_sequence "-4 -3 -1 -2 -5"         # Mixed arrangement
test_sequence "-4 -3 -1 -5 -2"         # Mixed arrangement
test_sequence "-4 -3 -2 -1 -5"         # Mixed arrangement
test_sequence "-4 -3 -2 -5 -1"         # Mixed arrangement
test_sequence "-4 -3 -5 -1 -2"         # Mixed arrangement
test_sequence "-4 -3 -5 -2 -1"         # Mixed arrangement
test_sequence "-4 -5 -1 -2 -3"         # First two misplaced
test_sequence "-4 -5 -1 -3 -2"         # Mixed arrangement
test_sequence "-4 -5 -2 -1 -3"         # Mixed arrangement
test_sequence "-4 -5 -2 -3 -1"         # Mixed arrangement
test_sequence "-4 -5 -3 -1 -2"         # Mixed arrangement
test_sequence "-4 -5 -3 -2 -1"         # Mixed arrangement

# Starting with -5
test_sequence "-5 -1 -2 -3 -4"         # First number misplaced
test_sequence "-5 -1 -2 -4 -3"         # Mixed arrangement
test_sequence "-5 -1 -3 -2 -4"         # Mixed arrangement
test_sequence "-5 -1 -3 -4 -2"         # Mixed arrangement
test_sequence "-5 -1 -4 -2 -3"         # Mixed arrangement
test_sequence "-5 -1 -4 -3 -2"         # Mixed arrangement
test_sequence "-5 -2 -1 -3 -4"         # Mixed arrangement
test_sequence "-5 -2 -1 -4 -3"         # Mixed arrangement
test_sequence "-5 -2 -3 -1 -4"         # Mixed arrangement
test_sequence "-5 -2 -3 -4 -1"         # Mixed arrangement
test_sequence "-5 -2 -4 -1 -3"         # Mixed arrangement
test_sequence "-5 -2 -4 -3 -1"         # Mixed arrangement
test_sequence "-5 -3 -1 -2 -4"         # Mixed arrangement
test_sequence "-5 -3 -1 -4 -2"         # Mixed arrangement
test_sequence "-5 -3 -2 -1 -4"         # Mixed arrangement
test_sequence "-5 -3 -2 -4 -1"         # Mixed arrangement
test_sequence "-5 -3 -4 -1 -2"         # Mixed arrangement
test_sequence "-5 -3 -4 -2 -1"         # Mixed arrangement
test_sequence "-5 -4 -1 -2 -3"         # Mixed arrangement
test_sequence "-5 -4 -1 -3 -2"         # Mixed arrangement
test_sequence "-5 -4 -2 -1 -3"         # Mixed arrangement
test_sequence "-5 -4 -2 -3 -1"         # Mixed arrangement
test_sequence "-5 -4 -3 -1 -2"         # Mixed arrangement
test_sequence "-5 -4 -3 -2 -1"         # Fully reversed

echo -e "\nMixed numbers:"
test_sequence " 0  1  2  3  4"         # Zero first
test_sequence " 1  0  2  3  4"         # Zero second
test_sequence " 1  2  0  3  4"         # Zero middle
test_sequence " 1  2  3  0  4"         # Zero fourth
test_sequence " 1  2  3  4  0"         # Zero last
test_sequence "-1  2  3  4  5"         # One negative first
test_sequence " 1 -2  3  4  5"         # One negative second
test_sequence " 1  2 -3  4  5"         # One negative middle
test_sequence " 1  2  3 -4  5"         # One negative fourth
test_sequence " 1  2  3  4 -5"         # One negative last
test_sequence "-1 -2  3  4  5"         # Two negatives first
test_sequence " 1 -2 -3  4  5"         # Two negatives middle
test_sequence " 1  2 -3 -4  5"         # Two negatives fourth
test_sequence " 1  2  3 -4 -5"         # Two negatives last
test_sequence "-1 -2 -3  4  5"         # Three negatives first
test_sequence " 1 -2 -3 -4  5"         # Three negatives middle
test_sequence " 1  2 -3 -4 -5"         # Three negatives last
test_sequence "-1 -2 -3 -4  5"         # Four negatives
test_sequence " 1 -2 -3 -4 -5"         # Four negatives last

echo -e "\nBig numbers:"
test_sequence "1  2           2147483647 4 5"       # MAX_INT middle
test_sequence "1 -2147483648  3          4 5"       # MIN_INT second
test_sequence "1  2147483647 -2147483648 4 5"       # MAX and MIN middle

echo -e "\nRandom pairs:"
test_sequence " 42   -42    0    1    2"            # Opposite pairs with zero
test_sequence "-100   100  -50   50   0"            # Ascending opposite pairs
test_sequence " 1000 -1000  500 -500  0"            # Descending opposite pairs
test_sequence "-50    50   -25   25   0"            # Symmetric around zero
test_sequence " 999  -999   0    1   -1"            # Mixed opposites
test_sequence " 100   200  -200 -100  0"            # Mixed range opposites
test_sequence " 42    24   -24  -42   0"            # Reversed opposites
test_sequence " 10    20    0   -20 -10"            # Symmetric sequence

echo -e "\nError cases:"
test_error "1  2          2147483648    4   5"      # Greater than INT_MAX
test_error "1 -2147483649 3             4   5"      # Less than INT_MIN
test_error "1  2          2             4   5"      # Duplicate numbers
test_error "1  2          2             5   5"      # Multiple duplicates
test_error "a  2          3             4   5"      # Non-numeric input
test_error "1  2          2147483648abc 4   5"      # Invalid number format
test_error "1  2          3             4 ++5"      # Double positive sign
test_error "1  2        --3             4   5"      # Double negative sign