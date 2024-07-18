#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_menu.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-03 01:50
##!
##! \brief  Tmux. Сформировать пункты меню.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_menu.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} tmux"

##.================================================================.
##! \brief Сформировать пункты меню.
##!
##!        Пример меню:
##!
##!        Формирование меню 'F1 menu' 
##!        em_lib_tmux_menu EM_MENU_MAIN
##!
##!
##!        EM_MENU_MAIN="
##!        -T
##!        F1 menu
##!  
##!        # --- Меню справочных страниц. ------------
##!        Help menu
##!        h
##!        run-shell \"${EM_SFNS}; em_lib_tmux_menu EM_MENU_HELP\"
##!        
##!        #==========================================
##!        
##!        # --- Customize Hode --------------------------
##!        
##!        Customize mode -Z
##!        c
##!        run-shell`
##!        ` \"${EM_SFNS};`
##!        ` em_lib_tmux_tmux_cmd`
##!          ` \\\"CustomMode\\\"`
##!          ` \\\"customize-mode -Z\\\"`
##!          `\"
##!  
##!        #==========================================
##!  
##!        # --- Top command -----------------------------
##!        
##!        top
##!        t
##!        run-shell`
##!        ` \"${EM_SFNS};`
##!          ` em_lib_tmux_send_open_cmd`
##!          ` \\\"TOP\\\"`
##!          ` \\\"Window name:\\\"`
##!          ` 1.0 \\\"top\\\" - Enter`
##!          `\"
##!        "
##!
##!        Comments:
##!        #            - comments;
##!        #=======...= - разделитель в меню tmux;
##!
##!        EM_SESS_FNS  - переменная окружения сесси tmux, в
##!                       которой определены (записаны) ф-ии,
##!                       используемые для исполнения пунктов
##!                       меню.
##!
##! \param $1 - список пунктов меню.
##|
##'================================================================'
em_lib_tmux_menu () {
    local -n M="${1}"
    local m s

    [ -z "${M}" ] && return 0
    
    readarray -t m <<<"${M}"

    # declare -p m >> /tmp/em-tmux-choose-tree

    for e in "${m[@]}";do
        if [[ "${e}" =~ ^[[:blank:]]*#=+$ ]];then
            s="${s}'' "
            continue
        fi
        if [[ "${e}" =~ ^[[:blank:]]*# ]];then
            continue
        fi
        if [[ -z "${e}" ]];then
             continue
        fi
        s="${s}$(printf "'%s' " "${e}")"
    done

    echo "menu -x R -y S ${s}"|xargs tmux

    return 0
}
#export -f em_lib_tmux_menu



# :END:


# em_lib_tmux_menu () {
#     local m s

#     readarray -t m <<<"${1}"

#     for e in "${m[@]}";do
#         if [ -n "$(echo "${e}"|sed -n 's/^#=\+$/\0/gp')" ];then
#             s="${s}'' "
#             continue
#         fi
#         if [ -n "$(echo "${e}"|sed -n 's/^[ \t]*#.*$/\0/gp')" ];then
#             continue
#         fi
#         s="${s}$(printf "'%s' " "${e}")"
#     done

#     echo "menu -x R -y S ${s}"|xargs tmux
# }
#export -f em_lib_tmux_menu



