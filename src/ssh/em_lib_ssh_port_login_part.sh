#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_ssh_port_login_part.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-12-20 08:48 UTC+00:00
##!
##! \brief  Get port components of user@host[:port]
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: ssh/em_lib_ssh_port_login_part.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} sed"

##.=======================================================================.
##! \brief Get port components of user@host[:port]
##!
##! \param $1 - user@host[:port]
##|
##'======================================================================='
em_lib_ssh_port_login_part () {
    local var

    # var=$(echo "${1}"|sed 's/^[-_0-9a-z]\+@[-_.0-9a-z]\+\(:\([0-9]\+\)\)*/\2/g')
    var=$(echo "${1}"|sed -n 's/^.\+:\([0-9]\+\)$/\1/pg')
    [ -z "${var}" ] && return 1
    echo "${var}"
    return 0
}
#export -f em_lib_ssh_port_login_part



# :END:
