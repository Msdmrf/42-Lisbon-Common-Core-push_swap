/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sort_big.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/22 12:38:24 by migusant          #+#    #+#             */
/*   Updated: 2025/06/03 19:23:34 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* Change to an implementation that does this

For bit 0 in stack A:
Push numbers from stack A to stack B if bit 0 is 1
Keep numbers in stack A if bit 0 is 0

For bit 1 in stack B:
Push numbers from stack B to stack A if bit 1 is 0
Keep numbers in stack B if bit 1 is 1

For bit 1 in stack A:
Push numbers from stack A to stack B if bit 1 is 1
Keep numbers in stack A if bit 1 is 0

For bit 2 in stack B:
Push numbers from stack B to stack A if bit 2 is 0
Keep numbers in stack B if bit 2 is 1

For bit 2 in stack A:
Push numbers from stack A to stack B if bit 2 is 1
Keep numbers in stack A if bit 2 is 0

And so on! */

#include "../includes/push_swap.h"

static void	index_stack(t_stack *a)
{
	t_node	*current;
	t_node	*compare;
	int		index;

	current = a->top;
	while (current)
	{
		index = 0;
		compare = a->top;
		while (compare)
		{
			if (current->value > compare->value)
				index++;
			compare = compare->next;
		}
		current->index = index;
		current = current->next;
	}
}

static void	sort_by_bit(t_stack *a, t_stack *b, int bit_pos)
{
	int	size;
	int	i;
	int	moves;

	size = a->size;
	i = 0;
	moves = 0;
	while (i < size)
	{
		if (((a->top->index >> bit_pos) & 1) == 0)
		{
			pb(a, b);
			moves++;
		}
		else
			ra(a);
		i++;
		if (moves > 0 && is_sorted(a))
			break ;
	}
	while (b->size > 0)
		pa(a, b);
}

void	sort_radix(t_stack *a, t_stack *b)
{
	int	max_bits;
	int	size;
	int	i;

	if (a->size < 2 || is_sorted(a))
		return ;
	size = a->size;
	index_stack(a);
	max_bits = 0;
	while ((size - 1) >> max_bits)
		max_bits++;
	i = 0;
	while (i < max_bits)
	{
		sort_by_bit(a, b, i);
		i++;
	}
}

void	sort_dispatch(t_stack *a, t_stack *b)
{
	if (a->size < 2 || is_sorted(a))
		return ;
	else if (a->size <= 12)
		sort_n(a, b, a->size);
	else
		sort_radix(a, b);
}
