#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_blk_mount_id.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-16 23:51
##!
##! \brief Замонтировать block devices по UUID.
##|
##'###########################################################################'

em_source "./em_lib_blk_get_pair.sh"

# :BEGIN:
##.***************************************************************************.
##| Lib: blk/em_lib_blk_mount_id.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} lsblk"

##.===============================================================.
##! \brief Замонтировать block devices по UUID.
##!
##! \param $1 - identifier;
##! \param $2 - identifier value;
##! \param $4 - mount path;
##!
##! \return   - return code :
##!                 1 - нет такого block devices;
##!                 2 - Ok.
##!             stdout :
##!                  mount path.
##|
##'==============================================================='
em_lib_blk_mount_id () {
    local a,r
    em_lib_blk_get_pair a "${1}" MOUNTPOINT "${2}"

    if [ -z "${a[0]}" ];then
        # нет такого block devices
        return 1
    elif [ -z "${a[1]}" ];then
        # block devices не подмонтирован
        [ -d "${3}" ] || mkdir -p "${3}"
        mount ${1}=${2} "${3}" > /dev/null 2>&1
        r=$?
        echo "${3}"
        return ${r}
    else
        # block devices уже подмонтирован
        echo "${a[1]}"
    fi
    return 0
}
#export -f em_lib_blk_mount_id



# :END:
