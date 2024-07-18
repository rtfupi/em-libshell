#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_ssh_address_login_p.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-12-20 08:48 UTC+00:00
##!
##! \brief  Get host components of user@host[:port]
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: ssh/em_lib_ssh_address_login_p.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} sed"

##.=======================================================================.
##! \brief Get host components of user@host[:port]
##!
##! \param $1 - [user@]host[:port]
##|
##| https://stackoverflow.com/questions/15965073/return-value-of-sed-for-no-match
##|
##'======================================================================='
em_lib_ssh_address_login_p () {
    local var

    echo "${1}"| \
        sed -n '/\(^[-_0-9a-z]\+@\|^\)\([-.0-9a-z]\+\)\($\|:[0-9]\+$\)/!{q100}'
}
#export -f em_lib_ssh_address_login_p



# :END:
