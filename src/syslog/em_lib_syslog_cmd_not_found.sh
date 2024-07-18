#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_syslog_cmd_not_found.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-01-08 21:50
##!
##! \brief  Send a message to the Systems log about the absence of a command.
##|
##'###########################################################################'


em_source "../syslog/em_lib_syslog_logger.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: syslog/em_lib_syslog_cmd_not_found.sh
##|
##'***************************************************************************'


##.================================================================.
##! \brief Send a message to the Systems log about the absence of
##!        a command.
##!
##! \param $1 - program name;
##|
##'================================================================'
em_lib_syslog_cmd_not_found () {

    local r=0
    local cmds=$(echo "${1}" | xargs)

    [ -z "${cmds}" ] && return 0

    for cmd in $(echo "${cmds}"| tr " " "\n" | sort -u | tr "\n" " ");do
        if ! type ${cmd} > /dev/null 2>&1; then
            em_lib_syslog_logger "*** Error: ${cmd}: command not found."
            r=1
        fi
    done

    return $r
}



# :END:
