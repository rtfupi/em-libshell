#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_switch_status.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-03 01:50
##!
##! \brief  Tmux. On/Off status line.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_switch_status.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} tmux"

##.================================================================.
##! \brief On/Off status line.
##|
##'================================================================'
em_lib_tmux_switch_status () {
    local v=$(tmux show-options -v status)
    if [ o${v} = oon ];then
        tmux set-option status off
    else
        tmux set-option status on
    fi
}
#export -f em_lib_tmux_switch_status



# :END:
