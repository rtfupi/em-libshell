#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_syslog_logger.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-04-24 15:33
##!
##! \brief  System log.
##|
##'###########################################################################'



# :BEGIN:
##.***************************************************************************.
##| Lib: syslog/em_lib_syslog_logger.sh
##|
##'***************************************************************************'

# Уровень логированияв виде двух разрядного числа. Младший разряд отвечает
# за syslog, старший - за stderr. 9 - выводить всегда.
export EM_LIB_SYSLOG_LEVEL
# Глобальные переменные для раздельной блокировки каналов логирования.
export EM_LIB_SYSLOG_SYSLOG
export EM_LIB_SYSLOG_STDERR

##.================================================================.
##! \brief Send message to System log and to stderr.
##!
##! EM_DEBUG [-[0-9][0-9]] [-n SCRIPTNAME] [-x] [--] MSG1 [[MSG2] ...]
##!
##! -[0-9][0-9]   - уровень логированияв виде двух разрядного числа,
##!                 младший разряд отвечает за syslog, старший - за stderr.
##!                 0 - выводить всегда. Порог сравнивается с числом из
##!                 EM_LIB_SYSLOG_LEVEL. Поразрядное cравнения числа из
##!                 EM_LIB_SYSLOG_LEVEL с порогом из $4 происходит по
##!                 условию 'EM_LIB_SYSLOG_LEVEL >= $4'. Если результат
##!                 сравнения - истина, то происходит ввывод сообшения;
##! -n SCRIPTNAME - название скрипта;
##! -p            - PID;
##! -w            - выводить строки без заголовка;
##! --            - еnd the argument list, this allows the message to
##!                 start with a hyphen (-).
##!
##!             Глобальные пременные:
##!               EM_LIB_SYSLOG_LEVEL  - уровень логирования;
##!               SN                   - имя скрипта.
##!               EM_LIB_SYSLOG_SYSLOG - пустая строка - разрешает syslog
##!               EM_LIB_SYSLOG_STDERR - пустая строка - разрешает stderr
##!
##!             Примеры:
##!
##!              EM_LIB_SYSLOG_LEVEL=(любое) =>    в syslog - да
##!              $3=00                             в stderr - да
##!
##!              EM_LIB_SYSLOG_LEVEL=54      =>    в syslog - нет
##!              $3=55                             в stderr - да
##!
##!              EM_LIB_SYSLOG_LEVEL=88      =>    в syslog - нет
##!              $3=99                             в stderr - нет
##! 
##| https://stackoverflow.com/questions/11090899/find-line-number-of-function-call-from-sourcing-file
##| https://stackoverflow.com/questions/10707173/bash-parameter-quotes-and-eval/10707498#10707498
##|
##'================================================================'
em_lib_syslog_logger () {

    local level="${EM_LIB_SYSLOG_LEVEL}"
    local sn="${SN}"
    local l=00
    local pid="${$}"
    local msg wh
   
    while [ -n "${1}" ];do
        case "${1}" in
            -[0-9][0-9]) l=$(echo "${1}"|cut -c2-);;
            -n) shift;sn="${1}";;
            -w) wh=y;;
            -p) shift;pid="${1}";;
            --) shift
                while [ -n "${1}" ];do
                    msg="${msg}${1}"
                    shift
                done
                ;;
            *) msg="${msg}${1}";;
        esac
        shift
    done

    if [ -z "${EM_LIB_SYSLOG_STDERR}" ];then
        if expr ${level} ">=" ${l} / 10 > /dev/null 2>&1; then
            [ -z "${wh}" ] && h="$(date "+%b %d %H:%M:%S") ${sn}[${pid}]: "
            while IFS= read -r line; do
                echo "${h}${line}" >&2
            done <<< $(printf "${msg}")
        fi
    fi

    # опция --id команды logger работает только по root
    if [ -z "${EM_LIB_SYSLOG_SYSLOG}" ];then
        if expr ${level} ">=" ${l} % 10 > /dev/null 2>&1; then
            printf "${msg}"|logger -p local2.info -t "${sn}[${pid}]"
        fi
    fi
}
#export -f em_lib_syslog_logger



# :END:
