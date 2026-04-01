*This project has been created as part of the 42 curriculum by migusant.*

# Push_swap

An algorithmic sorting program that sorts a stack of integers using **two stacks and a limited set of operations**, aiming to achieve the lowest possible number of moves. This project demonstrates algorithm design, complexity optimization, and data structure manipulation in C.

## Description

The Push_swap project is a constrained sorting challenge: given a random set of integers on stack `a` and an empty stack `b`, the goal is to sort all numbers into ascending order on stack `a` using only specific push, swap, rotate, and reverse rotate operations. The difficulty lies not just in sorting, but in finding the most efficient sequence of operations possible. The project uses a **recursive selection sort** for small inputs and a **radix sort** (binary bit processing) for large inputs.

### Key Features

- **Dual sorting algorithms** with automatic dispatch based on input size (threshold: 19 elements)
- **Radix sort** using binary bit decomposition with alternating stack processing for large inputs
- **Recursive selection sort** for small stacks (2-19 elements) with optimized cases for 2 and 3 elements
- **Index normalization** mapping arbitrary integer values to sequential indices (0 to n-1) for bitwise radix processing
- **Flexible input parsing** supporting both individual arguments and quoted strings with multiple numbers
- **Robust validation** detecting duplicates, non-numeric input, integer overflow, and blank arguments
- **Checker program (bonus)** that reads operations from stdin and verifies if they correctly sort the stack
- **Silent mode** for operations allowing shared code between push_swap (prints operations) and checker (silent execution)
- **Uses libft** as the authorized utility library including get_next_line for the checker's stdin reading

### Project Structure

```
├── includes/
│   └── push_swap.h               # Header with stack structures, macros, and prototypes
├── sources/
│   ├── main.c                    # Entry point for push_swap program
│   ├── checker.c                 # Entry point for checker program (bonus)
│   ├── parsing.c                 # Argument parsing and stack creation
│   ├── parsing_utils.c           # Number validation, safe atoi, and split processing
│   ├── stack_init.c              # Stack initialization and duplicate detection
│   ├── stack_management.c        # Stack creation, push, and memory cleanup
│   ├── stack_utils.c             # Utility functions (find_min, find_position, is_sorted)
│   ├── stack_ops_swap.c          # sa, sb, ss operations
│   ├── stack_ops_push.c          # pa, pb operations
│   ├── stack_ops_rotate.c        # ra, rb, rr operations
│   ├── stack_ops_reverse_rotate.c # rra, rrb, rrr operations
│   ├── sort_small.c              # Recursive selection sort and dispatch logic
│   ├── sort_big.c                # Radix sort with index normalization
│   └── error_handling.c          # Error reporting and cleanup
├── libft/                        # Custom C utility library (libft, ft_printf, get_next_line)
├── test_sort_*.sh                # Shell scripts for testing various input sizes
├── leaks_to_valgrind.sh          # Valgrind memory leak testing script
├── testers.txt                   # Links to external testing tools and visualizer
├── Makefile
└── CMakeLists.txt
```

## Instructions

### Compilation

```bash
make        # Compile push_swap (builds libft first)
make bonus  # Compile checker program
make clean  # Remove object files
make fclean # Remove object files and executables
make re     # Recompile from scratch
```

This produces the `push_swap` executable (and `checker` with `make bonus`).

### Execution

#### push_swap

```bash
./push_swap <numbers>
```

The program outputs a list of operations (one per line) that sorts the given integers in ascending order on stack `a`.

**Arguments:**
- `numbers`: A list of unique integers, provided as individual arguments or as a quoted string

**Examples:**

```bash
# Sort 3 numbers
./push_swap 3 2 1
# Output: sa ra

# Sort 5 numbers
./push_swap 5 1 4 2 3

# Sort using a quoted string
./push_swap "3 2 1 5 4"

# Count the number of operations
./push_swap 3 2 1 | wc -l

# Sort 100 random numbers and count operations
ARG=$(shuf -i 1-1000 -n 100 | tr '\n' ' '); ./push_swap $ARG | wc -l

# Sort 500 random numbers and count operations
ARG=$(shuf -i 1-5000 -n 500 | tr '\n' ' '); ./push_swap $ARG | wc -l
```

#### checker (bonus)

```bash
./push_swap <numbers> | ./checker <numbers>
```

The checker reads operations from stdin and outputs `OK` if the stack is sorted after execution, or `KO` if it is not. It outputs `Error` on invalid operations.

**Examples:**

```bash
# Verify push_swap's output
./push_swap 3 2 1 | ./checker 3 2 1
# Output: OK

# Manually test operations
echo -e "sa\nra" | ./checker 3 2 1
# Output: OK

# Test with no operations on already sorted input
echo "" | ./checker 1 2 3
# Output: OK
```

### Available Operations

