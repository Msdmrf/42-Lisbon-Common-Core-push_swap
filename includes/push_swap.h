/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:54:37 by migusant          #+#    #+#             */
/*   Updated: 2025/10/15 22:13:22 by migusant         ###   ########.fr       */
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

// Stack Management (stack_management.c)
t_stack		*create_stack(char id);
void		push(t_stack *stack, int value);
void		free_stack(t_stack *stack);

// Stack Utilities (stack_utils.c)
int			find_min(t_stack *stack);
int			find_position(t_stack *stack, int value);
int			is_sorted(t_stack *stack);

// Parsing (parsing.c)
t_stack		*parse_arguments(int argc, char **argv);

// Parsing (parsing_utils.c)
int			process_numbers(t_stack *stack, char *str);

// Error Handling (error_handling.c)
void		error_exit(void);
void		cleanup_and_exit(t_stack *a, t_stack *b, int exit_code);

// Stack Initialization (stack_init.c)
t_stack		*init_stack_a(int argc, char **argv);
t_stack		*init_stack_b(t_stack *a);

// Stack Swap Operations (stack_ops_swap.c)
void		sa(t_stack *a, int silent);
void		sb(t_stack *b, int silent);
void		ss(t_stack *a, t_stack *b, int silent);

// Stack Push Operations (stack_ops_push.c)
void		pa(t_stack *a, t_stack *b, int silent);
void		pb(t_stack *a, t_stack *b, int silent);

// Stack Rotate Operations (stack_ops_rotate.c)
void		ra(t_stack *a, int silent);
void		rb(t_stack *b, int silent);
void		rr(t_stack *a, t_stack *b, int silent);

// Stack Reverse Rotate Operations (stack_ops_reverse_rotate.c)
void		rra(t_stack *a, int silent);
void		rrb(t_stack *b, int silent);
void		rrr(t_stack *a, t_stack *b, int silent);

// Small Stacks Algorithm (sort_small.c)
void		sort_dispatch(t_stack *a, t_stack *b);

// Large Stacks Algorithm (sort_big.c)
void		sort_radix(t_stack *a, t_stack *b);

#endif