/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_utils.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:52:03 by migusant          #+#    #+#             */
/*   Updated: 2025/05/23 21:04:46 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	cleanup_and_exit(t_stack *a, t_stack *b, int exit_code)
{
	if (a)
		free_stack(a);
	if (b)
		free_stack(b);
	exit(exit_code);
}

t_stack	*init_stack_a(int argc, char **argv)
{
	t_stack	*a;
	int		*values;

	a = parse_arguments(argc, argv);
	if (!a)
		error_exit();
	values = stack_to_array(a, a->size);
	if (!values)
		cleanup_and_exit(a, NULL, 1);
	if (check_duplicates(values, a->size))
	{
		free(values);
		free_stack(a);
		error_exit();
	}
	free(values);
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

void	sort_dispatch(t_stack *a, t_stack *b)
{
	if (a->size < 2)
		return ;
	else if (a->size == 2)
		sort_two(a);
	else if (a->size == 3)
		sort_three(a);
	else if (a->size == 4)
		sort_four(a, b);
	else if (a->size == 5)
		sort_five(a, b);
	else
		sort_large(a, b);
}
