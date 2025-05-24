/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sort_small.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 15:56:44 by migusant          #+#    #+#             */
/*   Updated: 2025/05/23 22:04:52 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

void	sort_two(t_stack *a)
{
	if (a->top->value > a->top->next->value)
		sa(a);
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
		sa(a);
		ra(a);
	}
	else if (first > second && second < third && first < third)
		sa(a);
	else if (first < second && second > third && first > third)
		rra(a);
	else if (first > second && second < third && first > third)
		ra(a);
	else if (first > second && second > third)
	{
		ra(a);
		sa(a);
	}
}

void	sort_four(t_stack *a, t_stack *b)
{
	int	min;
	int	pos;

	min = find_min(a);
	pos = find_position(a, min);
	while (a->top->value != min)
	{
		if (pos <= a->size / 2)
			ra(a);
		else
			rra(a);
	}
	pb(a, b);
	sort_three(a);
	pa(a, b);
}

void	sort_five(t_stack *a, t_stack *b)
{
	int	min;
	int	max;
	int	to_push;

	min = find_min(a);
	max = find_max(a);
	to_push = 0;
	while (a->size > 3)
	{
		if (a->top->value == min || a->top->value == max)
		{
			pb(a, b);
			to_push++;
		}
		else
			ra(a);
	}
	sort_three(a);
	if (b->top && b->top->next && b->top->value < b->top->next->value)
		sb(b);
	pa(a, b);
	ra(a);
	pa(a, b);
}
