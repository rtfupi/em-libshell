#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_tmux_send_cmd.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-03 01:50
##!
##! \brief  Tmux. Запустить команду, используя 'send-key'.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: tmux/em_lib_tmux_send_cmd.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} tmux xargs"

##.================================================================.
##! \brief Запустить команду, используя 'send-key'.
##!
##! \param $1   - delay in seconds ( '-' - no delay);
##! \param $2   - command (пример: ssh -p2222 nostnsme);
##! \param $n   - delay in seconds.
##! \param $n+1 - command;
##|
##'================================================================'
em_lib_tmux_send_cmd () {
    while [ -n "${1}" ];do
        [ "${1}" != "-" ] && sleep "${1}"
        shift
        [ -n "${1}" ] && tmux send-keys "${1}" || break
        shift
    done
}
#export -f em_lib_tmux_send_cmd


##.================================================================.
##! \brief Запустить команду, используя 'send-key' в окне ${1}.
##!        Если окно ${1} существует, то только выбрать это окно.
##!
##! \param $1   - имя окна (если имя - пустая строка, то всегда новое);
##! \param $2   - prompt;
##! \param $3   - delay in second;
##! \param $4   - команда через send-key (пример: ssh -p2222 nostnsme);
##! \param $n   - delay in second;
##! \param $n+1 - команда через send-key. 
##|
##'================================================================'
em_lib_tmux_send_open_cmd () {
    local name="${1}"

    if [ -n "${2}" ] && [ -n "${1}" ]; then
        name="$(tmux command-prompt -I "${1}" -p "${2}" -T window-target`
                                  ` "display-message -p '%1'")"
    fi

    if [ -n "${name}" ];then
        if [ -n "$(tmux list-windows -F '#W'|sed -n "s/^${name}\$/\0/gp")" ]
        then
            # открыть уже созданное окно, не запуская команды
            tmux neww -S -n "${name}" > /dev/null 2>&1 || return 1
            return 0
        else
            # открыть новое окно с именем ${name}
            tmux neww -n "${name}"
        fi
    else
        # открыть новое окно
        tmux neww
    fi
    shift;shift
    em_lib_tmux_send_cmd "${@}"
}
#export -f em_lib_tmux_send_open_cmd



##.================================================================.
##! \brief Запустить команду в shell, если команда вернула 0,
##!        то запустить следующие команды , используя 'send-key' в
##!         окне ${1}.
##!
##! \param $1   - имя окна (пример: 'NAME');
##! \param $2   - команда для shell(пример: true);
##! \param $3   - сообщение для неудачного завершения команды;
##! \param $4   - время отображения сообщения в миллисекундах;
##! \param $5   - prompt;
##! \param $6   - delay in second;
##! \param $7   - команда через send-key, если команда $2 вернула 0;
##! \param $n   - delay in second;
##! \param $n+1 - команда через send-key, если команда $2 вернула 0.
##|
##'================================================================'
em_lib_tmux_send_if_cmd () {
    # local r
    local name="${1}"
    local delay
    local msg_false

    [ -n "${4}" ] && delay="-d ${4}"
    [ -n "${3}" ] && msg_false="display-message ${delay} '${3}'"

    # r=$(tmux if-shell "${2}" "display-message -p TRUE" "${msg_false}")
    # [ "${r}" != TRUE ] && return 0

    sh -c "${2}"
    if [ "${?}" != 0 ];then
        echo "${msg_false}" | xargs tmux
        return 0
    fi

    if [ -n "${5}" ] && [ -n "${1}" ]; then
        name="$(tmux command-prompt -I "${1}" -p "${5}" -T window-target`
                                  ` "display-message -p '%1'")"
    fi

    if [ -n "${name}" ];then
        if [ -n "$(tmux list-windows -F '#W'|sed -n "s/^${name}\$/\0/gp")" ]
        then
            # открыть уже созданное окно, не запуская команды
            tmux neww -S -n "${name}" > /dev/null 2>&1 || return 1
            return 0
        else
            # открыть новое окно с именем ${name}
            tmux neww -n "${name}"
        fi
    else
        # открыть новое окно
        tmux neww
    fi    

    shift;shift;shift;shift;shift
    em_lib_tmux_send_cmd "${@}"
}
#export -f em_lib_tmux_send_cmd



# :END:
