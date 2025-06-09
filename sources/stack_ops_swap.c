/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_ops_swap.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:56:04 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:06:13 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static void	swap(t_stack *stack, char *op, int silent)
{
	int	temp;

	if (!stack || !stack->top || !stack->top->next)
		return ;
	temp = stack->top->value;
	stack->top->value = stack->top->next->value;
	stack->top->next->value = temp;
	if (op && !silent)
		write(1, op, 3);
}

void	sa(t_stack *a, int silent)
{
	swap(a, "sa\n", silent);
}

void	sb(t_stack *b, int silent)
{
	swap(b, "sb\n", silent);
}

void	ss(t_stack *a, t_stack *b, int silent)
{
	swap(a, NULL, 1);
	swap(b, NULL, 1);
	if (!silent)
		write(1, "ss\n", 3);
}
