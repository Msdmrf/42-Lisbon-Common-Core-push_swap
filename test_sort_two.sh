# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_two.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:13:13 by migusant          #+#    #+#              #
#    Updated: 2025/05/24 17:41:59 by migusant         ###   ########.fr        #
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

echo "Basic tests:"
test_sequence " 1  2"                     # Already sorted
test_sequence " 2  1"                     # Need swap

echo -e "\nNegative numbers:"
test_sequence "-2 -1"                     # Already sorted
test_sequence "-1 -2"                     # Need swap

echo -e "\nMixed numbers:"
test_sequence "-1  1"                     # Already sorted
test_sequence " 1 -1"                     # Need swap
test_sequence " 0  1"                     # Already sorted
test_sequence " 1  0"                     # Need swap

echo -e "\nBig numbers:"
test_sequence " 2147483647  1         "   # Need swap
test_sequence " 1           2147483647"   # Already sorted
test_sequence "-2147483648  2147483647"   # Already sorted
test_sequence " 2147483647 -2147483648"   # Need swap

echo -e "\nRandom pairs:"
test_sequence " 42   -42  "               # Need swap
test_sequence "-100   100 "               # Already sorted
test_sequence " 1000 -1000"               # Need swap

echo -e "\nError cases:"
test_error "  2147483648   1            " # Greater than INT_MAX
test_error "  1           -2147483649   " # Less than INT_MIN
test_error "  42           42           " # Duplicate positive numbers
test_error "  0            0            " # Duplicate zeros
test_error " -42          -42           " # Duplicate negative numbers
test_error "  2            one          " # Non-numeric input
test_error "  1            2147483648abc" # Invalid number format
test_error "  1          ++2            " # Double positive
test_error "--1            2            " # Double negative  