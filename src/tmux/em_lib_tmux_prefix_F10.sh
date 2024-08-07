#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_prefix_F10.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-04 18:23
##!
##! \brief  Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix F10'.
##!         Пример использования. Переопределить рекцию на нажетие
##!         клавиши 'prefix F10'.
##!
##!         em_source "...../tmux/em_lib_tmux_prefix_F10.sh"
##!         ...
##!     +---define functions...
##!     |
##!     |   em_lib_tmux_prefix_F10 () {
##!     +-->   ...
##!     |   }
##!     |
##!     |   EM_SESS_PREFIX_F10=$(\
##!     +-------------------> ...
##!                           declare -f em_lib_tmux_prefix_F10; \
##!                           echo "export -f em_lib_tmux_prefix_F10"; \
##!                         )
##!         ...
##!         ...
##!
##!         tmux new-session -d -s ${EM_SNAME} \
##!              ... \
##!              ...
##!
##!         tmux set-environment EM_SESS_PREFIX_F10 "${EM_SESS_PREFIX_F10}"
##!         ...
##!         ...
##!         tmux  bind-key -T "F10" if -F \
##!                "#{EM_SESS_PREFIX_F10}" \
##!                "run-shell '${EM_SESS_PREFIX_F10_EXP}'" \
##!                "send F10"
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_prefix_F10.sh
##|
##'***************************************************************************'

EM_SESS_PREFIX_F10= #$(/)

EM_SESS_PREFIX_F10_EXP='. /dev/stdin <<< "${EM_SESS_PREFIX_F10}";'`
                                        `'em_lib_tmux_prefix_F10'


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
