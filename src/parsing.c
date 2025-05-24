/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:08:37 by migusant          #+#    #+#             */
/*   Updated: 2025/05/23 13:06:55 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

t_stack	*parse_arguments(int argc, char **argv)
{
	t_stack	*stack;
	int		number;
	int		i;

	stack = create_stack('a');
	if (!stack)
		error_exit();
	i = argc - 1;
	while (i > 0)
	{
		if (!is_valid_number(argv[i]) || !ft_atoi_safe(argv[i], &number))
		{
			free_stack(stack);
			error_exit();
		}
		push(stack, number);
		i--;
	}
	return (stack);
}
