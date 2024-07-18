#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_ip_uhp_parser.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-22 17:12
##!
##! \brief  user@ip:port parser.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: ip/em_lib_ip_uhp_parser.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief user@ip:port parser.
##!
##! \param $1 - expression form;
##! \param $2 - array name (reference).
##|
##'================================================================'
em_lib_ip_uhp_parser () {
    local -n arr=${2}
    local brr

    local v=$(echo "${1}"|`
             `sed -n 's/^\(\([^ \t@:]*\)@\([^ \t@:]*\):\?\([0-9]*\)\)\|\(\([^ \t@:]*\):\?\([0-9]*\)\)$/\2\n\3\n\4\n\6\n\7/gp')

    IFS=$'\n' mapfile -t brr <<< ${v}

    if [ -n "${brr[3]}" ];then 
        [ -n "${brr[3]}" ] && arr[1]=${brr[3]}
        [ -n "${brr[4]}" ] && arr[2]=${brr[4]}
    else
        [ -n "${brr[0]}" ] && arr[0]=${brr[0]}
        [ -n "${brr[1]}" ] && arr[1]=${brr[1]}
        [ -n "${brr[2]}" ] && arr[2]=${brr[2]}
    fi
}
#export -f em_lib_ip_uhp_parser



# :END:
