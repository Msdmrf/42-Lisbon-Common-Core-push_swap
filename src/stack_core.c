/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_core.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:13:03 by migusant          #+#    #+#             */
/*   Updated: 2025/05/22 20:09:57 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

t_stack	*create_stack(char id)
{
	t_stack	*stack;

	stack = malloc(sizeof(t_stack));
	if (!stack)
		return (NULL);
	stack->top = NULL;
	stack->size = 0;
	stack->id = id;
	return (stack);
}

void	push(t_stack *stack, int value)
{
	t_node	*new;

	new = malloc(sizeof(t_node));
	if (!new)
		error_exit();
	new->value = value;
	new->next = stack->top;
	stack->top = new;
	stack->size++;
}

int	pop(t_stack *stack)
{
	int		value;
	t_node	*tmp;

	if (!stack->top)
		error_exit();
	tmp = stack->top;
	value = tmp->value;
	stack->top = tmp->next;
	free(tmp);
	stack->size--;
	return (value);
}

void	free_stack(t_stack *stack)
{
	t_node	*cur;
	t_node	*tmp;

	cur = stack->top;
	while (cur)
	{
		tmp = cur->next;
		free(cur);
		cur = tmp;
	}
	free(stack);
}
