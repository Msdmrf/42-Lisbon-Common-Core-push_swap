/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_utils.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:58:41 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:13:30 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

int	find_min(t_stack *stack)
{
	t_node	*current;
	int		min;

	if (!stack || !stack->top)
		return (0);
	current = stack->top;
	min = current->value;
	while (current)
	{
		if (current->value < min)
			min = current->value;
		current = current->next;
	}
	return (min);
}

int	find_max(t_stack *stack)
{
	t_node	*current;
	int		max;

	if (!stack || !stack->top)
		return (0);
	current = stack->top;
	max = current->value;
	while (current)
	{
		if (current->value > max)
			max = current->value;
		current = current->next;
	}
	return (max);
}

int	find_position(t_stack *stack, int value)
{
	t_node	*current;
	int		pos;

	current = stack->top;
	pos = 0;
	while (current && current->value != value)
	{
		pos++;
		current = current->next;
	}
	return (pos);
}

int	is_sorted(t_stack *stack)
{
	t_node	*cur;

	if (!stack || !stack->top)
		return (1);
	cur = stack->top;
	while (cur->next)
	{
		if (cur->value > cur->next->value)
			return (0);
		cur = cur->next;
	}
	return (1);
}
