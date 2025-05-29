/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:08:37 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:12:26 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

t_stack	*parse_arguments(int argc, char **argv)
{
	t_stack	*stack;
	int		i;

	if (argc < 2 || !has_content(argv[1]))
		error_exit();
	stack = create_stack('a');
	if (!stack)
		error_exit();
	i = argc - 1;
	while (i > 0)
	{
		if (!process_numbers(stack, argv[i]))
		{
			free_stack(stack);
			error_exit();
		}
		i--;
	}
	return (stack);
}
