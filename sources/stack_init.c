/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   stack_init.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 17:13:03 by migusant          #+#    #+#             */
/*   Updated: 2025/10/15 22:13:49 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static int	has_duplicate(t_stack *stack)
{
	t_node	*current;
	t_node	*check;

	current = stack->top;
	while (current)
	{
		check = current->next;
		while (check)
		{
			if (current->value == check->value)
				return (1);
			check = check->next;
		}
		current = current->next;
	}
	return (0);
}

t_stack	*init_stack_a(int argc, char **argv)
{
	t_stack	*a;

	a = parse_arguments(argc, argv);
	if (has_duplicate(a))
	{
		free_stack(a);
		error_exit();
	}
	return (a);
}

t_stack	*init_stack_b(t_stack *a)
{
	t_stack	*b;

	b = create_stack('b');
	if (!b)
		cleanup_and_exit(a, NULL, 1);
	return (b);
}
