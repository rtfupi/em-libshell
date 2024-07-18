#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib__term_opts_mapper.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-11-21 01:18
##!
##! \brief  Отображает опции настройки виртуального терминала в опции той же
##!         функциональности для конкретного типа виртуального терминала
##!         (xterm, lxterminal, xfce4-terminal).
##|
##'###########################################################################'

em_source "../syslog/em_lib_syslog_logger.sh"
em_source "../syslog/em_lib_syslog_cmd_not_found.sh"
em_source "../misc/em_lib__quote.sh"

# :BEGIN:
##.***************************************************************************.
##| Lib: misk/em_lib__term_opts_mapper.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief  Отображает опции настройки обобщенного виртуального
##!         терминалав опции той жефункциональности для конкретного
##!         типа виртуального терминала (xterm, lxterminal,
##!         xfce4-terminal).
##!
##! \param $1 - разновидность виртуального терминала (xterm,
##!             lxterminal, xfce4-terminal);
##! \param $2 - a terminal option;
##! \param $3 - value of option.
##!
##! \return  - return code :
##!                 0 - опция сопоставлена;
##!                 1 - программа виртуальтного терминала не задана;
##!                 2 - программа виртуального терминала не установлена;
##!                 3 - программа виртуального терминала не поддерживается;
##!                 4 - нет такой опции.
##!            stdout : строка опции со значением опции.
##|
##'================================================================'
em_lib__term_opts_mapper () {

    if [ -z "${1}" ];then
        em_lib_syslog_logger -n "${FUNCNAME}" \
                             "*** Error: terminal program not set."
        return 1
    fi

    em_lib_syslog_cmd_not_found "${1}" || return 2

    case "${1}" in
        xterm)
            case "${2}" in
                --geometry) echo "-geometry ${3}";;
                --fnt)  echo "-fn $(em_lib__quote "${3}")";;
                --fg)   echo "-fg ${3}";;
                --bg)   echo "-bg ${3}";;
                --exec-opt) echo -ne '-e\n';;
                -e)     echo "-e ${3}";;
                --title|-T)
                    echo "-T $(em_lib__quote "${3}")" \
                         "-xrm $(em_lib__quote 'xterm*allowTitleOps: false')"
                    ;;
                --sess-name-prolog) echo "XTERM";;
                ?) echo "true";;
                *) em_lib_syslog_logger -n "${FUNCNAME}" \
                                     "*** Error: ${2}: Key is not supported."
                   return 4
                   ;;
            esac
            ;;
        xfce4-terminal)
            case "${2}" in
                --geometry) echo "--geometry=${3}";;
                --fnt)  echo "--font=$(em_lib__quote "${3}")";;
                --fg)   echo "--color-text=${3}";;
                --bg)   echo "--color-bg=${3}";;
                --exec-opt) echo -ne '-x\n';;
                -e)     echo "-x ${3}";;
                --title|-T) echo "--title=$(em_lib__quote "${3}")";;
                # --title|-T)
                #     echo "--initial-title=\"${2}\" --dynamic-title-mode=after";;
                --sess-name-prolog) echo "FCE4T";;
                ?) echo "true";;
                *) em_lib_syslog_logger -n "${FUNCNAME}" \
                                     "*** Error: ${2}: Key is not supported."
                   return 4
                   ;;
            esac
            ;;
        lxterminal)
            case "${2}" in
                --geometry) echo "--geometry=${3}";;
                --fnt)  echo "";;
                --fg)   echo "";;
                --bg)   echo "";;
                --exec-opt) echo -ne '-e\n';;
                -e) echo "-e ${3}";;
                --title|-T) echo "--title=$(em_lib__quote "${3}")";;
                --sess-name-prolog) echo "LXTER";;
                ?) echo "true";;
                *) em_lib_syslog_logger -n "${FUNCNAME}" \
                                     "*** Error: ${2}: Key is not supported."
                   return 4
                   ;;
            esac
            ;;
        *)
            em_lib_syslog_logger  -n "${FUNCNAME}" \
                       "*** Error: ${1}: Terminal program is not supported."
            return 3
            ;;
    esac
    return 0
}
#export -f em_lib__term_opts_mapper



# :END:
