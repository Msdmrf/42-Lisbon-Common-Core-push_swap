/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_rotate.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:37:56 by migusant          #+#    #+#             */
/*   Updated: 2025/10/15 22:13:59 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	rotate(t_stack *stack, char *op, int silent)
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
	if (op && !silent)
		write(1, op, 3);
}

void	ra(t_stack *a, int silent)
{
	rotate(a, "ra\n", silent);
}

void	rb(t_stack *b, int silent)
{
	rotate(b, "rb\n", silent);
}

void	rr(t_stack *a, t_stack *b, int silent)
{
	rotate(a, NULL, 1);
	rotate(b, NULL, 1);
	if (!silent)
		write(1, "rr\n", 3);
}
