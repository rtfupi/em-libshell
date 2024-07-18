#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2024
##!
##! \file   em_lib_pipe_fd.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2024-01-09 21:07 UTC+00:00
##!
##! \brief  Named pipe file descriptor.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: pipe/em_lib_pipe_fd.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief Open file descriptor (for named pipe).
##!
##! \param $1 - pipe name;
##!
##! \return  - stdout : 
##|
##'================================================================'
em_lib_pipe_fd_open (){
    local -n fd=${2}

    fd=$({ seq 0 255; ls -1 /proc/$$/fd; } | sort -n | uniq -u | head -1)
    eval 'exec '"${fd}"'<>${1}'
}
#export -f em_lib_pipe_fd_open


##.================================================================.
##! \brief Close file descriptor (for named pipe).
##!
##! \param $1 - file descriptor
##|
##'================================================================'
em_lib_pipe_fd_close (){
    eval 'exec '"${1}"'>&-'
}
#export -f em_lib_pipe_fd_close



# :END:
