/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sort_big.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/22 12:38:24 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:05:45 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* RADIX SORT ALGORITHM - Bit Processing Order
 
 I alternate between stacks, processing one bit at a time:
 
 PATTERN:
 - When processing stack A: move elements with bit=0 to stack B (keep bit=1 in A)
 - When processing stack B: move elements with bit=1 to stack A (keep bit=0 in B)
 
 EXAMPLE SEQUENCE FOR 5-BIT NUMBERS (2^5 = 32 elements):
 
 1.  Bit 0 on Stack A → Move 0s to B, keep 1s in A
 2.  Bit 1 on Stack B → Move 1s to A, keep 0s in B
 3.  Bit 1 on Stack A → Move 0s to B, keep 1s in A
 4.  Bit 2 on Stack B → Move 1s to A, keep 0s in B
 5.  Bit 2 on Stack A → Move 0s to B, keep 1s in A
 6.  Bit 3 on Stack B → Move 1s to A, keep 0s in B
 7.  Bit 3 on Stack A → Move 0s to B, keep 1s in A
 8.  Bit 4 on Stack B → Move 1s to A, keep 0s in B
 9.  Bit 4 on Stack A → Move 0s to B, keep 1s in A
 10. Final cleanup → Move all remaining elements from B to A */

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

static int	sort_bit_a_to_b(t_stack *a, t_stack *b, int bit_pos, int bit_value)
{
	int	size;
	int	i;
	int	total_size;
	int	max_bits;

	size = a->size;
	total_size = a->size + b->size;
	max_bits = 0;
	while ((total_size - 1) >> max_bits)
		max_bits++;
	i = 0;
	while (i < size)
	{
		if (((a->top->index >> bit_pos) & 1) == bit_value)
			pb(a, b, 0);
		else
		{
			ra(a, 0);
			if (bit_pos == max_bits - 1 && is_sorted(a))
				return (0);
		}
		i++;
	}
	return (0);
}

static int	sort_bit_b_to_a(t_stack *a, t_stack *b, int bit_pos, int bit_value)
{
	int	size;
	int	i;

	size = b->size;
	i = 0;
	while (i < size)
	{
		if (((b->top->index >> bit_pos) & 1) == bit_value)
			pa(a, b, 0);
		else
			rb(b, 0);
		i++;
	}
	return (0);
}

static void	remaining_bits(t_stack *a, t_stack *b, int bit, int max_bits)
{
	if (bit < max_bits)
	{
		sort_bit_a_to_b(a, b, bit, 0);
		bit++;
	}
	while (bit < max_bits)
	{
		if (b->size > 0)
			sort_bit_b_to_a(a, b, bit, 1);
		if (a->size > 0)
			sort_bit_a_to_b(a, b, bit, 0);
		bit++;
	}
	while (b->size > 0)
		pa(a, b, 0);
}

void	sort_radix(t_stack *a, t_stack *b)
{
	int	max_bits;
	int	size;
	int	bit;

	if (a->size < 2 || is_sorted(a))
		return ;
	size = a->size;
	index_stack(a);
	max_bits = 0;
	while ((size - 1) >> max_bits)
		max_bits++;
	bit = 0;
	remaining_bits(a, b, bit, max_bits);
}
