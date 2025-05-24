# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_three.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:24:27 by migusant          #+#    #+#              #
#    Updated: 2025/05/24 17:42:03 by migusant         ###   ########.fr        #
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
test_sequence " 1  2  3"                      # Already sorted
test_sequence " 1  3  2"                      # Last pair swapped
test_sequence " 2  1  3"                      # First pair swapped
test_sequence " 2  3  1"                      # Last number misplaced
test_sequence " 3  1  2"                      # First number misplaced
test_sequence " 3  2  1"                      # Fully reversed

echo -e "\nNegative numbers (all negative permutations):"
test_sequence "-1 -2 -3"                      # Already sorted
test_sequence "-1 -3 -2"                      # Last pair swapped
test_sequence "-2 -1 -3"                      # First pair swapped
test_sequence "-2 -3 -1"                      # Last number misplaced
test_sequence "-3 -1 -2"                      # First number misplaced
test_sequence "-3 -2 -1"                      # Fully reversed

echo -e "\nMixed numbers:"
test_sequence "-1  0  1"                      # Already sorted with zero
test_sequence " 1  0 -1"                      # Reversed with zero
test_sequence "-1  1  0"                      # Mixed order
test_sequence " 0 -1  1"                      # Zero first

echo -e "\nBig numbers:"
test_sequence " 2147483647  1          0         "    # Max int first
test_sequence "-2147483648  2147483647 0         "    # Min and max
test_sequence " 0          -2147483648 2147483647"    # Zero with extremes
test_sequence " 2147483647 -2147483648 0         "    # Extremes reversed

echo -e "\nRandom triplets:"
test_sequence " 42   -42     0"                # Opposite numbers with zero
test_sequence "-100   0    100"                # Negative to positive
test_sequence " 1000 -1000   1"                # Large opposite numbers
test_sequence "-50    50     0"                # Symmetric around zero

echo -e "\nError cases:"
test_error "  2147483648  0             1"     # Greater than INT_MAX
test_error "  0          -2147483649    1"     # Less than INT_MIN
test_error "  42          42            1"     # Duplicate positive numbers
test_error "  0           1             0"     # Duplicate zeros
test_error " -42          1           -42"     # Duplicate negative numbers
test_error "  2           one           3"     # Non-numeric input
test_error "  1           2147483648abc 3"     # Invalid number format
test_error "  1         ++2             3"     # Double positive
test_error "--1           2             3"     # Double negative