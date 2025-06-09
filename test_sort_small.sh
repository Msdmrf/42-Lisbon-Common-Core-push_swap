# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_sort_small.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/28 10:09:41 by migusant          #+#    #+#              #
#    Updated: 2025/06/09 15:06:39 by migusant         ###   ########.fr        #
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

# Validate input range (1-19 numbers only)
if [ $NUM_COUNT -lt 1 ] || [ $NUM_COUNT -gt 19 ]; then
	echo -e "${RED}Error: Number count must be between 1 and 19${NC}"
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

# Hardcode targets for small arrays (2-19 numbers)
case $NUM_COUNT in
	2)
		MAX_TARGET=0
		GOOD_TARGET=1
		ACCEPTABLE_TARGET=1
		;;
	3)
		MAX_TARGET=1
		GOOD_TARGET=2
		ACCEPTABLE_TARGET=2
		;;
	4)
		MAX_TARGET=4
		GOOD_TARGET=5
		ACCEPTABLE_TARGET=6
		;;
	5)
		MAX_TARGET=8
		GOOD_TARGET=9
		ACCEPTABLE_TARGET=10
		;;
	6)
		MAX_TARGET=11       # +3
		GOOD_TARGET=14      # ~1.27 ratio
		ACCEPTABLE_TARGET=17 # ~1.55 ratio
		;;
	7)
		MAX_TARGET=14       # +3
		GOOD_TARGET=18      # ~1.27 ratio
		ACCEPTABLE_TARGET=22 # ~1.55 ratio
		;;
	8)
		MAX_TARGET=17       # +3
		GOOD_TARGET=22      # ~1.27 ratio
		ACCEPTABLE_TARGET=27 # ~1.55 ratio
		;;
	9)
		MAX_TARGET=21       # +4
		GOOD_TARGET=27      # ~1.27 ratio
		ACCEPTABLE_TARGET=33 # ~1.55 ratio
		;;
	10)
		MAX_TARGET=25       # +4
		GOOD_TARGET=32      # ~1.27 ratio
		ACCEPTABLE_TARGET=39 # ~1.55 ratio
		;;
	11)
		MAX_TARGET=29       # +4
		GOOD_TARGET=37      # ~1.27 ratio
		ACCEPTABLE_TARGET=45 # ~1.55 ratio
		;;
	12)
		MAX_TARGET=34       # +5
		GOOD_TARGET=43      # ~1.27 ratio
		ACCEPTABLE_TARGET=53 # ~1.55 ratio
		;;
	13)
		MAX_TARGET=39       # +5
		GOOD_TARGET=50      # ~1.27 ratio
		ACCEPTABLE_TARGET=61 # ~1.55 ratio
		;;
	14)
		MAX_TARGET=44       # +5
		GOOD_TARGET=56      # ~1.27 ratio
		ACCEPTABLE_TARGET=68 # ~1.55 ratio
		;;
	15)
		MAX_TARGET=50       # +6
		GOOD_TARGET=64      # ~1.27 ratio
		ACCEPTABLE_TARGET=78 # ~1.55 ratio
		;;
	16)
		MAX_TARGET=56       # +6
		GOOD_TARGET=71      # ~1.27 ratio
		ACCEPTABLE_TARGET=87 # ~1.55 ratio
		;;
	17)
		MAX_TARGET=63       # +7
		GOOD_TARGET=80      # ~1.27 ratio
		ACCEPTABLE_TARGET=98 # ~1.55 ratio
		;;
	18)
		MAX_TARGET=70       # +7
		GOOD_TARGET=89      # ~1.27 ratio
		ACCEPTABLE_TARGET=109 # ~1.55 ratio
		;;
	19)
		MAX_TARGET=77       # +7
		GOOD_TARGET=98      # ~1.27 ratio
		ACCEPTABLE_TARGET=119 # ~1.55 ratio
		;;
esac

# Create output directory structure
mkdir -p test_sort/small

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
		if [ -f "test_sort/small/test${i}_output.txt" ]; then
			OPERATION_COUNT=$(grep -v "==" "test_sort/small/test${i}_output.txt" | wc -l)
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