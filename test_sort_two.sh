# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_two.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 16:13:13 by migusant          #+#    #+#              #
#    Updated: 2025/05/29 12:03:32 by migusant         ###   ########.fr        #
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

echo -e "${YELLOW}=== Testing Two Number Sequences ===${NC}"

echo -e "\n${YELLOW}1. Basic Tests${NC}"
test_sequence 1 2                  # Already sorted
test_sequence 2 1                  # Need swap
test_sequence -2 -1               # Negative sorted
test_sequence -1 -2               # Negative need swap

echo -e "\n${YELLOW}2. Mixed Numbers${NC}"
test_sequence -1 1                # Mixed sorted
test_sequence 1 -1               # Mixed need swap
test_sequence 0 1                # With zero sorted
test_sequence 1 0                # With zero need swap

echo -e "\n${YELLOW}3. Big Numbers${NC}"
test_sequence 2147483647 1               # MAX first
test_sequence 1 2147483647              # MAX last
test_sequence -2147483648 2147483647    # MIN MAX sorted
test_sequence 2147483647 -2147483648    # MAX MIN need swap

echo -e "\n${YELLOW}4. Random Pairs${NC}"
test_sequence 42 -42                    # Positive negative
test_sequence -100 100                  # Negative positive
test_sequence 1000 -1000                # Large contrast

echo -e "\n${YELLOW}5. Error Cases${NC}"
test_error 2147483648 1                 # Greater than INT_MAX
test_error 1 -2147483649               # Less than INT_MIN
test_error 42 42                       # Duplicate positive numbers
test_error 0 0                         # Duplicate zeros
test_error -42 -42                     # Duplicate negative numbers
test_error 2 "one"                     # Non-numeric input
test_error 1 2147483648abc             # Invalid number format
test_error 1 ++2                       # Double positive
test_error --1 2                       # Double negative

echo -e "\n${YELLOW}6. Edge Cases with Signs${NC}"
test_error "+"                         # Sign alone
test_error 1 2-                        # Trailing sign
test_error 1 2+                        # Trailing sign
test_error 1 --2                       # Double negative
test_error 1 ++2                       # Double positive
test_sequence 1 +2                     # Valid sign usage
test_error "+ 1"                       # Invalid sign alone

echo -e "\n${YELLOW}7. Zero Cases${NC}"
test_sequence -1 0                     # Valid with zero
test_error 0 0                         # Duplicate zeros
test_sequence 0 1                      # Valid with zero