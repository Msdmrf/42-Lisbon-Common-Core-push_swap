# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/21 15:52:35 by migusant          #+#    #+#              #
#    Updated: 2025/05/23 21:06:33 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = push_swap

CC = cc
CFLAGS = -Wall -Wextra -Werror
RM = rm -f

SRCS_DIR = src/
INCS_DIR = includes/
OBJS_DIR = objs/

SRCS = 	main.c \
				main_utils.c \
				parsing.c \
				parsing_utils.c \
				sort_small.c \
				sort_large.c \
				stack_core.c \
				stack_ops_push.c \
				stack_ops_reverse_rotate.c \
				stack_ops_rotate.c \
				stack_ops_swap.c \
				stack_utils.c

OBJS = $(addprefix $(OBJS_DIR), $(SRCS:.c=.o))

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)

$(OBJS_DIR)%.o: $(SRCS_DIR)%.c
	@mkdir -p $(OBJS_DIR)
	$(CC) $(CFLAGS) -I $(INCS_DIR) -c $< -o $@

clean:
	$(RM) -r $(OBJS_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re