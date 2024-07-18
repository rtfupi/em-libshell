#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2024
##!
##! \file   em_lib_pipe_named.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2024-01-09 21:07 UTC+00:00
##!
##! \brief  Named pipe.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: pipe/em_lib_pipe_named.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief Open the named pipe.
##!
##! \param $1 - pipe name (format: NAME.XX*);
##!
##! \return  - stdout : 
##!                 pipe name
##|
##'================================================================'
em_lib_pipe_named_open (){
    local pipe npipe

    npipe="${1}"
    [ -z "${npipe}" ] && npipe="$.XXXXXXX"

    mkdir -p "/tmp/${SN}"
    pipe=$(mktemp -u -p "/tmp/${SN}/" "${npipe}")
    mkfifo -m 0600 $pipe

    echo $pipe
}
#export -f em_lib_pipe_named_open


##.================================================================.
##! \brief Close the named pipe.
##!
##! \param $1 - pipe;
##|
##'================================================================'
em_lib_pipe_named_close (){
    rm "${1}"; unset "${1}"
}
#export -f em_lib_pipe_named_close



# :END:
