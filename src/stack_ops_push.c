/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_push.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:08:19 by migusant          #+#    #+#             */
/*   Updated: 2025/05/22 20:10:41 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	pa(t_stack *a, t_stack *b)
{
	t_node	*temp;

	if (!b || !b->top)
		return ;
	temp = b->top;
	b->top = b->top->next;
	temp->next = a->top;
	a->top = temp;
	a->size++;
	b->size--;
	write(1, "pa\n", 3);
}

void	pb(t_stack *a, t_stack *b)
{
	t_node	*temp;

	if (!a || !a->top)
		return ;
	temp = a->top;
	a->top = a->top->next;
	temp->next = b->top;
	b->top = temp;
	b->size++;
	a->size--;
	write(1, "pb\n", 3);
}
