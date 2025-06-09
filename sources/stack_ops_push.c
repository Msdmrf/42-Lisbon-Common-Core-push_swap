/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_push.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:08:19 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:06:06 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	push_to(t_stack *dst, t_stack *src, char *op, int silent)
{
	t_node	*temp;

	if (!src || !src->top)
		return ;
	temp = src->top;
	src->top = src->top->next;
	temp->next = dst->top;
	dst->top = temp;
	dst->size++;
	src->size--;
	if (op && !silent)
		write(1, op, 3);
}

void	pa(t_stack *a, t_stack *b, int silent)
{
	push_to(a, b, "pa\n", silent);
}

void	pb(t_stack *a, t_stack *b, int silent)
{
	push_to(b, a, "pb\n", silent);
}
