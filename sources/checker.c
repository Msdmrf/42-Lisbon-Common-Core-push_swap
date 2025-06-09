/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   checker.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/02 15:23:54 by migusant          #+#    #+#             */
/*   Updated: 2025/06/09 15:05:29 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

static int	is_valid_operation(char *line)
{
	if (!line)
		return (0);
	if (ft_strncmp(line, "sa\n", 3) == 0 || ft_strncmp(line, "sb\n", 3) == 0)
		return (1);
	if (ft_strncmp(line, "ss\n", 3) == 0)
		return (1);
	if (ft_strncmp(line, "pa\n", 3) == 0 || ft_strncmp(line, "pb\n", 3) == 0)
		return (1);
	if (ft_strncmp(line, "ra\n", 3) == 0 || ft_strncmp(line, "rb\n", 3) == 0)
		return (1);
	if (ft_strncmp(line, "rr\n", 3) == 0)
		return (1);
	if (ft_strncmp(line, "rra\n", 4) == 0 || ft_strncmp(line, "rrb\n", 4) == 0)
		return (1);
	if (ft_strncmp(line, "rrr\n", 4) == 0)
		return (1);
	return (0);
}

static void	execute_operation(t_stack *a, t_stack *b, char *line)
{
	if (ft_strncmp(line, "sa\n", 3) == 0)
		sa(a, 1);
	else if (ft_strncmp(line, "sb\n", 3) == 0)
		sb(b, 1);
	else if (ft_strncmp(line, "ss\n", 3) == 0)
		ss(a, b, 1);
	else if (ft_strncmp(line, "pa\n", 3) == 0)
		pa(a, b, 1);
	else if (ft_strncmp(line, "pb\n", 3) == 0)
		pb(a, b, 1);
	else if (ft_strncmp(line, "ra\n", 3) == 0)
		ra(a, 1);
	else if (ft_strncmp(line, "rb\n", 3) == 0)
		rb(b, 1);
	else if (ft_strncmp(line, "rr\n", 3) == 0)
		rr(a, b, 1);
	else if (ft_strncmp(line, "rra\n", 4) == 0)
		rra(a, 1);
	else if (ft_strncmp(line, "rrb\n", 4) == 0)
		rrb(b, 1);
	else if (ft_strncmp(line, "rrr\n", 4) == 0)
		rrr(a, b, 1);
}

static int	process_operations(t_stack *a, t_stack *b)
{
	char	*line;

	while (1)
	{
		line = get_next_line(0);
		if (!line)
			break ;
		if (!is_valid_operation(line))
		{
			free(line);
			return (0);
		}
		execute_operation(a, b, line);
		free(line);
	}
	return (1);
}

int	main(int argc, char **argv)
{
	t_stack	*a;
	t_stack	*b;

	if (argc < 2 || argv[1][0] == '\0')
		return (0);
	a = init_stack_a(argc, argv);
	b = init_stack_b(a);
	if (!process_operations(a, b))
	{
		write(2, "Error\n", 6);
		cleanup_and_exit(a, b, 1);
	}
	if (is_sorted(a) && b->size == 0)
		write(1, "OK\n", 3);
	else
		write(1, "KO\n", 3);
	cleanup_and_exit(a, b, 0);
	return (0);
}
