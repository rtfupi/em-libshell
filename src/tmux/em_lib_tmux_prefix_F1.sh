#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_prefix_F1.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-04 18:23
##!
##! \brief  Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix F1'.
##!         Пример использования. Переопределить рекцию на нажетие
##!         клавиши 'prefix F1', а именно, при нажатииe выполнить
##!         вызов меню Help.
##!
##!         em_source "...../tmux/em_lib_tmux_menu.sh"
##!         em_source "...../tmux/em_lib_tmux_prefix_F1.sh"
##!         ...
##!         ...
##!         em_tmux_menu_main () {
##!             em_lib_tmux_menu "${EM_MENU_MAIN}"
##!         }
##!
##!         em_lib_tmux_prefix_F1 () {
##!             em_tmux_menu_main
##!         }
##!
##!         EM_SESS_PREFIX_F1=$(\
##!                              declare -f em_tmux_menu_main; \
##!                              echo "export -f em_tmux_menu_main"; \
##!                              declare -f em_lib_tmux_prefix_F1; \
##!                              echo "export -f em_lib_tmux_prefix_F1"; \
##!                           )
##!         ...
##!         ...
##!
##!         tmux new-session -d -s ${EM_SNAME} \
##!              -E \
##!              ... \
##!              -e EM_SESS_PREFIX_F1="${EM_SESS_PREFIX_F1}" \
##!              ...
##!              ...
##!
##!         ...
##!         ...
##!         tmux  bind-key "F1" if -F \
##!                "#{EM_SESS_PREFIX_F1}" \
##!                "run-shell '${EM_SESS_PREFIX_F1_EXP}'" \
##!                "send F1"
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_prefix_F1.sh
##|
##'***************************************************************************'

EM_SESS_PREFIX_F1= #$(/)

EM_SESS_PREFIX_F1_EXP='. /dev/stdin <<< "${EM_SESS_PREFIX_F1}";'`
                         `' em_lib_tmux_prefix_F1'


# :END:
##.================================================================.
##! \brief Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix F1'. Переопределяется в программе.
##!
##!
##! \param $1... - может использоваться.
##!
##|
##'================================================================'
em_lib_tmux_prefix_F1 () {
    :
}
