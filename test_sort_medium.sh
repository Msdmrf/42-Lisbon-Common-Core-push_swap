# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_medium.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/28 10:01:52 by migusant          #+#    #+#              #
#    Updated: 2025/06/03 18:13:09 by migusant         ###   ########.fr        #
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
    echo -e "${BLUE}Example: bash script.sh 13 10 (will run 10 tests with 13 random numbers each)${NC}"
    exit 1
else
    NUM_COUNT=$1
    TEST_COUNT=$2
fi

# Validate input range (13-99 numbers only)
if [ $NUM_COUNT -lt 13 ] || [ $NUM_COUNT -gt 99 ]; then
    echo -e "${RED}Error: Number count must be between 13 and 99${NC}"
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

# Check if checker exists
if [ ! -f "./.checker_linux" ] || [ ! -x "./.checker_linux" ]; then
    echo -e "${RED}Error: .checker_linux not found or not executable${NC}"
    exit 1
fi

# **************************************************************************** #
#                                                                              #
#    Here's how the interpolation works:                                       #
#                                                                              #
#    1. n*log(n) Values Calculation:                                           #
#        - At n=13: 13*ln(13) ≈ 33.38                                          #
#        - At n=99: 99*ln(99) ≈ 458.21                                         #
#        - For any n: n*ln(n)                                                  #
#                                                                              #
#    2. Interpolation Factor:                                                  #
#        FACTOR = (current - start) / (end - start)                            #
#        This gives a number between 0 and 1:                                  #
#        - When n=13: FACTOR = 0                                               #
#        - When n=99: FACTOR = 1                                               #
#        - When n=50: FACTOR ≈ 0.45                                            #
#                                                                              #
#    3. Target Calculation:                                                    #
#        Formula: start_target + (FACTOR * (end_target - start_target))        #
#        - MAX_TARGET: 35 + (FACTOR * (690 - 35))                              #
#        - GOOD_TARGET: 37 + (FACTOR * (890 - 37))                             #
#        - ACCEPTABLE_TARGET: 39 + (FACTOR * (1090 - 39))                      #
#                                                                              #
#    Example Targets for Different Array Sizes:                                #
#    Numbers  FACTOR    MAX_TARGET    GOOD_TARGET    ACCEPTABLE_TARGET         #
#       13      0.0         35            37              39                   #
#       25      0.25       120           160             200                   #
#       50      0.45       320           420             520                   #
#       75      0.75       500           650             800                   #
#       99      1.0        690           890            1090                   #
#                                                                              #
#    This interpolation ensures:                                               #
#    1. Smooth progression of target values                                    #
#    2. Exact matches at endpoints (n=13 and n=99)                             #
#    3. Maintains n*log(n) complexity pattern                                  #
#    4. Consistent spacing between grades                                      #
#                                                                              #
# **************************************************************************** #

# Calculate targets using n*log(n) interpolation
if [ $NUM_COUNT -eq 13 ]; then
    # Base case: 13 numbers
    MAX_TARGET=35
    GOOD_TARGET=37
    ACCEPTABLE_TARGET=39
elif [ $NUM_COUNT -eq 99 ]; then
    # Upper limit case: 99 numbers
    MAX_TARGET=690
    GOOD_TARGET=890
    ACCEPTABLE_TARGET=1090
else
    # For numbers between 13 and 99, interpolate using n*log(n)
    # Step 1: Calculate n*log(n) values for start, end, and current points
    START_NLN=$(echo "scale=10; 13 * l(13)" | bc -l)     # ≈ 33.38
    END_NLN=$(echo "scale=10; 99 * l(99)" | bc -l)       # ≈ 458.21
    CURRENT_NLN=$(echo "scale=10; $NUM_COUNT * l($NUM_COUNT)" | bc -l)
    
    # Step 2: Calculate interpolation factor (0 to 1)
    FACTOR=$(echo "scale=10; ($CURRENT_NLN - $START_NLN) / ($END_NLN - $START_NLN)" | bc -l)
    
    # Step 3: Interpolate between min and max targets and round to integers
    MAX_TARGET=$(echo "scale=0; (35 + ($FACTOR * (690 - 35)))/1" | bc -l)
    GOOD_TARGET=$(echo "scale=0; (37 + ($FACTOR * (890 - 37)))/1" | bc -l)
    ACCEPTABLE_TARGET=$(echo "scale=0; (39 + ($FACTOR * (1090 - 39)))/1" | bc -l)
fi

# Create output directory structure
mkdir -p test_sort/medium

# Statistics variables
total_operations=0
min_operations=999999
max_operations=0
failed_tests=0

# Print header information
echo -e "\n${BLUE}=== Testing $NUM_COUNT Random Integers ===${NC}"
echo "Targets:"
echo -e "${GREEN}Excellent: ≤ $MAX_TARGET operations${NC}"
echo -e "${LIGHT_GREEN}Good: ≤ $GOOD_TARGET operations${NC}"
echo -e "${YELLOW}Acceptable: ≤ $ACCEPTABLE_TARGET operations${NC}"
echo -e "${RED}Needs improvement: > $ACCEPTABLE_TARGET operations${NC}\n"

