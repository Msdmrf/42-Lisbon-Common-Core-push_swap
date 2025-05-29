# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_five.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/22 17:28:04 by migusant          #+#    #+#              #
#    Updated: 2025/05/29 12:04:36 by migusant         ###   ########.fr        #
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

echo -e "${YELLOW}=== Testing Five Number Sequences ===${NC}"

echo -e "\n${YELLOW}1.1. Permutations Starting with 1${NC}"
test_sequence 1 2 3 4 5              # Already sorted
test_sequence 1 2 3 5 4              # Last pair swapped
test_sequence 1 2 4 3 5              # Middle pair swapped
test_sequence 1 2 4 5 3              # Last number misplaced
test_sequence 1 2 5 3 4              # Last three mixed
test_sequence 1 2 5 4 3              # Last three reversed
test_sequence 1 3 2 4 5              # Second number misplaced
test_sequence 1 3 2 5 4              # Last three mixed
test_sequence 1 3 4 2 5              # Middle numbers mixed
test_sequence 1 3 4 5 2              # Last number misplaced
test_sequence 1 3 5 2 4              # Middle numbers mixed
test_sequence 1 3 5 4 2              # Last three mixed
test_sequence 1 4 2 3 5              # Second number misplaced
test_sequence 1 4 2 5 3              # Last three mixed
test_sequence 1 4 3 2 5              # Middle numbers reversed
test_sequence 1 4 3 5 2              # Last three mixed
test_sequence 1 4 5 2 3              # Last four mixed
test_sequence 1 4 5 3 2              # Last four mixed
test_sequence 1 5 2 3 4              # Second number misplaced
test_sequence 1 5 2 4 3              # Last four mixed
test_sequence 1 5 3 2 4              # Middle numbers mixed
test_sequence 1 5 3 4 2              # Last four mixed
test_sequence 1 5 4 2 3              # Last four mixed
test_sequence 1 5 4 3 2              # Last four reversed

echo -e "\n${YELLOW}1.2. Permutations Starting with 2${NC}"
test_sequence 2 1 3 4 5              # First pair swapped
test_sequence 2 1 3 5 4              # First and last pairs swapped
test_sequence 2 1 4 3 5              # Mixed order
test_sequence 2 1 4 5 3              # Mixed order
test_sequence 2 1 5 3 4              # Mixed order
test_sequence 2 1 5 4 3              # Mixed order
test_sequence 2 3 1 4 5              # Three numbers mixed
test_sequence 2 3 1 5 4              # Complex mix
test_sequence 2 3 4 1 5              # Fourth number misplaced
test_sequence 2 3 4 5 1              # Last number misplaced
test_sequence 2 3 5 1 4              # Complex mix
test_sequence 2 3 5 4 1              # Last two mixed
test_sequence 2 4 1 3 5              # Complex mix
test_sequence 2 4 1 5 3              # Complex mix
test_sequence 2 4 3 1 5              # Complex mix
test_sequence 2 4 3 5 1              # Complex mix
test_sequence 2 4 5 1 3              # Complex mix
test_sequence 2 4 5 3 1              # Complex mix
test_sequence 2 5 1 3 4              # Complex mix
test_sequence 2 5 1 4 3              # Complex mix
test_sequence 2 5 3 1 4              # Complex mix
test_sequence 2 5 3 4 1              # Complex mix
test_sequence 2 5 4 1 3              # Complex mix
test_sequence 2 5 4 3 1              # Complex mix

echo -e "\n${YELLOW}1.3. Permutations Starting with 3${NC}"
test_sequence 3 1 2 4 5              # First number misplaced
test_sequence 3 1 2 5 4              # First number and last pair swapped
test_sequence 3 1 4 2 5              # Complex mix
test_sequence 3 1 4 5 2              # Complex mix
test_sequence 3 1 5 2 4              # Complex mix
test_sequence 3 1 5 4 2              # Complex mix
test_sequence 3 2 1 4 5              # First three mixed
test_sequence 3 2 1 5 4              # Complex mix
test_sequence 3 2 4 1 5              # Complex mix
test_sequence 3 2 4 5 1              # Complex mix
test_sequence 3 2 5 1 4              # Complex mix
test_sequence 3 2 5 4 1              # Complex mix
test_sequence 3 4 1 2 5              # Complex mix
test_sequence 3 4 1 5 2              # Complex mix
test_sequence 3 4 2 1 5              # Complex mix
test_sequence 3 4 2 5 1              # Complex mix
test_sequence 3 4 5 1 2              # Complex mix
test_sequence 3 4 5 2 1              # Complex mix
test_sequence 3 5 1 2 4              # Complex mix
test_sequence 3 5 1 4 2              # Complex mix
test_sequence 3 5 2 1 4              # Complex mix
test_sequence 3 5 2 4 1              # Complex mix
test_sequence 3 5 4 1 2              # Complex mix
test_sequence 3 5 4 2 1              # Complex mix

