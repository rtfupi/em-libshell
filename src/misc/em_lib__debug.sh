#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib__debug.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2024-01-09 17:22 UTC+00:00
##!
##! \brief  Функции для отладки скрипта.
##|
##'###########################################################################'



# :BEGIN:
# 8< DEBUG 8<
##.================================================================.
##! \brief Send debuging message to System log and to stderr.
##!
##! EM_DEBUG [-[0-9][0-9]] [-n SCRIPTNAME] [-x] [--] MSG1 [[MSG2] ...]
##!
##! -[0-9][0-9] - уровень логированияв виде двух разрядного числа,
##!               младший разряд отвечает за syslog, старший - за stderr.
##! -n SCRIPTNAME - название скрипта;
##! -x            - добавить второй строкой дополнительную отладочную
##!                 информацию;
##! --            - еnd the argument list, this allows the message to
##!                 start with a hyphen (-).
##! 
##| https://stackoverflow.com/questions/11090899/find-line-number-of-function-call-from-sourcing-file
##| https://stackoverflow.com/questions/10707173/bash-parameter-quotes-and-eval/10707498#10707498
##|
##'================================================================'
EM_DEBUG () {
    local level="${EM_LIB_SYSLOG_LEVEL}"
    local sn="${SN}"
    local l=00
    local pid="${$}"
    local ext msg 

    while [ -n "${1}" ];do
        case "${1}" in
            -[0-9][0-9])
                l=$(echo "${1}"|cut -c2-);;
            -n)
                shift;sn="${1}";;
            -x)
                ext=y;;
            --) shift
                while [ -n "${1}" ];do
                    msg="${msg}${1}"
                    shift
                done
                ;;
            *)
                msg="${msg}${1}";;
        esac
        shift
    done

    if [ -z "${EM_LIB_SYSLOG_STDERR}" ];then
        if expr ${level} / 10 ">=" ${l} / 10 > /dev/null 2>&1; then
            echo -e "${msg}" >&2
            if [ y${ext} == yy ];then
                echo " --> S: [${BASH_SOURCE[*]}] , L: [${BASH_LINENO[*]}] , F: [${FUNCNAME[*]}]" >&2
            fi
        fi
    fi

    # опция --id команды logger работает только по root
    if [ -z "${EM_LIB_SYSLOG_SYSLOG}" ];then
        if expr ${level} % 10 ">=" ${l} % 10 > /dev/null 2>&1; then
            # printf для поддержки escape последовательностей
            printf "$msg"|logger -p local2.info -t "${sn}[${pid}]"
            if [ y${ext} == yy ];then
                logger -p local2.info -t "${sn}[${pid}]" "--" \
                       " --> S:{${BASH_SOURCE[*]}} L:{${BASH_LINENO[*]}}, F:{${FUNCNAME[*]}}"
            fi
        fi
    fi

}
#export -f EM_DEBUG
# >8 DEBUG >8
# :END:
