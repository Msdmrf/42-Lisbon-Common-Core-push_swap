/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:55:21 by migusant          #+#    #+#             */
/*   Updated: 2025/05/30 12:39:40 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

int	main(int argc, char **argv)
{
	t_stack	*a;
	t_stack	*b;

	if (argc < 2 || argv[1][0] == '\0')
		return (0);
	a = init_stack_a(argc, argv);
	if (is_sorted(a))
		cleanup_and_exit(a, NULL, 0);
	b = init_stack_b(a);
	sort_dispatch(a, b);
	cleanup_and_exit(a, b, 0);
	return (0);
}