echo -e "\n${YELLOW}1.4. Permutations Starting with 4${NC}"
test_sequence 4 1 2 3 5              # First number misplaced
test_sequence 4 1 2 5 3              # Complex mix
test_sequence 4 1 3 2 5              # Complex mix
test_sequence 4 1 3 5 2              # Complex mix
test_sequence 4 1 5 2 3              # Complex mix
test_sequence 4 1 5 3 2              # Complex mix
test_sequence 4 2 1 3 5              # Complex mix
test_sequence 4 2 1 5 3              # Complex mix
test_sequence 4 2 3 1 5              # Complex mix
test_sequence 4 2 3 5 1              # Complex mix
test_sequence 4 2 5 1 3              # Complex mix
test_sequence 4 2 5 3 1              # Complex mix
test_sequence 4 3 1 2 5              # Complex mix
test_sequence 4 3 1 5 2              # Complex mix
test_sequence 4 3 2 1 5              # Complex mix
test_sequence 4 3 2 5 1              # Complex mix
test_sequence 4 3 5 1 2              # Complex mix
test_sequence 4 3 5 2 1              # Complex mix
test_sequence 4 5 1 2 3              # Complex mix
test_sequence 4 5 1 3 2              # Complex mix
test_sequence 4 5 2 1 3              # Complex mix
test_sequence 4 5 2 3 1              # Complex mix
test_sequence 4 5 3 1 2              # Complex mix
test_sequence 4 5 3 2 1              # Complex mix

echo -e "\n${YELLOW}1.5. Permutations Starting with 5${NC}"
test_sequence 5 1 2 3 4              # First number misplaced
test_sequence 5 1 2 4 3              # Complex mix
test_sequence 5 1 3 2 4              # Complex mix
test_sequence 5 1 3 4 2              # Complex mix
test_sequence 5 1 4 2 3              # Complex mix
test_sequence 5 1 4 3 2              # Complex mix
test_sequence 5 2 1 3 4              # Complex mix
test_sequence 5 2 1 4 3              # Complex mix
test_sequence 5 2 3 1 4              # Complex mix
test_sequence 5 2 3 4 1              # Complex mix
test_sequence 5 2 4 1 3              # Complex mix
test_sequence 5 2 4 3 1              # Complex mix
test_sequence 5 3 1 2 4              # Complex mix
test_sequence 5 3 1 4 2              # Complex mix
test_sequence 5 3 2 1 4              # Complex mix
test_sequence 5 3 2 4 1              # Complex mix
test_sequence 5 3 4 1 2              # Complex mix
test_sequence 5 3 4 2 1              # Complex mix
test_sequence 5 4 1 2 3              # Complex mix
test_sequence 5 4 1 3 2              # Complex mix
test_sequence 5 4 2 1 3              # Complex mix
test_sequence 5 4 2 3 1              # Complex mix
test_sequence 5 4 3 1 2              # Complex mix
test_sequence 5 4 3 2 1              # Fully reversed

echo -e "\n${YELLOW}2.1. Negative Permutations Starting with -1${NC}"
test_sequence -1 -2 -3 -4 -5         # Negative sorted
test_sequence -1 -2 -3 -5 -4         # Last pair swapped
test_sequence -1 -2 -4 -3 -5         # Middle pair swapped
test_sequence -1 -2 -4 -5 -3         # Last number misplaced
test_sequence -1 -2 -5 -3 -4         # Last three mixed
test_sequence -1 -2 -5 -4 -3         # Last three reversed
test_sequence -1 -3 -2 -4 -5         # Second number misplaced
test_sequence -1 -3 -2 -5 -4         # Last three mixed
test_sequence -1 -3 -4 -2 -5         # Middle numbers mixed
test_sequence -1 -3 -4 -5 -2         # Last number misplaced
test_sequence -1 -3 -5 -2 -4         # Middle numbers mixed
test_sequence -1 -3 -5 -4 -2         # Last three mixed
test_sequence -1 -4 -2 -3 -5         # Second number misplaced
test_sequence -1 -4 -2 -5 -3         # Last three mixed
test_sequence -1 -4 -3 -2 -5         # Middle numbers reversed
test_sequence -1 -4 -3 -5 -2         # Last three mixed
test_sequence -1 -4 -5 -2 -3         # Last four mixed
test_sequence -1 -4 -5 -3 -2         # Last four mixed
test_sequence -1 -5 -2 -3 -4         # Second number misplaced
test_sequence -1 -5 -2 -4 -3         # Last four mixed
test_sequence -1 -5 -3 -2 -4         # Middle numbers mixed
test_sequence -1 -5 -3 -4 -2         # Last four mixed
test_sequence -1 -5 -4 -2 -3         # Last four mixed
test_sequence -1 -5 -4 -3 -2         # Last four reversed

