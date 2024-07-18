#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2018
##!
##! \file   em_lib_xorg_keydown_check.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-02-14 Пн 16:31  
##!
##! \brief  Проверка факта удержания клавиши клавиатуры.
##|
##'###########################################################################'



# :BEGIN:

##.***************************************************************************.
##| Lib: xorg/em_lib_xorg_keydown_check.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} xinput"

##.================================================================.
##! \brief Получить список индексов устройств клавиатурного ввода.
##!
##! \return  - stdout : список индексов (n1 n2 n3 ...)
##|
##'================================================================'
em_lib_xorg_xinput_get_idxs () {

    local next=
    local ret=
    local v=

    xinput --list | \
        (while IFS= read -r line; do
             # state machine
             case "${next}" in
                 KEYBOARD)
                     # Virtual core keyboard
                     case "${line}" in
                         *"Virtual core pointer"*)
                             # конец списка устройства клавиатурного ввода
                             next=
                             ;;
                         *)
                             if [ -n "$(echo "${line}"|grep 'Virtual core XTEST keyboard')" ];then 
                                 # исключим элемент из списка устройства
                                 # клавиатурного ввода
                                 :
                             else
                                 # очередной элемент списка устройства
                                 # клавиатурного ввода
                                 v=$(echo ${line}| \
                                         sed 's/^.* id=\([0-9]\+\) .*$/\1/g')
                                 ret="${ret} ${v}"
                             fi
                     esac
                     ;;
                 *)
                     if [ -n "$(echo "${line}"|grep 'Virtual core keyboard')" ];then
                         # начало списка устройства клавиатурного ввода
                         next=KEYBOARD
                     fi
                     ;;
             esac
         done; echo "$ret")
}
#export -f em_lib_xorg_xinput_get_idxs


##.================================================================.
##! \brief Проверить факт удержания нажатой клавиши клавиатуры.
##!
##! \param $1 - количество попыток тестирования состояния клавиш (default 20);
##! \param $2 - код тестируемой клавиши (использовать 'xev' для определения),
##!             default - любая клавиша.
##!
##! \return  - return code :
##!                 0 - нет удержания;
##!                 1 - есть удержание.
##|
##'================================================================'
em_lib_xorg_keydown_check () {
    local count=20 # default
    local key=down # default
    local r=0
    
    [ -n "${1}" ] && count=${1}
    [ -n "${2}" ] && key="key\\[${2}\\]=down"

    while
        for did in $(em_lib_xorg_xinput_get_idxs)
        do
            xinput query-state $did 2>/dev/null | grep "${key}"
        done | egrep .
    do
        r=1
        sleep 0.1
        let "count--"
        [ ${count} = 0 ] && break
    done

    return ${r}
}
#export -f em_lib_xorg_keydown_check



# :END:
