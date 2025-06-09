# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_big.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/27 20:15:24 by migusant          #+#    #+#              #
#    Updated: 2025/06/09 15:06:35 by migusant         ###   ########.fr        #
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
	echo -e "${BLUE}Example: bash script.sh 50 10 (will run 10 tests with 50 random numbers each)${NC}"
	exit 1
else
	NUM_COUNT=$1
	TEST_COUNT=$2
fi

# Validate input range (20-500 numbers only)
if [ $NUM_COUNT -lt 20 ] || [ $NUM_COUNT -gt 500 ]; then
	echo -e "${RED}Error: Number count must be between 20 and 500${NC}"
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
#        - At n=20: 20*ln(20) ≈ 59.91                                          #
#        - At n=100: 100*ln(100) ≈ 460.52                                      #
#        - At n=500: 500*ln(500) ≈ 3101.78                                     #
#        - For any n: n*ln(n)                                                  #
#                                                                              #
#    2. Ratio Progression for Smooth Scaling:                                  #
#        A. From n=20 to n=100:                                                #
#           - MAX ratio: 1.42 → 1.52 (increases by 0.10)                       #
#           - GOOD ratio: 1.80 → 1.95 (increases by 0.15)                      #
#           - ACCEPTABLE ratio: 2.20 → 2.39 (increases by 0.19)                #
#           Progress = (current - 20) / 80                                     #
#                                                                              #
#        B. From n=100 to n=500:                                               #
#           - MAX ratio: 1.52 → 1.77 (increases by 0.25)                       #
#           - GOOD ratio: 1.95 → 2.26 (increases by 0.31)                      #
#           - ACCEPTABLE ratio: 2.39 → 2.74 (increases by 0.35)                #
#           Progress = (current - 100) / 400                                   #
#                                                                              #
#    3. Target Calculation:                                                    #
#        For n < 100:                                                          #
#          MAX = n*log(n) * (1.42 + progress * 0.10)                           #
#          GOOD = n*log(n) * (1.80 + progress * 0.15)                          #
#          ACCEPTABLE = n*log(n) * (2.20 + progress * 0.19)                    #
#                                                                              #
#        For n >= 100:                                                         #
#          MAX = n*log(n) * (1.52 + progress * 0.25)                           #
#          GOOD = n*log(n) * (1.95 + progress * 0.31)                          #
#          ACCEPTABLE = n*log(n) * (2.39 + progress * 0.35)                    #
#                                                                              #
#    Example Targets and Ratios for Different Array Sizes:                     #
#    Numbers  n*log(n)   MAX_TARGET  (ratio)  GOOD_TARGET  (ratio)  ACCEPT     #
#       20     59.91        85      (1.42)      108       (1.80)     132       #
#       50    195.60       287      (1.47)      368       (1.88)     452       #
#      100    460.52       700      (1.52)      900       (1.95)    1100       #
#      200   1062.19      1720      (1.62)     2200       (2.07)    2700       #
#      300   1726.57      2950      (1.67)     3800       (2.13)    4650       #
#      400   2408.29      4200      (1.72)     5400       (2.20)    6600       #
#      500   3101.78      5500      (1.77)     7000       (2.26)    8500       #
#                                                                              #
#    This interpolation ensures:                                               #
#    1. Smooth progression of target values and ratios                         #
#    2. Exact matches at required points (n=100 and n=500)                     #
#    3. Maintains n*log(n) complexity with gradually increasing ratios         #
#    4. Consistent and proportional spacing between grades                     #
#    5. Lower initial ratios for small arrays (n=20) that smoothly increase    #
#                                                                              #
# **************************************************************************** #

# Calculate targets using n*log(n) interpolation with smooth ratio progression
if [ $NUM_COUNT -eq 20 ]; then
	# Base case: 20 numbers - start with lower ratios
	MAX_TARGET=85            # 1.42 * n*log(n)
	GOOD_TARGET=108         # 1.80 * n*log(n)
	ACCEPTABLE_TARGET=132   # 2.20 * n*log(n)
elif [ $NUM_COUNT -eq 100 ]; then
	# Fixed point: 100 numbers
	MAX_TARGET=700
	GOOD_TARGET=900
	ACCEPTABLE_TARGET=1100
elif [ $NUM_COUNT -eq 500 ]; then
	# Fixed point: 500 numbers
	MAX_TARGET=5500
	GOOD_TARGET=7000
	ACCEPTABLE_TARGET=8500
else
	# For numbers between 20 and 500, interpolate using smoothly changing ratios
	CURRENT_NLN=$(echo "scale=10; $NUM_COUNT * l($NUM_COUNT)" | bc -l)
	
	if [ $NUM_COUNT -lt 100 ]; then
		# Between 20 and 100: ratio smoothly increases
		PROGRESS=$(echo "scale=10; ($NUM_COUNT - 20) / 80" | bc -l)
		
		# Ratios increase from 1.42->1.52, 1.80->1.95, 2.20->2.39
		MAX_RATIO=$(echo "scale=10; 1.42 + ($PROGRESS * 0.10)" | bc -l)
		GOOD_RATIO=$(echo "scale=10; 1.80 + ($PROGRESS * 0.15)" | bc -l)
		ACCEPTABLE_RATIO=$(echo "scale=10; 2.20 + ($PROGRESS * 0.19)" | bc -l)
	else
		# Between 100 and 500: ratio smoothly increases
		PROGRESS=$(echo "scale=10; ($NUM_COUNT - 100) / 400" | bc -l)
		
		# Ratios increase from 1.52->1.77, 1.95->2.26, 2.39->2.74
		MAX_RATIO=$(echo "scale=10; 1.52 + ($PROGRESS * 0.25)" | bc -l)
		GOOD_RATIO=$(echo "scale=10; 1.95 + ($PROGRESS * 0.31)" | bc -l)
		ACCEPTABLE_RATIO=$(echo "scale=10; 2.39 + ($PROGRESS * 0.35)" | bc -l)
	fi

	MAX_TARGET=$(echo "scale=0; ($MAX_RATIO * $CURRENT_NLN)/1" | bc -l)
	GOOD_TARGET=$(echo "scale=0; ($GOOD_RATIO * $CURRENT_NLN)/1" | bc -l)
	ACCEPTABLE_TARGET=$(echo "scale=0; ($ACCEPTABLE_RATIO * $CURRENT_NLN)/1" | bc -l)
fi

# Create output directory if it doesn't exist
mkdir -p test_sort/big

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
		if [ -f "test_sort/big/test${i}_output.txt" ]; then
			OPERATION_COUNT=$(grep -v "==" "test_sort/big/test${i}_output.txt" | wc -l)
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