for i in $(seq 1 $TEST_COUNT); do
    RANDOM_SEQ=$(shuf -i 0-4294967295 -n $NUM_COUNT | awk '{print $1 - 2147483648}')

    # First check if sorting is correct using checker
    CHECKER_RESULT=$(./push_swap $RANDOM_SEQ | ./.checker_linux $RANDOM_SEQ)
    
    if [ "$CHECKER_RESULT" != "OK" ]; then
        echo -e "Test $i/$TEST_COUNT: ${RED}FAIL${NC} - Stack not correctly sorted"
        failed_tests=$((failed_tests + 1))
        continue
    fi
    
    # Save numbers and run push_swap with valgrind
    echo "$RANDOM_SEQ" > "test_sort/medium/test${i}_numbers.txt"
    valgrind --show-leak-kinds=all ./push_swap $RANDOM_SEQ > "test_sort/medium/test${i}_output.txt" 2>&1
    
    # Get operation count and update statistics
    OPERATION_COUNT=$(grep -v "==" "test_sort/medium/test${i}_output.txt" | wc -l)
    total_operations=$((total_operations + OPERATION_COUNT))
    
    # Update min/max operations
    if [ $OPERATION_COUNT -lt $min_operations ]; then
        min_operations=$OPERATION_COUNT
    fi
    if [ $OPERATION_COUNT -gt $max_operations ]; then
        max_operations=$OPERATION_COUNT
    fi
    
    # Color the PASS based on operation count
    if [ $OPERATION_COUNT -le $MAX_TARGET ]; then
        echo -e "Test $i/$TEST_COUNT: ${GREEN}PASS${NC} ($OPERATION_COUNT operations)"
    elif [ $OPERATION_COUNT -le $GOOD_TARGET ]; then
        echo -e "Test $i/$TEST_COUNT: ${LIGHT_GREEN}PASS${NC} ($OPERATION_COUNT operations)"
    elif [ $OPERATION_COUNT -le $ACCEPTABLE_TARGET ]; then
        echo -e "Test $i/$TEST_COUNT: ${YELLOW}PASS${NC} ($OPERATION_COUNT operations)"
    else
        echo -e "Test $i/$TEST_COUNT: ${RED}PASS${NC} ($OPERATION_COUNT operations)"
    fi
done

# Calculate average
average_operations=$((total_operations / TEST_COUNT))

# Print results
echo -e "\n${BLUE}=== Test Results ===${NC}"
echo "Total: $TEST_COUNT"
echo "Failed: $failed_tests"
successful_tests=$((TEST_COUNT - failed_tests))
echo "Passed: $successful_tests"

# Only show categories breakdown if there are no failed tests
if [ $failed_tests -eq 0 ]; then
    # Only count successful tests for categories
    excellent_count=0
    good_count=0
    acceptable_count=0
    needs_improvement_count=0

    # Only process successful tests
    for i in $(seq 1 $TEST_COUNT); do
        if [ -f "test_sort/medium/test${i}_output.txt" ]; then
            OPERATION_COUNT=$(grep -v "==" "test_sort/medium/test${i}_output.txt" | wc -l)
            if [ $OPERATION_COUNT -le $MAX_TARGET ]; then
                excellent_count=$((excellent_count + 1))
            elif [ $OPERATION_COUNT -le $GOOD_TARGET ]; then
                good_count=$((good_count + 1))
            elif [ $OPERATION_COUNT -le $ACCEPTABLE_TARGET ]; then
                acceptable_count=$((acceptable_count + 1))
            else
                needs_improvement_count=$((needs_improvement_count + 1))
            fi
        fi
    done

    # Display results by category only if there are no failed tests
    echo -e "\n${BLUE}=== Test Results by Category ===${NC}"
    [ $excellent_count -gt 0 ] && echo -e "${GREEN}Excellent: $excellent_count${NC}"
    [ $good_count -gt 0 ] && echo -e "${LIGHT_GREEN}Good: $good_count${NC}"
    [ $acceptable_count -gt 0 ] && echo -e "${YELLOW}Acceptable: $acceptable_count${NC}"
    [ $needs_improvement_count -gt 0 ] && echo -e "${RED}Needs improvement: $needs_improvement_count${NC}"
fi

echo -e "\n${BLUE}=== Operation Statistics ===${NC}"
# Only calculate average if there are successful tests
if [ $successful_tests -gt 0 ]; then
    average_operations=$((total_operations / successful_tests))
    echo "Average operations: $average_operations"
    echo "Minimum operations: $min_operations"
    echo "Maximum operations: $max_operations"
else
    echo "No successful tests to calculate statistics"
fi
echo

# Final assessment
if [ $failed_tests -gt 0 ]; then
    echo -e "${RED}❌ Some tests failed! Please check your implementation.${NC}\n"
elif [ $average_operations -le $MAX_TARGET ]; then
    echo -e "${GREEN}🎉 All tests passed! Your implementation is working correctly!${NC}\n"
    echo -e "${GREEN}📋 Grade: Excellent (≤$MAX_TARGET operations)${NC}\n"
elif [ $average_operations -le $GOOD_TARGET ]; then
    echo -e "${LIGHT_GREEN}📋 Grade: Good (≤$GOOD_TARGET operations)${NC}\n"
elif [ $average_operations -le $ACCEPTABLE_TARGET ]; then
    echo -e "${YELLOW}📋 Grade: Acceptable (≤$ACCEPTABLE_TARGET operations)${NC}\n"
else
    echo -e "${RED}📋 Grade: Needs improvement (>$ACCEPTABLE_TARGET operations)${NC}\n"
fi