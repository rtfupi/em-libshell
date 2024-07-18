#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_blk_get_pair.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-03-16 23:51
##!
##! \brief По заданной паре {Имя1:Имя2}, где Имя1 и Имя2 - это
##!        названия колонок команды lsblk, найти значениt колонки
##!        с именем Имя2 по заданному значению колонки с именем
##!        Имя1.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: blk/em_lib_blk_get_pair.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} lsblk"

##.===============================================================.
##! \brief По заданной паре {Имя1:Имя2}, где Имя1 и Имя2 - это
##!        названия колонок команды lsblk, найти значения колонки
##!        с именем Имя2 по заданному значению колонки с именем
##!        Имя1.
##!
##!        Пример:
##!        A=
##!        em_lib_blk_get_pair A UUID MOUNTPOINTS 4DC9-EBA7
##!        declare -p A 
##!
##! \param $1 - имя переменной типа массив;
##! \param $2 - Имя1;
##! \param $3 - Имя2;
##! \param $4 - заданное значению колонки с именем Имя1.
##!
##! \return  - массив по ссылке:
##!                  элемент 0 - заданное значению колонки с
##!                              именем Имя1;
##!                  элемент 1 - значению колонки с именем Имя2.
##|
##'==============================================================='
em_lib_blk_get_pair () {
    local -n arr=${1}
    local v="$(lsblk -n -o ${2},${3}|`
                     `sed -n "s/^\(${4}\)[ \t]\+\(.*\)/\1\n\2/gp")"
    IFS=$'\n' mapfile -t arr <<< ${v}
}
#export -f em_lib_blk_get_pair



# :END:

#lsblk -n -o UUID,MOUNTPOINTS|sed -n 's/^\(4CC9-EB27\)[ \t]\+\(.*\)\(\)/\1\n\2/gp'