| Operation | Description |
|-----------|-------------|
| `sa` | Swap the first 2 elements at the top of stack `a` |
| `sb` | Swap the first 2 elements at the top of stack `b` |
| `ss` | `sa` and `sb` at the same time |
| `pa` | Push the top element of `b` onto `a` |
| `pb` | Push the top element of `a` onto `b` |
| `ra` | Rotate stack `a` up (first element becomes last) |
| `rb` | Rotate stack `b` up (first element becomes last) |
| `rr` | `ra` and `rb` at the same time |
| `rra` | Reverse rotate stack `a` (last element becomes first) |
| `rrb` | Reverse rotate stack `b` (last element becomes first) |
| `rrr` | `rra` and `rrb` at the same time |

## Technical Implementation

### Data Structures

**Stack:**
- Implemented as a **singly linked list** with a `t_stack` wrapper tracking `top` pointer, `size`, and stack `id` (`'a'` or `'b'`)
- Each `t_node` holds a `value` (original integer), an `index` (normalized position for radix sort), and a `next` pointer

### Small Stack Algorithm (2-19 elements)

**Strategy:** Recursive selection sort using `sort_n()`:

1. **Base cases:** Direct handling for 2 elements (`sa` if needed) and 3 elements (hardcoded optimal sequences covering all 6 permutations)
2. **Recursive case (4-19):** Find the minimum value, rotate it to the top (choosing `ra` or `rra` based on position), push it to `b`, recursively sort the remaining elements, then push all back to `a`
3. **Rotation optimization:** Uses `find_position()` to determine whether `ra` or `rra` requires fewer moves to bring the minimum to the top

### Large Stack Algorithm (20+ elements) - Radix Sort

**Strategy:** Binary radix sort processing one bit at a time with alternating stack directions:

1. **Index normalization:** `index_stack()` assigns each element an index (0 to n-1) based on its relative rank, enabling clean bitwise processing regardless of original values
2. **Bit processing pattern:**
   - Bit 0 on stack A: Move elements with bit=0 to B, keep bit=1 in A
   - Subsequent bits alternate: B-to-A (move bit=1), then A-to-B (move bit=0)
   - This alternation avoids moving all elements back after each bit pass
3. **Early termination:** Checks if stack A is already sorted during the last bit pass
4. **Final cleanup:** Moves all remaining elements from B back to A

**Complexity:** O(n * log(n)) operations where log(n) is the number of bits needed to represent n values

### Input Parsing

- Supports mixed input: `./push_swap 1 "2 3" 4` (individual args + quoted strings)
- Uses `ft_split()` to tokenize quoted strings by spaces
- `ft_atoi_safe()` uses `long` arithmetic to detect integer overflow before casting to `int`
- Processes arguments in reverse order to maintain correct stack ordering when pushing

### Checker Program (Bonus)

- Shares all stack infrastructure with push_swap via common source files
- Reads operations line by line from stdin using `get_next_line()`
- Validates each operation string before executing
- Operations run in **silent mode** (no output) using the `silent` parameter
- After all operations, checks if stack `a` is sorted and stack `b` is empty

## Resources

### Algorithm Theory

- [Wikipedia: Radix Sort](https://en.wikipedia.org/wiki/Radix_sort) - Binary radix sort algorithm
- [Wikipedia: Selection Sort](https://en.wikipedia.org/wiki/Selection_sort) - Selection sort algorithm
- [Sorting Algorithm Complexities](https://www.bigocheatsheet.com/) - Big-O complexity reference

### Data Structures

- [Wikipedia: Stack (abstract data type)](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) - Stack operations and implementation
- [Linked List Implementation in C](https://www.learn-c.org/en/Linked_lists) - Singly linked list basics

### System Calls & Functions

- `man malloc(3)` / `man free(3)` - Dynamic memory allocation
- `man write(2)` - Low-level output
- `man exit(3)` - Process termination

**Debugging Tools:**
- `man valgrind(1)` - Valgrind command-line options
- [Valgrind Manual](https://valgrind.org/docs/manual/manual.html) - Memory error detection

### AI Usage

AI tools (GitHub Copilot, ChatGPT) were used as a **thinking partner and debugging assistant** to discuss problems and approaches, but all final code, architecture decisions, and bug fixes were produced by the student after understanding the underlying concepts.

**Documentation & Understanding:**
- Discussing radix sort adaptations for stack-based operations and bitwise processing
- Explaining binary representation and bit manipulation for sorting
- Understanding trade-offs between different sorting approaches (radix vs. turk sort vs. cost-based algorithms)
- Refining and structuring README.md documentation to accurately represent technical implementations

**Code Review:**
- Reviewing index normalization correctness and edge cases
- Identifying potential memory leaks in parsing error paths
- Verifying the alternating stack direction optimization in radix sort

**Learning Resources:**
- Providing reference for algorithmic complexity analysis of different push_swap strategies
- Clarifying linked list stack implementation trade-offs vs. array-based stacks
- Explaining bitwise operations and their application to sorting

**Testing Assistance & Debugging:**
- Helping design test cases for edge scenarios (single element, already sorted, reverse sorted, INT_MIN/INT_MAX)
- Debugging recursive sort behavior for small stack sizes
- Analyzing operation counts to meet performance benchmarks

## License

This project is part of the 42 Common Core curriculum. See [LICENSE](LICENSE) for details.
