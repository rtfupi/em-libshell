#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_prefix_C_d.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-04 18:23
##!
##! \brief  Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix C-d'.
##!         Пример использования. Переопределить рекцию на нажетие
##!         клавиши 'prefix C-d'.
##!
##!         em_source "...../tmux/em_lib_tmux_prefix_C_d.sh"
##!         ...
##!     +---define functions...
##!     |
##!     |   em_lib_tmux_prefix_C_d () {
##!     +-->   ...
##!     |   }
##!     |
##!     |   EM_SESS_PREFIX_C_d=$(\
##!     +-------------------> ...
##!                           declare -f em_lib_tmux_prefix_C_d; \
##!                           echo "export -f em_lib_tmux_prefix_C_d"; \
##!                         )
##!         ...
##!         ...
##!
##!         tmux new-session -d -s ${EM_SNAME} \
##!              ... \
##!              ...
##!
##!         tmux set-environment EM_SESS_PREFIX_C_d "${EM_SESS_PREFIX_C_d}"
##!         ...
##!         ...
##!         tmux  bind-key -T "C-d" if -F \
##!                "#{EM_SESS_PREFIX_C_d}" \
##!                "run-shell '${EM_SESS_PREFIX_C_d_EXP}'" \
##!                "send C-d"
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_prefix_C_d.sh
##|
##'***************************************************************************'

EM_SESS_PREFIX_C_d= #$(/)

EM_SESS_PREFIX_C_d_EXP='. /dev/stdin <<< "${EM_SESS_PREFIX_C_d}";'`
                                        `'em_lib_tmux_prefix_C_d'


# :END:
##.================================================================.
##! \brief Ф-ия-обертка для пользовтельских настроек для клавиши
##!         'prefix C-d'. Переопределяется в программе.
##!
##!
##! \param $1... - может использоваться.
##!
##|
##'================================================================'
em_lib_tmux_prefix_C_d () {
    :
}


# tmux bind "C-d" run-shell 'tmux setenv EM_DTACH_EV key \; detach'

# # Hooks для реализации режима kill-session при закрытии окна.
# tmux set-hook client-detached[10] "run-shell '${EM_SESS_FNS_LDR}; em_fn_tmux_destroy_CtrlD'"
# tmux set-hook client-attached[10] 'setenv EM_DTACH_EV attach'



# ##.===========================================================================.
# ##! \brief Kill current session через C-d.
# ##!
# ##! C-a C-d
# ##!   |
# ##!   v
# ##!   EM_DTACH_EV=key, detach
# ##!     |
# ##!     v
# ##!     hook client-detached
# ##!     > |
# ##!     > em_fn_tmux_destroy_CtrlD
# ##!       > |
# ##!       > EM_DTACH_EV==key
# ##!       > |
# ##!       > kill-session
# ##|
# ##'==========================================================================='
# em_fn_tmux_destroy_CtrlD () {
#     if [ ${EM_DTACH_EV} != key ];then tmux kill-session;fi
# }


# tmux set-hook client-detached[10] 'run-shell "if [ ${EM_DTACH_EV} != key ];then tmux kill-session;fi"'
