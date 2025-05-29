# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_four.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:31:27 by migusant          #+#    #+#              #
#    Updated: 2025/05/29 12:04:05 by migusant         ###   ########.fr        #
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

echo -e "${YELLOW}=== Testing Four Number Sequences ===${NC}"

echo -e "\n${YELLOW}1. All Positive Permutations of 1 2 3 4${NC}"
test_sequence 1 2 3 4                # Already sorted (1234)
test_sequence 1 2 4 3                # Last pair swapped (1243)
test_sequence 1 3 2 4                # Middle pair swapped (1324)
test_sequence 1 3 4 2                # Last two mixed (1342)
test_sequence 1 4 2 3                # Middle numbers mixed (1423)
test_sequence 1 4 3 2                # Last three reversed (1432)
test_sequence 2 1 3 4                # First pair swapped (2134)
test_sequence 2 1 4 3                # First and last pairs swapped (2143)
test_sequence 2 3 1 4                # Second and third swapped (2314)
test_sequence 2 3 4 1                # Rotated once right (2341)
test_sequence 2 4 1 3                # Complex middle mix (2413)
test_sequence 2 4 3 1                # Last three mixed (2431)
test_sequence 3 1 2 4                # First and second swapped (3124)
test_sequence 3 1 4 2                # Complex mix (3142)
test_sequence 3 2 1 4                # First three mixed (3214)
test_sequence 3 2 4 1                # Complex mix (3241)
test_sequence 3 4 1 2                # First two and last two swapped (3412)
test_sequence 3 4 2 1                # First two swapped, last two reversed (3421)
test_sequence 4 1 2 3                # Rotated once left (4123)
test_sequence 4 1 3 2                # First and last, middle swapped (4132)
test_sequence 4 2 1 3                # Complex mix (4213)
test_sequence 4 2 3 1                # Complex mix (4231)
test_sequence 4 3 1 2                # Complex mix (4312)
test_sequence 4 3 2 1                # Fully reversed (4321)

echo -e "\n${YELLOW}2. All Permutations with Negative Numbers${NC}"
test_sequence -4 -3 -2 -1            # Already sorted
test_sequence -4 -3 -1 -2            # Last pair swapped
test_sequence -4 -2 -3 -1            # Middle pair swapped
test_sequence -4 -2 -1 -3            # Last two mixed
test_sequence -4 -1 -3 -2            # Middle numbers mixed
test_sequence -4 -1 -2 -3            # Last three mixed
test_sequence -3 -4 -2 -1            # First pair swapped
test_sequence -3 -4 -1 -2            # First and last pairs swapped
test_sequence -3 -2 -4 -1            # Second and third swapped
test_sequence -3 -2 -1 -4            # Rotated once right
test_sequence -3 -1 -4 -2            # Complex middle mix
test_sequence -3 -1 -2 -4            # Last three mixed
test_sequence -2 -4 -3 -1            # First and second swapped
test_sequence -2 -4 -1 -3            # Complex mix
test_sequence -2 -3 -4 -1            # First three mixed
test_sequence -2 -3 -1 -4            # Complex mix
test_sequence -2 -1 -4 -3            # First two and last two swapped
test_sequence -2 -1 -3 -4            # First two swapped, last two reversed
test_sequence -1 -4 -3 -2            # Rotated once left
test_sequence -1 -4 -2 -3            # First and last, middle swapped
test_sequence -1 -3 -4 -2            # Complex mix
test_sequence -1 -3 -2 -4            # Complex mix
test_sequence -1 -2 -4 -3            # Complex mix
test_sequence -1 -2 -3 -4            # Fully reversed

echo -e "\n${YELLOW}3. Mixed Numbers${NC}"
test_sequence -2 -1 0 1              # Sorted with negatives and zero
test_sequence 1 0 -1 -2              # Reversed with negatives and zero
test_sequence -1 1 -2 2              # Alternating positive/negative
test_sequence 0 -1 1 -2              # Mixed with zero

echo -e "\n${YELLOW}4. Big Numbers${NC}"
test_sequence 2147483647 1 -1 -2147483648        # MAX, 1, -1, MIN
test_sequence -2147483648 2147483647 0 1         # MIN, MAX, 0, 1
test_sequence 0 -2147483648 2147483647 1         # 0, MIN, MAX, 1
test_sequence 2147483647 -2147483648 1 0         # MAX, MIN, 1, 0

echo -e "\n${YELLOW}5. Special Sequences${NC}"
test_sequence 42 -42 0 1                         # Opposites with zero and one
test_sequence -100 0 50 100                      # Spread out numbers
test_sequence 1000 -1000 500 -500               # Two pairs of opposites
test_sequence -50 50 -25 25                      # Symmetric around zero

echo -e "\n${YELLOW}6. Error Cases${NC}"
test_error 2147483648 0 1 2                      # Greater than INT_MAX
test_error 0 -2147483649 1 2                     # Less than INT_MIN
test_error 42 42 1 2                             # Duplicate positive numbers
test_error 0 1 0 2                               # Duplicate zeros
test_error -42 1 -42 2                           # Duplicate negative numbers
test_error 2 one 3 4                             # Non-numeric input
test_error 1 2147483648abc 3 4                   # Invalid number format
test_error 1 ++2 3 4                             # Double positive
test_error --1 2 3 4                             # Double negative