/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_swap.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:56:04 by migusant          #+#    #+#             */
/*   Updated: 2025/05/22 20:12:32 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	sa(t_stack *a)
{
	int	temp;

	if (!a || !a->top || !a->top->next)
		return ;
	temp = a->top->value;
	a->top->value = a->top->next->value;
	a->top->next->value = temp;
	write(1, "sa\n", 3);
}

void	sb(t_stack *b)
{
	int	temp;

	if (!b || !b->top || !b->top->next)
		return ;
	temp = b->top->value;
	b->top->value = b->top->next->value;
	b->top->next->value = temp;
	write(1, "sb\n", 3);
}

void	ss(t_stack *a, t_stack *b)
{
	int	temp;

	if (a && a->top && a->top->next)
	{
		temp = a->top->value;
		a->top->value = a->top->next->value;
		a->top->next->value = temp;
	}
	if (b && b->top && b->top->next)
	{
		temp = b->top->value;
		b->top->value = b->top->next->value;
		b->top->next->value = temp;
	}
	write(1, "ss\n", 3);
}
