/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_rotate.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:37:56 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:14:06 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	rotate(t_stack *stack, char *op)
{
	t_node	*first;
	t_node	*last;

	if (!stack || !stack->top || !stack->top->next)
		return ;
	first = stack->top;
	stack->top = stack->top->next;
	last = stack->top;
	while (last->next)
		last = last->next;
	last->next = first;
	first->next = NULL;
	if (op)
		write(1, op, 3);
}

void	ra(t_stack *a)
{
	rotate(a, "ra\n");
}

void	rb(t_stack *b)
{
	rotate(b, "rb\n");
}

void	rr(t_stack *a, t_stack *b)
{
	rotate(a, NULL);
	rotate(b, NULL);
	write(1, "rr\n", 3);
}
