#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_tmux1.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-25 16:10
##!
##! \brief  Tmux. Запустить команду tmux, используя 'new-window' и
##!         "tmux ...".
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_tmux_cmd.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} tmux"

##.================================================================.
##! \brief Запустить команду меню, используя 'new-window'.
##!        Если окно ${1} существует, то только выбрать это окно.
##!
##! \param $1 - имя окна (пример: 'NAME');
##! \param $2 - tmux команда (пример: choose-client -Z).
##|
##'================================================================'
em_lib_tmux_tmux_cmd () {
    if [ -n "${1}" ];then
        tmux neww -S -n "${1}" "tmux ${2};read -n1 -p 'Press any key'"
    else
        tmux neww "tmux ${2};read -n1 -p 'Press any key'"
    fi
}
#export -f em_lib_tmux_tmux_cmd



# :END: