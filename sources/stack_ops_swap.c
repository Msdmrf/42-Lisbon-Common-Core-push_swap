/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_swap.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:56:04 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:13:48 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	swap(t_stack *stack, char *op)
{
	int	temp;

	if (!stack || !stack->top || !stack->top->next)
		return ;
	temp = stack->top->value;
	stack->top->value = stack->top->next->value;
	stack->top->next->value = temp;
	if (op)
		write(1, op, 3);
}

void	sa(t_stack *a)
{
	swap(a, "sa\n");
}

void	sb(t_stack *b)
{
	swap(b, "sb\n");
}

void	ss(t_stack *a, t_stack *b)
{
	swap(a, NULL);
	swap(b, NULL);
	write(1, "ss\n", 3);
}
