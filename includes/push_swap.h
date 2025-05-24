/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:54:37 by migusant          #+#    #+#             */
/*   Updated: 2025/05/24 19:35:44 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include <stdlib.h>
# include <unistd.h>
# include <limits.h>

// Stack structures
typedef struct s_node
{
	int				value;
	int				index;
	struct s_node	*next;
}	t_node;

typedef struct s_stack
{
	t_node	*top;
	int		size;
	char	id;
}	t_stack;

// Main helpers
t_stack	*init_stack_a(int argc, char **argv);
t_stack	*init_stack_b(t_stack *a);
void	cleanup_and_exit(t_stack *a, t_stack *b, int exit_code);
void	sort_dispatch(t_stack *a, t_stack *b);

// Parsing & error handling
t_stack	*parse_arguments(int argc, char **argv);
void	error_exit(void);
int		is_valid_number(char *str);
int		check_duplicates(int *array, int size);
int		ft_atoi_safe(const char *str, int *number);

// Stack management
t_stack	*create_stack(char id);
void	free_stack(t_stack *stack);
void	push(t_stack *stack, int value);
int		pop(t_stack *stack);

// Stack operations
void	sa(t_stack *a);
void	sb(t_stack *b);
void	ss(t_stack *a, t_stack *b);
void	pa(t_stack *a, t_stack *b);
void	pb(t_stack *a, t_stack *b);
void	ra(t_stack *a);
void	rb(t_stack *b);
void	rr(t_stack *a, t_stack *b);
void	rra(t_stack *a);
void	rrb(t_stack *b);
void	rrr(t_stack *a, t_stack *b);

// Stack utilities
int		find_min(t_stack *stack);
int		find_max(t_stack *stack);
int		find_position(t_stack *stack, int value);
int		is_sorted(t_stack *stack);
int		*stack_to_array(t_stack *stack, int size);

// Sorting algorithms
void	sort_two(t_stack *a);
void	sort_three(t_stack *a);
void	sort_four(t_stack *a, t_stack *b);
void	sort_five(t_stack *a, t_stack *b);
void	sort_large(t_stack *a, t_stack *b);

#endif