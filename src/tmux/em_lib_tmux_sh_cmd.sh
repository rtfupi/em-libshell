#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_sh_cmd.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-03 01:50
##!
##! \brief  Tmux. Запустить команду, используя 'new-window'.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_sh_cmd.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} tmux xargs"

##.================================================================.
##! \brief Запустить команду, используя 'new-window'.
##!        Если окно ${1} существует, то только выбрать это окно.
##!
##! \param $1 - имя окна (пример: 'NAME');
##! \param $2 - команда (пример: less help.txt);
##! \param $3 - prompt;
##! \param $4 - shell name (пример: bash).
##|
##'================================================================'
em_lib_tmux_sh_open_cmd () {
    local name="${1}"
    local cmd="${2}"
    [ -n "${4}" ] && cmd="$(echo -n "${4} -c '${2}'")"

    if [ -n "${3}" ] && [ -n "${1}" ]; then
        name="$(tmux command-prompt -I "${1}" -p "${3}" -T window-target`
                                  ` "display-message -p '%1'")"
    fi

    if [ -n "${name}" ];then
        tmux neww -S -n "${name}" "${cmd}"
    else
        tmux neww "${cmd}"
    fi
}
#export -f em_lib_tmux_sh_open_cmd


##.================================================================.
##! \brief Запустить команду в shell, без 'new-window'.
##!
##! \param $1 - команда для shell (пример: true);
##! \param $2 - сообщение для удачного завершения команды;
##! \param $3 - сообщение для неудачного завершения команды;
##! \param $4 - время отображения сообщения в миллисекундах;
##! \param $5 - shell name (пример: bash).
##|
##'================================================================'
em_lib_tmux_sh_if_cmd () {
    local cmd="${1}"
    local delay msg_true msg_false

    [ -n "${4}" ] && delay="-d ${4}"
    [ -n "${2}" ] && msg_true="display-message ${delay} '${2}'"
    [ -n "${3}" ] && msg_false="display-message ${delay} '${3}'"
    [ -n "${5}" ] && cmd="${5} -c '${1}'"

    # tmux if-shell "${cmd}" "${msg_true}" "${msg_false}"

    if ${cmd};then
        echo "${msg_true}" | xargs tmux
        return 0
    else
        echo "${msg_false}" | xargs tmux
        return 0
    fi
}
#export -f em_lib_tmux_sh_if_cmd



# :END:
