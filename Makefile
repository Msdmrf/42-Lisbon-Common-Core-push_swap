# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/21 15:52:35 by migusant          #+#    #+#              #
#    Updated: 2025/05/29 12:06:29 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                PROJECT SETTINGS                                #
# **************************************************************************** #

NAME = push_swap
LIBFT = libft/libft.a

# **************************************************************************** #
#                                COMPILER SETTINGS                               #
# **************************************************************************** #

CC = cc
CFLAGS = -Wall -Wextra -Werror
RM = rm -f

# **************************************************************************** #
#                               DIRECTORY STRUCTURE                              #
# **************************************************************************** #

SRC_DIR = sources/
OBJ_DIR = objects/
INC_DIR = includes/
LIBFT_DIR = libft/

# **************************************************************************** #
#                                    COLORS                                      #
# **************************************************************************** #

GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
BLUE = \033[0;34m
RESET = \033[0m

# **************************************************************************** #
#                                SOURCE FILES                                    #
# **************************************************************************** #

SRC_FILES = main.c \
				parsing.c \
				parsing_utils.c \
				sort_small.c \
				sort_large.c \
				stack_init.c \
				stack_management.c \
				stack_utils.c \
				stack_ops_push.c \
				stack_ops_reverse_rotate.c \
				stack_ops_rotate.c \
				stack_ops_swap.c \
				error_handling.c

SRC = $(addprefix $(SRC_DIR), $(SRC_FILES))
OBJ = $(addprefix $(OBJ_DIR), $(SRC_FILES:.c=.o))

# **************************************************************************** #
#                                   TARGETS                                      #
# **************************************************************************** #

all: $(LIBFT) $(NAME)

$(LIBFT):
	@echo "$(YELLOW)Building libft...$(RESET)"
	@make -C $(LIBFT_DIR)

$(NAME): $(OBJ)
	@echo "$(YELLOW)Building $(NAME)...$(RESET)"
	@$(CC) $(OBJ) -L$(LIBFT_DIR) -lft -o $(NAME)
	@echo "$(GREEN)$(NAME) successfully created!$(RESET)"

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	@echo "$(YELLOW)Compiling: $<$(RESET)"
	@$(CC) $(CFLAGS) -I$(INC_DIR) -I$(LIBFT_DIR)/includes -c $< -o $@

# **************************************************************************** #
#                                CLEANING RULES                                  #
# **************************************************************************** #

clean:
	@if [ -d "$(OBJ_DIR)" ]; then \
		$(RM) -r $(OBJ_DIR); \
		echo "$(RED)Object files have been cleaned!$(RESET)"; \
		echo "$(YELLOW)└── Removed directory: $(OBJ_DIR)$(RESET)"; \
	fi
	@make -C $(LIBFT_DIR) clean

fclean: clean
	@if [ -f "$(NAME)" ]; then \
		$(RM) $(NAME); \
		echo "$(RED)Everything has been cleaned!$(RESET)"; \
		echo "$(YELLOW)└── Removed executable: $(NAME)$(RESET)"; \
	fi
	@make -C $(LIBFT_DIR) fclean

re: fclean all

.PHONY: all clean fclean re