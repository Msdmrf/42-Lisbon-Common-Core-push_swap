/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_reverse_rotate.c                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:42:36 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:06:10 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	reverse_rotate(t_stack *stack, char *op, int silent)
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
	if (op && !silent)
		write(1, op, 4);
}

void	rra(t_stack *a, int silent)
{
	reverse_rotate(a, "rra\n", silent);
}

void	rrb(t_stack *b, int silent)
{
	reverse_rotate(b, "rrb\n", silent);
}

void	rrr(t_stack *a, t_stack *b, int silent)
{
	reverse_rotate(a, NULL, 1);
	reverse_rotate(b, NULL, 1);
	if (!silent)
		write(1, "rrr\n", 4);
}
