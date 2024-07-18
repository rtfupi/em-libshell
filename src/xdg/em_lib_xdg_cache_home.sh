#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_xdg_cache_home.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date  2023-12-19 16:48
##!
##! \brief  Create the path to XDG_CACHE_HOME directory.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: xdg/em_lib_xdg_CACHE_home.sh
##|
##'***************************************************************************'

##.=======================================================================.
##! \brief Create the path to XDG_CACHE_HOME directory.
##!
##! \param $1 - addition path;
##! \param $2 - custom path to XDG_CACHE_HOME.
##!
##! \return  - stdout :
##!            path to XDG_CACHE_HOME/addition_path directory.
##| 
##'======================================================================='
em_lib_xdg_cache_home (){
    local apath="${1}"
    local path="${2}"

    if [ -z "${path}" ];then
        path="${HOME}/.cache"
        [ -n "${XDG_CACHE_HOME}" ] && path="${XDG_CACHE_HOME}"
    fi

    [ -n "${apath}" ] && path="${path}/${apath}"

    mkdir -p "${path}"

    echo "${path}"
}
#export -f em_lib_xdg_cache_home



# :END:
