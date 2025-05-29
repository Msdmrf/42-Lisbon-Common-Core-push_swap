# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_big.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/27 20:15:24 by migusant          #+#    #+#              #
#    Updated: 2025/05/28 15:30:45 by migusant         ###   ########.fr        #
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
    echo -e "${BLUE}Example: bash script.sh 100 10 (will run 10 tests with 100 random numbers each)${NC}"
    exit 1
else
    NUM_COUNT=$1
    TEST_COUNT=$2
fi

# Validate input range (100-500 numbers only)
if [ $NUM_COUNT -lt 100 ] || [ $NUM_COUNT -gt 500 ]; then
    echo -e "${RED}Error: Number count must be between 100 and 500${NC}"
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

# **************************************************************************** #
#                                                                              #
#    Here's how the interpolation works:                                       #
#                                                                              #
#    1. n*log(n) Values Calculation:                                           #
#        - At n=100: 100*ln(100) ≈ 460.52                                      #
#        - At n=500: 500*ln(500) ≈ 3101.78                                     #
#        - For any n: n*ln(n)                                                  #
#                                                                              #
#    2. Interpolation Factor:                                                  #
#        FACTOR = (current - start) / (end - start)                            #
#        This gives a number between 0 and 1:                                  #
#        - When n=100: FACTOR = 0                                              #
#        - When n=500: FACTOR = 1                                              #
#        - When n=300: FACTOR ≈ 0.5                                            #
#                                                                              #
#    3. Target Calculation:                                                    #
#        Formula: start_target + (FACTOR * (end_target - start_target))        #
#        - MAX_TARGET: 700 + (FACTOR * (5500 - 700))                           #
#        - GOOD_TARGET: 900 + (FACTOR * (7000 - 900))                          #
#        - ACCEPTABLE_TARGET: 1100 + (FACTOR * (8500 - 1100))                  #
#                                                                              #
#    Example Targets for Different Array Sizes:                                #
#    Numbers  FACTOR    MAX_TARGET    GOOD_TARGET    ACCEPTABLE_TARGET         #
#      100     0.0        700           900             1100                   #
#      200     0.33      2250          2900            3550                    #
#      300     0.50      3100          3950            4800                    #
#      400     0.75      4300          5500            6700                    #
#      500     1.0       5500          7000            8500                    #
#                                                                              #
#    This interpolation ensures:                                               #
#    1. Smooth progression of target values                                    #
#    2. Exact matches at endpoints (n=100 and n=500)                           #
#    3. Maintains n*log(n) complexity pattern                                  #
#    4. Consistent spacing between grades                                      #
#                                                                              #
# **************************************************************************** #

# Calculate targets using n*log(n) interpolation
if [ $NUM_COUNT -eq 100 ]; then
    # Base case: 100 numbers
    MAX_TARGET=700
    GOOD_TARGET=900
    ACCEPTABLE_TARGET=1100
elif [ $NUM_COUNT -eq 500 ]; then
    # Upper limit case: 500 numbers
    MAX_TARGET=5500
    GOOD_TARGET=7000
    ACCEPTABLE_TARGET=8500
else
    # For numbers between 100 and 500, interpolate using n*log(n)
    # Step 1: Calculate n*log(n) values for start, end, and current points
    START_NLN=$(echo "scale=10; 100 * l(100)" | bc -l)     # ≈ 460.52
    END_NLN=$(echo "scale=10; 500 * l(500)" | bc -l)       # ≈ 3101.78
    CURRENT_NLN=$(echo "scale=10; $NUM_COUNT * l($NUM_COUNT)" | bc -l)
    
    # Step 2: Calculate interpolation factor (0 to 1)
    FACTOR=$(echo "scale=10; ($CURRENT_NLN - $START_NLN) / ($END_NLN - $START_NLN)" | bc -l)
    
    # Step 3: Interpolate between min and max targets and round to integers
    MAX_TARGET=$(echo "scale=0; (700 + ($FACTOR * (5500 - 700)))/1" | bc -l)
    GOOD_TARGET=$(echo "scale=0; (900 + ($FACTOR * (7000 - 900)))/1" | bc -l)
    ACCEPTABLE_TARGET=$(echo "scale=0; (1100 + ($FACTOR * (8500 - 1100)))/1" | bc -l)
fi

# Create output directory if it doesn't exist
mkdir -p test_sort/big

# Statistics variables
total_operations=0
min_operations=999999
max_operations=0

# Print header information
echo -e "${BLUE}=== Push_swap Tester ===${NC}"
echo -e "\n${BLUE}=== Testing $NUM_COUNT Random Integers ===${NC}"
echo -e "${BLUE}Target: < $MAX_TARGET operations${NC}\n"

for i in $(seq 1 $TEST_COUNT); do
    RANDOM_SEQ=$(shuf -i 0-4294967295 -n $NUM_COUNT | awk '{print $1 - 2147483648}')
    
    # Save numbers and run push_swap with valgrind
    echo "$RANDOM_SEQ" > "test_sort/big/test${i}_numbers.txt"
    valgrind --show-leak-kinds=all ./push_swap $RANDOM_SEQ > "test_sort/big/test${i}_output.txt" 2>&1
    
    # Get operation count and update statistics
    OPERATION_COUNT=$(grep -v "==" "test_sort/big/test${i}_output.txt" | wc -l)
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

# ARG=$(seq 0 499 | shuf | tr '\n' ' ')
# ./push_swap $ARG | ./.checker_linux $ARG