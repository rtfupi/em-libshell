#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_root_q.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-04 18:23
##!
##! \brief  Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'q'.
##!         Пример использования. Переопределить рекцию на нажетие
##!         клавиши 'q', а именно, при нажатии  в окне chooe-tree
##!         выполнить закрытие сессии.
##!         Переменная '@em_choose_tree_select' нужна для того,
##!         чтобы такая реакция на клавишу 'q' бала только в окне,
##!         где была открыто пане choose-tree при старте сессии.
##!
##!
##!         em_source "...../tmux/em_lib_tmux_root_q.sh"
##!         ...
##!         ...
##!         em_tmux_choose_key_q () {
##!            if tmux  if -F \
##!               "#{&&:#{==:#{pane_mode},tree-mode},`
##!                    `#{==:#{@em_choose_tree_select},#S#I#D}}}" \
##!                        "kill-session" \
##!                        "send-key q"
##!         }
##!         
##!         em_lib_tmux_root_q () {
##!             em_tmux_choose_key_q 
##!         }
##!
##!         EM_SESS_ROOT_q=$(\
##!                           declare -f em_lib_tmux_root_q; \
##!                           echo "export -f em_lib_tmux_root_q"; \
##!                           declare -f em_tmux_choose_q; \
##!                           echo "export -f em_tmux_choose_q"; \
##!                         )
##!         ...
##!         ...
##!
##!         tmux new-session -d -s ${EM_SNAME} \
##!              -E \
##!              ... \
##!              -e EM_SESS_ROOT_q="${EM_SESS_ROOT_q}" \
##!              ...
##!              -n choose-tree \; \
##!              set-option -F @em_choose_tree_select "#S#I#D" \; \
##!              choose-tree -Zs \
##!              ...
##!
##!         ...
##!         ...
##!         tmux  bind-key -T root "q" if -F \
##!                "#{EM_SESS_ROOT_q}" \
##!                "run-shell '${EM_SESS_ROOT_q_EXP}'" \
##!                "send q"
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_root_q.sh
##|
##'***************************************************************************'

EM_SESS_ROOT_q= #$(/)

EM_SESS_ROOT_q_EXP='. /dev/stdin <<< "${EM_SESS_ROOT_q}"; em_lib_tmux_root_q'


# :END:
##.================================================================.
##! \brief Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'q'. Переопределяется в программе.
##!
##!
##! \param $1... - может использоваться.
##!
##|
##'================================================================'
em_lib_tmux_root_q () {
    :
}
