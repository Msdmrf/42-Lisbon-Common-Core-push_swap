# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    leaks_to_valgrind.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: migusant <migusant@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/21 22:21:06 by migusant          #+#    #+#              #
#    Updated: 2025/05/24 17:44:55 by migusant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# git clone https://github.com/LeoFu9487/push_swap_tester.git && cd push_swap_tester

sed -i.backup '
s/leaks -atExit -- \(.*\) 1>a 2>b/valgrind --leak-check=full --error-exitcode=1 --log-file=valgrind.log \1 >\/dev\/null 2>\&1/g
/grep ": 0 leaks for 0 total leaked bytes" a > x/d
/grep "not found" b > y/d
s/if \[\[ -s x \]\]/if [ -f valgrind.log ] \&\& grep -q "All heap blocks were freed -- no leaks are possible" valgrind.log/g
s/TEMPLEAK="leaks command not found"/TEMPLEAK="valgrind command not found"/g
s/LEAKFLAG="leaks command not found"/LEAKFLAG="valgrind command not found"/g
s/rm -rf a b x y/rm -rf a b x y valgrind.log/g' basic_test.sh

# bash basic_test.sh

# bash clean.sh