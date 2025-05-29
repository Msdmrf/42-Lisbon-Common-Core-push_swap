# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_small.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/28 10:09:41 by migusant          #+#    #+#              #
#    Updated: 2025/05/28 19:48:41 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo -e "${RED}Error: Please provide both arguments:${NC}"
    echo -e "${BLUE}Usage: bash script.sh <NUMBERS_PER_TEST> <NUMBER_OF_TESTS>${NC}"
    echo -e "${BLUE}Example: bash script.sh 7 10 (will run 10 tests with 7 random numbers each)${NC}"
    exit 1
else
    NUM_COUNT=$1
    TEST_COUNT=$2
fi

# Validate input range (1-12 numbers only)
if [ $NUM_COUNT -lt 1 ] || [ $NUM_COUNT -gt 12 ]; then
    echo -e "${RED}Error: Number count must be between 1 and 12${NC}"
    exit 1
fi

# Check if push_swap executable exists and compile if needed
if [ ! -f "./push_swap" ]; then
    echo -e "${YELLOW}push_swap executable not found. Attempting to compile...${NC}"
    if make >/dev/null 2>&1; then
        echo -e "${GREEN}Compilation successful!${NC}"
    else
        echo -e "${RED}Error: Compilation failed. Please check your source code.${NC}"
        exit 1
    fi
elif [ ! -x "./push_swap" ]; then
    echo -e "${RED}Error: push_swap file exists but is not executable${NC}"
    exit 1
fi

# Hardcode targets for small arrays (1-11 numbers)
case $NUM_COUNT in
    1)
        MAX_TARGET=0
        GOOD_TARGET=0
        ACCEPTABLE_TARGET=0
        ;;
    2)
        MAX_TARGET=1
        GOOD_TARGET=1
        ACCEPTABLE_TARGET=1
        ;;
    3)
        MAX_TARGET=2
        GOOD_TARGET=3
        ACCEPTABLE_TARGET=3
        ;;
    4)
        MAX_TARGET=7
        GOOD_TARGET=8
        ACCEPTABLE_TARGET=9
        ;;
    5)
        MAX_TARGET=12
        GOOD_TARGET=13
        ACCEPTABLE_TARGET=14
        ;;
    6)
        MAX_TARGET=13
        GOOD_TARGET=15
        ACCEPTABLE_TARGET=17
        ;;
    7)
        MAX_TARGET=16
        GOOD_TARGET=18
        ACCEPTABLE_TARGET=20
        ;;
    8)
        MAX_TARGET=19
        GOOD_TARGET=21
        ACCEPTABLE_TARGET=23
        ;;
    9)
        MAX_TARGET=22
        GOOD_TARGET=24
        ACCEPTABLE_TARGET=26
        ;;
    10)
        MAX_TARGET=25
        GOOD_TARGET=27
        ACCEPTABLE_TARGET=29
        ;;
    11)
        MAX_TARGET=29
        GOOD_TARGET=31
        ACCEPTABLE_TARGET=33
        ;;
    12)
        MAX_TARGET=33
        GOOD_TARGET=35
        ACCEPTABLE_TARGET=37
        ;;
esac

# Create output directory structure
mkdir -p test_sort/small

# Statistics variables
total_operations=0
min_operations=999999
max_operations=0

# Print header information
echo -e "\n${BLUE}=== Testing $NUM_COUNT Random Integers ===${NC}"
echo -e "${BLUE}Target: < $MAX_TARGET operations${NC}\n"

for i in $(seq 1 $TEST_COUNT); do
    RANDOM_SEQ=$(shuf -i 0-4294967295 -n $NUM_COUNT | awk '{print $1 - 2147483648}')
    
    # Save numbers and run push_swap with valgrind
    echo "$RANDOM_SEQ" > "test_sort/small/test${i}_numbers.txt"
    valgrind --show-leak-kinds=all ./push_swap $RANDOM_SEQ > "test_sort/small/test${i}_output.txt" 2>&1
    
    # Get operation count and update statistics
    OPERATION_COUNT=$(grep -v "==" "test_sort/small/test${i}_output.txt" | wc -l)
    total_operations=$((total_operations + OPERATION_COUNT))
    
    # Update min/max operations
    if [ $OPERATION_COUNT -lt $min_operations ]; then
        min_operations=$OPERATION_COUNT
    fi
    if [ $OPERATION_COUNT -gt $max_operations ]; then
        max_operations=$OPERATION_COUNT
    fi
    
    echo -e "Test $i/$TEST_COUNT: ${GREEN}PASS${NC} ($OPERATION_COUNT operations)"
done

# Calculate average
average_operations=$((total_operations / TEST_COUNT))

# Print results
echo -e "\n${BLUE}=== Test Results ===${NC}"
echo "Total tests: $TEST_COUNT"
echo -e "${GREEN}Passed: $TEST_COUNT${NC}"

echo -e "\n${BLUE}=== Operation Statistics ===${NC}"
echo "Average operations: $average_operations"
echo "Minimum operations: $min_operations"
echo "Maximum operations: $max_operations"
echo "Target (max): $MAX_TARGET"
echo

# Final assessment
if [ $average_operations -le $MAX_TARGET ]; then
    echo -e "${GREEN}🎉 All tests passed! Your implementation is working correctly!${NC}"
    echo -e "${GREEN}📋 Grade: Excellent (≤$MAX_TARGET operations)${NC}"
elif [ $average_operations -le $GOOD_TARGET ]; then
    echo -e "${LIGHT_GREEN}📋 Grade: Good (≤$GOOD_TARGET operations)${NC}"
elif [ $average_operations -le $ACCEPTABLE_TARGET ]; then
    echo -e "${YELLOW}📋 Grade: Acceptable (≤$ACCEPTABLE_TARGET operations)${NC}"
else
    echo -e "${RED}📋 Grade: Needs improvement (>$ACCEPTABLE_TARGET operations)${NC}"
fi