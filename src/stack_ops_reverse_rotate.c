/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_reverse_rotate.c                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:42:36 by migusant          #+#    #+#             */
/*   Updated: 2025/05/22 20:11:17 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	rra(t_stack *a)
{
	t_node	*prev;
	t_node	*last;

	if (!a || !a->top || !a->top->next)
		return ;
	prev = NULL;
	last = a->top;
	while (last->next)
	{
		prev = last;
		last = last->next;
	}
	prev->next = NULL;
	last->next = a->top;
	a->top = last;
	write(1, "rra\n", 4);
}

void	rrb(t_stack *b)
{
	t_node	*prev;
	t_node	*curr;

	if (!b || b->size < 2)
		return ;
	prev = NULL;
	curr = b->top;
	while (curr && curr->next)
	{
		prev = curr;
		curr = curr->next;
	}
	if (prev && curr)
	{
		prev->next = NULL;
		curr->next = b->top;
		b->top = curr;
	}
}

void	rrr(t_stack *a, t_stack *b)
{
	rra(a);
	rrb(b);
}
