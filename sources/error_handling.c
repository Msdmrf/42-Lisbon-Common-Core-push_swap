/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   error_handling.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:52:03 by migusant          #+#    #+#             */
/*   Updated: 2025/10/15 22:13:30 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	error_exit(void)
{
	ft_putstr_fd("Error\n", 2);
	exit(1);
}

void	cleanup_and_exit(t_stack *a, t_stack *b, int exit_code)
{
	if (a)
		free_stack(a);
	if (b)
		free_stack(b);
	exit(exit_code);
}
