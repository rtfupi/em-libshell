#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib__startwin.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date  (em:timestamp-insert)
##!
##! \brief  Получить geometry окна через e[v]m-startwin.
##|
##'###########################################################################'


em_source "../syslog/em_lib_syslog_logger.sh"

# :BEGIN:
##.***************************************************************************.
##| Lib: misc/em_lib__startwin.sh
##|
##'***************************************************************************'

# анализ наличия 'evm-startwin' выполнять в коде .
# EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} evm-startwin"

##.================================================================.
##! \brief Получить geometry через e[v]m-startwin.
##!
##! \param $1     - geometry value;
##! \param $2..$n - list other arguments.
##!
##! \return  -  stdout :
##!                 geometry.
##!          - return code :
##!                 0 - значение geometry получено успешно;
##!                 1 - отказ;
##!                 2 - evm-startwin: command not found.
##|
##'================================================================'
em_lib__startwin () {

    local geom="${1}"

    if type evm-startwin > /dev/null 2>&1; then
        geom="$(evm-startwin --geometry "${@}")"
        [ -z "${geom}" ] && return 1 # отказ от выбора геометрии 
        echo "${geom}";     return 0
    else
        em_lib_syslog_logger "*** Warn: evm-startwin: command not found"
        echo "${geom}"
        return 2
    fi
}
#export -f em_lib__startwin



# :END:
