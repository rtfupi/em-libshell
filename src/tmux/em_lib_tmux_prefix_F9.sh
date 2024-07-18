#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_prefix_F9.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-04 18:23
##!
##! \brief  Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix F9'.
##!         Пример использования. Переопределить рекцию на нажетие
##!         клавиши 'prefix F9'.
##!
##!         em_source "...../tmux/em_lib_tmux_prefix_F9.sh"
##!         ...
##!     +---define functions...
##!     |
##!     |   em_lib_tmux_prefix_F9 () {
##!     +-->   ...
##!     |   }
##!     |
##!     |   EM_SESS_PREFIX_F9=$(\
##!     +-------------------> ...
##!                           declare -f em_lib_tmux_prefix_F9; \
##!                           echo "export -f em_lib_tmux_prefix_F9"; \
##!                         )
##!         ...
##!         ...
##!
##!         tmux new-session -d -s ${EM_SNAME} \
##!              ... \
##!              ...
##!
##!         tmux set-environment EM_SESS_PREFIX_F9 "${EM_SESS_PREFIX_F9}"
##!         ...
##!         ...
##!         tmux  bind-key -T "F10" if -F \
##!                "#{EM_SESS_PREFIX_F9}" \
##!                "run-shell '${EM_SESS_PREFIX_F9_EXP}'" \
##!                "send F9"
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_prefix_F9.sh
##|
##'***************************************************************************'

EM_SESS_PREFIX_F9= #$(/)

EM_SESS_PREFIX_F9_EXP='. /dev/stdin <<< "${EM_SESS_PREFIX_F9}";'`
                                        `'em_lib_tmux_prefix_F9'


# :END:
##.================================================================.
##! \brief Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix F10'. Переопределяется в программе.
##!
##!
##! \param $1... - может использоваться.
##!
##|
##'================================================================'
em_lib_tmux_prefix_F10 () {
    :
}