echo -e "\n${YELLOW}2.2. Negative Permutations Starting with -2${NC}"
test_sequence -2 -1 -3 -4 -5         # First pair swapped
test_sequence -2 -1 -3 -5 -4         # First and last pairs swapped
test_sequence -2 -1 -4 -3 -5         # Mixed order
test_sequence -2 -1 -4 -5 -3         # Mixed order
test_sequence -2 -1 -5 -3 -4         # Mixed order
test_sequence -2 -1 -5 -4 -3         # Mixed order
test_sequence -2 -3 -1 -4 -5         # Three numbers mixed
test_sequence -2 -3 -1 -5 -4         # Complex mix
test_sequence -2 -3 -4 -1 -5         # Fourth number misplaced
test_sequence -2 -3 -4 -5 -1         # Last number misplaced
test_sequence -2 -3 -5 -1 -4         # Complex mix
test_sequence -2 -3 -5 -4 -1         # Last two mixed
test_sequence -2 -4 -1 -3 -5         # Complex mix
test_sequence -2 -4 -1 -5 -3         # Complex mix
test_sequence -2 -4 -3 -1 -5         # Complex mix
test_sequence -2 -4 -3 -5 -1         # Complex mix
test_sequence -2 -4 -5 -1 -3         # Complex mix
test_sequence -2 -4 -5 -3 -1         # Complex mix
test_sequence -2 -5 -1 -3 -4         # Complex mix
test_sequence -2 -5 -1 -4 -3         # Complex mix
test_sequence -2 -5 -3 -1 -4         # Complex mix
test_sequence -2 -5 -3 -4 -1         # Complex mix
test_sequence -2 -5 -4 -1 -3         # Complex mix
test_sequence -2 -5 -4 -3 -1         # Complex mix

echo -e "\n${YELLOW}2.3. Negative Permutations Starting with -3${NC}"
test_sequence -3 -1 -2 -4 -5         # First number misplaced
test_sequence -3 -1 -2 -5 -4         # First number and last pair swapped
test_sequence -3 -1 -4 -2 -5         # Complex mix
test_sequence -3 -1 -4 -5 -2         # Complex mix
test_sequence -3 -1 -5 -2 -4         # Complex mix
test_sequence -3 -1 -5 -4 -2         # Complex mix
test_sequence -3 -2 -1 -4 -5         # First three mixed
test_sequence -3 -2 -1 -5 -4         # Complex mix
test_sequence -3 -2 -4 -1 -5         # Complex mix
test_sequence -3 -2 -4 -5 -1         # Complex mix
test_sequence -3 -2 -5 -1 -4         # Complex mix
test_sequence -3 -2 -5 -4 -1         # Complex mix
test_sequence -3 -4 -1 -2 -5         # Complex mix
test_sequence -3 -4 -1 -5 -2         # Complex mix
test_sequence -3 -4 -2 -1 -5         # Complex mix
test_sequence -3 -4 -2 -5 -1         # Complex mix
test_sequence -3 -4 -5 -1 -2         # Complex mix
test_sequence -3 -4 -5 -2 -1         # Complex mix
test_sequence -3 -5 -1 -2 -4         # Complex mix
test_sequence -3 -5 -1 -4 -2         # Complex mix
test_sequence -3 -5 -2 -1 -4         # Complex mix
test_sequence -3 -5 -2 -4 -1         # Complex mix
test_sequence -3 -5 -4 -1 -2         # Complex mix
test_sequence -3 -5 -4 -2 -1         # Complex mix

