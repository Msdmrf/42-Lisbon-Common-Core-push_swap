/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sort_small.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:56:44 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:05:49 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	sort_two(t_stack *a)
{
	if (a->top->value > a->top->next->value)
		sa(a, 0);
}

void	sort_three(t_stack *a)
{
	int	first;
	int	second;
	int	third;

	first = a->top->value;
	second = a->top->next->value;
	third = a->top->next->next->value;
	if (first < second && second > third && first < third)
	{
		sa(a, 0);
		ra(a, 0);
	}
	else if (first > second && second < third && first < third)
		sa(a, 0);
	else if (first < second && second > third && first > third)
		rra(a, 0);
	else if (first > second && second < third && first > third)
		ra(a, 0);
	else if (first > second && second > third)
	{
		ra(a, 0);
		sa(a, 0);
	}
}

void	sort_n(t_stack *a, t_stack *b, int n)
{
	int	min;
	int	pos;

	if (n <= 1 || is_sorted(a))
		return ;
	if (n == 2)
		return (sort_two(a));
	if (n == 3)
		return (sort_three(a));
	min = find_min(a);
	pos = find_position(a, min);
	while (a->top->value != min)
	{
		if (pos <= n / 2)
			ra(a, 0);
		else
			rra(a, 0);
	}
	pb(a, b, 0);
	sort_n(a, b, n - 1);
	pa(a, b, 0);
}

void	sort_dispatch(t_stack *a, t_stack *b)
{
	if (a->size < 2 || is_sorted(a))
		return ;
	else if (a->size <= 19)
		sort_n(a, b, a->size);
	else
		sort_radix(a, b);
}
