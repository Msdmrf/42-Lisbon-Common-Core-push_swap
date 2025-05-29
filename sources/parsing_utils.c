/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing_utils.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 16:08:52 by migusant          #+#    #+#             */
/*   Updated: 2025/05/29 12:16:05 by migusant         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/push_swap.h"

int	has_content(const char *str)
{
	if (!str || !*str)
		return (0);
	while (*str)
	{
		if (!(*str == ' ' || *str == '\t' || *str == '\n'
				|| *str == '\v' || *str == '\f' || *str == '\r'))
			return (1);
		str++;
	}
	return (0);
}

int	is_valid_number(char *str)
{
	int	i;

	i = 0;
	if (str[0] == '-' || str[0] == '+')
		i++;
	if (!str[i])
		return (0);
	while (str[i])
	{
		if (str[i] < '0' || str[i] > '9')
			return (0);
		i++;
	}
	return (1);
}

int	ft_atoi_safe(const char *str, int *number)
{
	long	result;
	int		sign;

	result = 0;
	sign = 1;
	if (*str == '-')
	{
		sign = -1;
		str++;
	}
	else if (*str == '+')
		str++;
	if (!*str)
		return (0);
	while (*str)
	{
		if (*str < '0' || *str > '9')
			return (0);
		result = result * 10 + (*str - '0');
		if ((sign == 1 && result > INT_MAX)
			|| (sign == -1 && (-result) < INT_MIN))
			return (0);
		str++;
	}
	return (*number = sign * result, 1);
}

int	process_numbers(t_stack *stack, char *str)
{
	char	**numbers;
	int		number;
	int		i;

	if (!has_content(str))
		return (0);
	numbers = ft_split(str, ' ');
	if (!numbers)
		return (0);
	i = 0;
	while (numbers[i])
		i++;
	while (--i >= 0)
	{
		if (!is_valid_number(numbers[i]) || !ft_atoi_safe(numbers[i], &number))
		{
			free_split(numbers);
			return (0);
		}
		push(stack, number);
	}
	free_split(numbers);
	return (1);
}

void	free_split(char **split)
{
	int	i;

	i = 0;
	while (split[i])
	{
		free(split[i]);
		i++;
	}
	free(split);
}