echo -e "\n${YELLOW}2.4. Negative Permutations Starting with -4${NC}"
test_sequence -4 -1 -2 -3 -5         # First number misplaced
test_sequence -4 -1 -2 -5 -3         # Complex mix
test_sequence -4 -1 -3 -2 -5         # Complex mix
test_sequence -4 -1 -3 -5 -2         # Complex mix
test_sequence -4 -1 -5 -2 -3         # Complex mix
test_sequence -4 -1 -5 -3 -2         # Complex mix
test_sequence -4 -2 -1 -3 -5         # Complex mix
test_sequence -4 -2 -1 -5 -3         # Complex mix
test_sequence -4 -2 -3 -1 -5         # Complex mix
test_sequence -4 -2 -3 -5 -1         # Complex mix
test_sequence -4 -2 -5 -1 -3         # Complex mix
test_sequence -4 -2 -5 -3 -1         # Complex mix
test_sequence -4 -3 -1 -2 -5         # Complex mix
test_sequence -4 -3 -1 -5 -2         # Complex mix
test_sequence -4 -3 -2 -1 -5         # Complex mix
test_sequence -4 -3 -2 -5 -1         # Complex mix
test_sequence -4 -3 -5 -1 -2         # Complex mix
test_sequence -4 -3 -5 -2 -1         # Complex mix
test_sequence -4 -5 -1 -2 -3         # Complex mix
test_sequence -4 -5 -1 -3 -2         # Complex mix
test_sequence -4 -5 -2 -1 -3         # Complex mix
test_sequence -4 -5 -2 -3 -1         # Complex mix
test_sequence -4 -5 -3 -1 -2         # Complex mix
test_sequence -4 -5 -3 -2 -1         # Complex mix

echo -e "\n${YELLOW}2.5. Negative Permutations Starting with -5${NC}"
test_sequence -5 -1 -2 -3 -4         # First number misplaced
test_sequence -5 -1 -2 -4 -3         # Complex mix
test_sequence -5 -1 -3 -2 -4         # Complex mix
test_sequence -5 -1 -3 -4 -2         # Complex mix
test_sequence -5 -1 -4 -2 -3         # Complex mix
test_sequence -5 -1 -4 -3 -2         # Complex mix
test_sequence -5 -2 -1 -3 -4         # Complex mix
test_sequence -5 -2 -1 -4 -3         # Complex mix
test_sequence -5 -2 -3 -1 -4         # Complex mix
test_sequence -5 -2 -3 -4 -1         # Complex mix
test_sequence -5 -2 -4 -1 -3         # Complex mix
test_sequence -5 -2 -4 -3 -1         # Complex mix
test_sequence -5 -3 -1 -2 -4         # Complex mix
test_sequence -5 -3 -1 -4 -2         # Complex mix
test_sequence -5 -3 -2 -1 -4         # Complex mix
test_sequence -5 -3 -2 -4 -1         # Complex mix
test_sequence -5 -3 -4 -1 -2         # Complex mix
test_sequence -5 -3 -4 -2 -1         # Complex mix
test_sequence -5 -4 -1 -2 -3         # Complex mix
test_sequence -5 -4 -1 -3 -2         # Complex mix
test_sequence -5 -4 -2 -1 -3         # Complex mix
test_sequence -5 -4 -2 -3 -1         # Complex mix
test_sequence -5 -4 -3 -1 -2         # Complex mix
test_sequence -5 -4 -3 -2 -1         # Fully reversed negative

echo -e "\n${YELLOW}3. Mixed Numbers${NC}"
test_sequence -2 -1 0 1 2            # Symmetric around zero
test_sequence 2 1 0 -1 -2            # Reversed around zero
test_sequence -1 1 -2 2 0            # Alternating with zero
test_sequence 0 -2 2 -1 1            # Mixed with zero

echo -e "\n${YELLOW}4. Big Numbers${NC}"
test_sequence 2147483647 1 -1 -2147483648 0        # Extremes with others
test_sequence -2147483648 0 2147483647 1 -1        # Mixed with extremes
test_sequence 1 2147483647 -2147483648 0 -1        # Another mix with extremes

echo -e "\n${YELLOW}5. Error Cases${NC}"
test_error 2147483648 1 2 3 4                      # Greater than INT_MAX
test_error 1 -2147483649 2 3 4                     # Less than INT_MIN
test_error 1 2 2 3 4                               # Duplicate numbers
test_error 0 1 0 2 3                               # Duplicate zeros
test_error -1 2 3 -1 4                             # Duplicate negatives
test_error 1 one 2 3 4                             # Non-numeric input
test_error 1 2 2147483648abc 3 4                   # Invalid number format
test_error 1 ++2 3 4 5                             # Double positive
test_error --1 2 3 4 5                             # Double negative

echo -e "\n${YELLOW}6. Special Cases${NC}"
test_sequence 42 -42 0 21 -21                      # Symmetric pairs with zero
test_sequence -100 100 0 50 -50                    # Another symmetric set
test_sequence 1000 -1000 500 -500 0                # Large symmetric pairs
test_sequence -50 50 -25 25 0                      # Scaled symmetric pairs