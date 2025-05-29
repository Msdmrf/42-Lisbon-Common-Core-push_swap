/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_reverse_rotate.c                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:42:36 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:14:20 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	reverse_rotate(t_stack *stack, char *op)
{
	t_node	*prev;
	t_node	*last;

	if (!stack || !stack->top || !stack->top->next)
		return ;
	prev = NULL;
	last = stack->top;
	while (last->next)
	{
		prev = last;
		last = last->next;
	}
	prev->next = NULL;
	last->next = stack->top;
	stack->top = last;
	if (op)
		write(1, op, 4);
}

void	rra(t_stack *a)
{
	reverse_rotate(a, "rra\n");
}

void	rrb(t_stack *b)
{
	reverse_rotate(b, "rrb\n");
}

void	rrr(t_stack *a, t_stack *b)
{
	reverse_rotate(a, NULL);
	reverse_rotate(b, NULL);
	write(1, "rrr\n", 4);
}
