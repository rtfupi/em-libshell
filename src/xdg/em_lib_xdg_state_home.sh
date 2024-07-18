#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_xdg_state_home.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date  2023-12-19 16:48
##!
##! \brief  Create the path to XDG_STATE_HOME directory.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: xdg/em_lib_xdg_state_home.sh
##|
##'***************************************************************************'

##.=======================================================================.
##! \brief Create the path to XDG_STATE_HOME directory.
##!
##! \param $1 - addition path;
##! \param $2 - custom path to XDG_STATE_HOME.
##!
##! \return  - stdout :
##!            path to XDG_STATE_HOME/addition_path directory.
##| 
##'======================================================================='
em_lib_xdg_state_home (){
    local apath="${1}"
    local path="${2}"

    if [ -z "${path}" ];then
        path="${HOME}/.local/state"
        [ -n "${XDG_STATE_HOME}" ] && path="${XDG_STATE_HOME}"
    fi

    [ -n "${apath}" ] && path="${path}/${apath}"

    mkdir -p "${path}"

    echo "${path}"
}
#export -f em_lib_xdg_state_home



# :END:
