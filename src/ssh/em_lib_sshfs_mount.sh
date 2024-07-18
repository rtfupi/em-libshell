#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_sshfs_mount.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-23 00:51
##!
##! \brief  Mount remote sshfs.
##|
##'###########################################################################'


em_source "../ip/em_lib_ip_uhp_parser.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: ssh/em_lib_sshfs_mount.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} ping sshfs readlink"

##.================================================================.
##! \brief Mount remote sshfs.
##!
##! \param $1 - user@host:port;
##! \param $2 - remote mount point;
##! \param $3 - local mount point;
##!
##! \return  - return code :
##!                 0 - successfully mounted or has been mounted;
##!                 1 - mounting error;
##!                 2 - directory creation error;
##!                 3 - host unavailable.
##|
##'================================================================'
em_lib_sshfs_mount () {
    local user host port
    local mpoint="$(readlink -m "${3/#\~/$HOME}")"
    local uhp=()

    em_lib_ip_uhp_parser "${1}" uhp
    # declare -p uhp

    [ -n "${uhp[2]}" ] && port="-o port=${uhp[2]}"
    [ -n "${uhp[0]}" ] && user=${uhp[0]}@;
    host=${user}${uhp[1]}

    if [ -z "$(mount|sed -n "s|.*${uhp[1]}.*${mpoint}|\0|pg")" ];then
        if ping -c 3 ${uhp[1]} > /dev/null 2>&1;then
            if mkdir -p "${mpoint}";then
                if sshfs "${host}:${2}" "${mpoint}" ${port} > /dev/null 2>&1;then
                    # echo ">>>>> 0"
                    return 0
                else
                    # mounting error
                    # echo ">>>>> 1"
                    return 1
                fi
            else
                # directory creation error
                # echo ">>>>> 2"
                return 2
            fi
        else
            # host unavailable
            # echo ">>>>> 3"
            return 3
        fi
    else
        # has been mounted
        # echo ">>>>> 0"
        return 0
    fi
}
#export -f em_lib_sshfs_mount



# :END:
