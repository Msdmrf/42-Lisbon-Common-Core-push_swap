# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_three.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:24:27 by migusant          #+#    #+#              #
#    Updated: 2025/05/29 12:03:48 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test function for valid inputs
test_sequence() {
    numbers="$*"
    printf "${BLUE}Testing: %s${NC}\n" "[$numbers]"
    result=$(./push_swap "$@" | ./.checker_linux "$@" 2>&1)
    moves=$(./push_swap "$@" | wc -l | tr -d ' ')
    if [ "$result" = "OK" ]; then
        printf "${GREEN}✓ Sorted correctly with %s moves${NC}\n" "$moves"
    else
        printf "${RED}✗ Failed to sort${NC}\n"
    fi
}

# Test function for invalid inputs that should return Error
test_error() {
    numbers="$*"
    printf "${BLUE}Testing: %s${NC}\n" "[$numbers]"
    result=$(./push_swap "$@" 2>&1)
    if [ "$result" = "Error" ]; then
        printf "${GREEN}✓ Correctly returned Error${NC}\n"
    else
        printf "${RED}✗ Should return Error, got: %s${NC}\n" "$result"
    fi
}

echo -e "${YELLOW}=== Testing Three Number Sequences ===${NC}"

echo -e "\n${YELLOW}1. All Possible Permutations of 1 2 3${NC}"
test_sequence 1 2 3      # Already sorted (123)
test_sequence 1 3 2      # Last pair swapped (132)
test_sequence 2 1 3      # First pair swapped (213)
test_sequence 2 3 1      # Rotated right (231)
test_sequence 3 1 2      # Rotated left (312)
test_sequence 3 2 1      # Fully reversed (321)

echo -e "\n${YELLOW}2. All Permutations with Negative Numbers${NC}"
test_sequence -3 -2 -1   # Already sorted
test_sequence -3 -1 -2   # Last pair swapped
test_sequence -2 -3 -1   # First pair swapped
test_sequence -2 -1 -3   # Rotated right
test_sequence -1 -3 -2   # Rotated left
test_sequence -1 -2 -3   # Fully reversed

echo -e "\n${YELLOW}3. Mixed Positive and Negative${NC}"
test_sequence -1 0 1     # Mixed with zero, sorted
test_sequence -1 1 0     # Mixed with zero
test_sequence 0 -1 1     # Zero first
test_sequence 0 1 -1     # Zero first, rest reversed
test_sequence 1 -1 0     # Positive first
test_sequence 1 0 -1     # Reversed with zero

echo -e "\n${YELLOW}4. Big Numbers${NC}"
test_sequence 2147483647 0 -2147483648          # MAX, 0, MIN
test_sequence 2147483647 -2147483648 0          # MAX, MIN, 0
test_sequence -2147483648 0 2147483647          # MIN, 0, MAX
test_sequence -2147483648 2147483647 0          # MIN, MAX, 0
test_sequence 0 2147483647 -2147483648          # 0, MAX, MIN
test_sequence 0 -2147483648 2147483647          # 0, MIN, MAX

echo -e "\n${YELLOW}5. Random Sets${NC}"
test_sequence 42 -42 0                          # Symmetric around zero
test_sequence -100 0 100                        # Negative to positive
test_sequence 1000 -1000 1                      # Large contrasts
test_sequence -50 50 0                          # Another symmetric set

echo -e "\n${YELLOW}6. Error Cases${NC}"
test_error 2147483648 0 1                       # Greater than INT_MAX
test_error 0 -2147483649 1                      # Less than INT_MIN
test_error 42 42 1                              # Duplicate positive numbers
test_error 0 1 0                                # Duplicate zeros
test_error -42 1 -42                            # Duplicate negative numbers
test_error 2 "one" 3                            # Non-numeric input
test_error 1 2147483648abc 3                    # Invalid number format
test_error 1 ++2 3                              # Double positive
test_error --1 2 3                              # Double negative