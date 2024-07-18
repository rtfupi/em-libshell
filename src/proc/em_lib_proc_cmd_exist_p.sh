#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_proc_cmd_exist_p.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-11-08 13:16
##!
##! \brief  Predicate of the existence of the command (script).
##|
##'###########################################################################'


em_source "../syslog/em_lib_syslog_logger.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_proc_cmd_exist_p.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief Predicate of the existence of the command (script).
##!
##! \param $1      - programm name;
##! \param $2...$N - опции, как у ф-ии em_lib_syslog_logger.
##!
##! \return  - return code:
##!                  1 : command not found.
##|
##'================================================================'
em_lib_proc_cmd_exist_p () {

    local sn=

    if ! type "${1}" > /dev/null 2>&1;then
        shift
        em_lib_syslog_logger "Erorr: object '${1}' not found." "${@}"
        return 1
    fi
    return 0
}
#export -f em_lib_proc_cmd_exist_p



# :END:
