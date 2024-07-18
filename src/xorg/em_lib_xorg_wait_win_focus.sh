#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_xorg_wait_win_focus.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-02-14 Пн 21:52
##!
##! \brief  X-org. Ождать получения фокуса окном.
##|
##'###########################################################################'


em_source "../syslog/em_lib_syslog_logger.sh"


# em_lib_syslog_cmd_not_found "xdotool" || exit 1


## :BEGIN:
##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_wait_win_focus.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} xdotool"

##.================================================================.
##! \brief  Ождать получения фокуса окном.
##!
##! \param $1 - window title (regexp для grep);
##! \param $2 - время ожидания (кратно 0.1 мс, default 10).
##!
##! \return  - stdout :
##!                 window title.
##!          - return code :
##!                 1 - не такого окна.
##|
##'================================================================'
em_lib_xorg_wait_win_focus () {

    local s
    local delay=${2}

    [ -n "${delay}" ] && delay=10

    for i in $(seq 1 ${delay}); do
        s=$(xdotool getwindowname $(xdotool getwindowfocus)|grep "${1}")
        LANG=C sleep 0.1;  # учтем время реакции оконной системы.
        if [ -n "${s}" ]; then
            echo "${s}"
            return 0
        fi
    done
    return 1
}
#export -f em_lib_xorg_wait_win_focus



# :END:
