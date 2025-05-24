/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_rotate.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:37:56 by migusant          #+#    #+#             */
/*   Updated: 2025/05/22 20:11:59 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	ra(t_stack *a)
{
	t_node	*first;
	t_node	*last;

	if (!a || !a->top || !a->top->next)
		return ;
	first = a->top;
	a->top = a->top->next;
	last = a->top;
	while (last->next)
		last = last->next;
	last->next = first;
	first->next = NULL;
	write(1, "ra\n", 3);
}

void	rb(t_stack *b)
{
	t_node	*first;
	t_node	*last;

	if (!b || !b->top || !b->top->next)
		return ;
	first = b->top;
	b->top = b->top->next;
	last = b->top;
	while (last->next)
		last = last->next;
	last->next = first;
	first->next = NULL;
	write(1, "rb\n", 3);
}

void	rr(t_stack *a, t_stack *b)
{
	ra(a);
	rb(b);
}
