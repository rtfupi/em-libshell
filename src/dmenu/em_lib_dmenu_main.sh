#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2022
##!
##! \file   em_lib_dmenu_main.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2022-09-22 23:18
##!
##! \brief Библиотека поддержки 'dmenu' в скриптах.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: dmenu/em_lib_dmenu_main.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} dmenu"

##.================================================================.
##! \brief Добавить в начало файла строки из списка. Удалить из файла все
##!        копии добавленных строк.
##!
##! \param $1 - список строк для добавления (удаления) в (из) файл(а);
##! \param $2 - путь до файла;
##! \param $3 - если аргумент не пустой, то выполнить удаление строк.
##|
##| Unix command to prepend text to a file
##| https://stackoverflow.com/questions/10587615/unix-command-to-prepend-text-to-a-file
##| Будет ли работать на больших размерах без временных файлов?
##|
##| How to remove duplicate lines inside a text file?
##| https://unix.stackexchange.com/questions/30173/how-to-remove-duplicate-lines-inside-a-text-file
##|
##'================================================================'
em_lib_dmenu_uniq_line () {
    local lst=${1}
    local fname=${2}
    local remove=${3}
    local str

    while  IFS= read -r str; do
        echo "$(echo "${str}";cat ${fname})" > ${fname}
        cat ${fname}
        awk  -i inplace '!a[$0]++' ${fname}
        cat ${fname}
        [ -n "${remove}" ] && sed -i '1d' ${fname}
    done <<< ${lst}
}
# export -f em_fn_uniq_line


##.================================================================.
##! \brief Основной код управления 'dmenu'. Выбор строки происходит
##!        в соответствии с правилами функционирования 'dmenu' (man dmenu).
##!        Если в конце строки ввода 'dmenu' добавить '---' и выполнить
##!        подтверждение ввода, то такая строка будет удаленна из файла
##!        истории. Если выделить одну или несколько строк 'dmenu'
##!        (Ctrl-Enter), затем в строке ввода набрать '---' и выполнить
##!        подтверждение ввода, то такие строки будут удалены из файла
##!        истории.
##!
##! \param $1 - путь до файла истории;
##! \param $2 - dmenu lists items vertically;
##! \param $3 - sets the width of the dmenu window;
##! \param $4 - dmenu is placed at this offset measured from the top
##!             of the monitor;
##! \param $5 - dmenu  is  placed  at this offset measured from the
##!             left side of the monitor;
##! \param $6 - defines the normal background color;
##! \param $7 - defines the normal foreground color;
##! \param $8 - defines the font or font set used.
##!
##! \return  -  stdout :
##!                 строка 'dmenu';
##!          - return code :
##!                 0 - строка 'dmenu' получена успешно;
##!                 2 - отказ от выбора стоки 'dmenu';
##!                 3 - выполнено удаление строк из 'dmenu'.
##|
##'================================================================'
em_lib_dmenu_main () {
    local hist=${1}
    local input l z y x nb nf fnt
    local display=":0"; [ -n "${9}" ] && display="${9}"

    [ -n "${2}" ] && l="-l ${2}"
    [ -n "${3}" ] && z="-z ${3}"
    [ -n "${4}" ] && y="-y ${4}"
    [ -n "${5}" ] && x="-x ${5}"
    [ -n "${6}" ] && nb="-nb ${6}"
    [ -n "${7}" ] && nf="-nb ${7}"
    [ -n "${8}" ] && fnt="-fn ${8}"

    sed -i '/^$/d' ${hist}


    input=$(DISPLAY=${display} \
                   dmenu ${l} ${z} ${y} ${x} ${nb} ${nf} ${fnt} \
                   < "${hist}")

    [ -z "${input}" ] && return 2

    input="$(echo "${input}"|tac)"

    if [ -n "$(echo "${input}"|sed -n '1s/^[^-]*---$/1/p')" ];then
        input=$(echo "${input}"|sed '1s/.\{3\}$//')
        em_fn_uniq_line "${input}" "${hist}" remove
        return 3
    fi

    em_fn_uniq_line "${input}" "${hist}"

    echo "${input}"

    return 0
}
# export -f em_lib_dmenu_main



# :END:
