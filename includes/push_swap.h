/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:54:37 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:08:40 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include "../libft/includes/libft.h"

// Stack Structures
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

// Error Handling
void		error_exit(void);
void		cleanup_and_exit(t_stack *a, t_stack *b, int exit_code);

// Parsing
t_stack		*parse_arguments(int argc, char **argv);
int			has_content(const char *str);
void		free_split(char **split);
int			is_valid_number(char *str);
int			ft_atoi_safe(const char *str, int *number);
int			process_numbers(t_stack *stack, char *str);

// Stack Initialization
t_stack		*init_stack_a(int argc, char **argv);
t_stack		*init_stack_b(t_stack *a);

// Stack Management
t_stack		*create_stack(char id);
void		push(t_stack *stack, int value);
int			pop(t_stack *stack);
void		free_stack(t_stack *stack);

// Stack Operations
void		sa(t_stack *a);
void		sb(t_stack *b);
void		ss(t_stack *a, t_stack *b);
void		pa(t_stack *a, t_stack *b);
void		pb(t_stack *a, t_stack *b);
void		ra(t_stack *a);
void		rb(t_stack *b);
void		rr(t_stack *a, t_stack *b);
void		rra(t_stack *a);
void		rrb(t_stack *b);
void		rrr(t_stack *a, t_stack *b);

// Stack Utilities
int			find_min(t_stack *stack);
int			find_max(t_stack *stack);
int			find_position(t_stack *stack, int value);
int			is_sorted(t_stack *stack);

// Sorting Algorithms
void		sort_two(t_stack *a);
void		sort_three(t_stack *a);
void		sort_four(t_stack *a, t_stack *b);
void		sort_five(t_stack *a, t_stack *b);
void		sort_large(t_stack *a, t_stack *b);
void		sort_dispatch(t_stack *a, t_stack *b);

#endif