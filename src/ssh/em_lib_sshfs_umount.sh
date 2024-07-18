#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_sshfs_umount.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-23 00:51
##!
##! \brief  Umount remote sshfs.
##|
##'###########################################################################'



# :BEGIN:
##.***************************************************************************.
##| Lib: ssh/em_lib_sshfs_umount.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} fusermount readlink"

##.================================================================.
##! \brief Umount remote sshfs.
##!
##! \param $1 - local mount point;
##|
##'================================================================'
em_lib_sshfs_umount () {
    local mpoint="$(readlink -m "${1/#\~/$HOME}")"
    fusermount -u "${mpoint}" > /dev/null 2>&1
}
#export -f em_lib_sshfs_umount



# :END:
