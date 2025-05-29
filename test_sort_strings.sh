# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_strings.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 19:03:05 by migusant          #+#    #+#              #
#    Updated: 2025/05/28 16:39:06 by migusant         ###   ########.fr        #
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
    printf "${BLUE}Testing: %s${NC}\n" "[$1]"
    result=$(./push_swap "$1" | ./.checker_linux "$1" 2>&1)
    moves=$(./push_swap "$1" | wc -l | tr -d ' ')
    if [ "$result" = "OK" ]; then
        printf "${GREEN}✓ Sorted correctly with %s moves${NC}\n" "$moves"
    else
        printf "${RED}✗ Failed to sort${NC}\n"
    fi
}

# Test function for invalid inputs that should return Error
test_error() {
    printf "${BLUE}Testing: %s${NC}\n" "[$1]"
    result=$(./push_swap "$1" 2>&1)
    if [ "$result" = "Error" ]; then
        printf "${GREEN}✓ Correctly returned Error${NC}\n"
    else
        printf "${RED}✗ Should return Error, got: %s${NC}\n" "$result"
    fi
}

echo -e "${YELLOW}=== Testing String Input Edge Cases ===${NC}"

echo -e "\n${YELLOW}1. Basic String Inputs${NC}"
test_sequence "1 2 3"
test_sequence "3 2 1"
test_sequence "1 3 2"

echo -e "\n${YELLOW}2. Multiple Spaces${NC}"
test_sequence "1   2    3"
test_sequence "1    2     3     4"
test_sequence "   1   2   3   "

echo -e "\n${YELLOW}3. Mixed Positive and Negative Numbers${NC}"
test_sequence "-1 2 -3"
test_sequence "1 -2 3 -4"
test_sequence "-1 -2 -3"

echo -e "\n${YELLOW}4. Single Number in String${NC}"
test_sequence "42"
test_sequence "-42"
test_sequence "    42    "

echo -e "\n${YELLOW}5. Large Numbers${NC}"
test_sequence "2147483647 -2147483648 0"
test_sequence "2147483647 -2147483648"
test_sequence "-2147483648 0 2147483647"

echo -e "\n${YELLOW}6. Invalid Inputs - Should Return Error${NC}"
test_error "1 2 2"               # Duplicate numbers
test_error "1 2 abc"             # Non-numeric input
test_error "1 2 2147483648"      # Number too large
test_error "1 2 -2147483649"     # Number too small
test_error ""                    # Empty string
test_error "  "                  # Only spaces
test_error "1 2+"                # Invalid sign position (after number)
test_sequence "1 +2"             # Valid (sign at start is okay)
test_error "1 2-"                # Invalid sign position (after number)
test_error "1 2.5"               # Decimal numbers
test_error "1,2,3"               # Wrong separator

echo -e "\n${YELLOW}7. Complex Mixed Cases${NC}"
test_sequence "-1    2     -3    4     -5"
test_sequence "5    -4     3    -2     1"
test_sequence "0    1      -5    -1     3"

echo -e "\n${YELLOW}8. Edge Cases with Spaces and Signs${NC}"
test_error " + "                 # Sign alone
test_error "1 2 3 -"             # Trailing sign
test_error "1 2 3+"              # Trailing sign
test_error "1 2 --3"             # Double negative
test_error "1 2 ++3"             # Double positive
test_sequence "1 +2 -3"          # Valid mixed signs
test_error " + 1 2 3"            # Invalid sign alone at start
test_error "1 2 3 -"             # Trailing sign
test_error "1 2 3+"              # Trailing sign

echo -e "\n${YELLOW}9. Zero Cases${NC}"
test_sequence "1 0 -1"           # Valid with zero
test_error "0 0 1"               # Duplicate zeros
test_sequence "-1 0 1"           # Valid with zero

echo -e "\n${YELLOW}10. Mixed Length Numbers${NC}"
test_sequence "1 123 1234 12345"
test_sequence "-1 -12 -123 -1234"
test_sequence "0 1 12 123 1234"