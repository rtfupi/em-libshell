#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_xorg_geom_term_opt.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-30 15:50
##!
##! \brief  Вычислить опцию 'geometry' для команды терминала.
##|
##'###########################################################################'


em_source "../syslog/em_lib_syslog_logger.sh"
em_source "../misc/em_lib__term_opts_mapper.sh"

# :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_geom_term_opt.sh
##|
##'***************************************************************************'

##.===============================================================.
##! \brief Вычислить geometry options. Получить geometry options
##!        с помощью программы EM_G_PROG.
##!
##! \param $1 - geometry value;
##! \param $2 - программа, которая выводит geometry option на stdout;
##! \param $3 - аргументы для $2;
##! \param $4 - команда терминала.
##!
##! \return  -  stdout :
##!                 опция geometry для команды терминала $4.
##|
##'==============================================================='
em_lib_xorg_geom_term_opt () {
    local geom="${1}"
    local r
    
    if [ -n "${2}" ];then
        if type "${2}" > /dev/null 2>&1; then
            geom="$(${2} ${3})"
            if [ ${?} -ne 0 ];then
                return 1 # выход из программы отказом
            fi
        else
            em_lib_syslog_logger "*** Warn: ${2}: command not found"
        fi
    fi
    [ -z "${geom}" ] && geom="130x50"

    em_lib__term_opts_mapper "${4}" --geometry "${geom}"

    return 0
}
#export -f em_lib_xorg_geom_term_opt



# :END:
