#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib__printing_brief.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-11-20 12:53
##!
##! \brief  Print to stdout brief description.
##|
##'###########################################################################'


# :BEGIN:
##.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
##| Lib: dir/em_lib__print_brief.sh
##|
##'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

##.================================================================.
##! \brief Print to stdout brief description.
##!
##! \param $1 - print details too.
##!
##! Example:
##!   em_print_brief yes  < <(cat "${HOME}/bin/em-...")
##|
##'================================================================'
em_lib__print_brief () {
    local cmd l n next
    local details="${1}"
    local offset="$(printf '%*s' 3)"
    local trim=9

    while IFS= read -r line; do

        if [ -z "${cmd}" ];then
            cmd=$(echo "${line}"|sed -n 's/^##![\t ]*\\file[\t ]\+\(.*\)$/\1/gp')
        elif [ y${next} != yyes ];then
            l=$(echo "${line}"|sed -n 's/^##! \\brief  \(.*\)$/\1/gp')
            if [ -n "${l}" ];then
                next=yes
                echo "${cmd}"
                echo
                echo "${offset}${l}"
            fi
        else
            echo "${line}"|sed -n 's/^##|.*/\0/gp;tx;q100;:x' > /dev/null 2>&1
            [ ${?} -eq 0 ] && break

            echo "${line}"|sed -n '/^##!$/!q100' > /dev/null 2>&1
            if [ ${?} -eq 0 ];then
                [ -z "${details}" ] && break
                trim=1
                echo
                continue
            fi

            l=$(echo "${line}"|sed -n "s/^##! \{$trim\}\(.*\)\$/\1/gp;tx;q100;:x")
            if [ ${?} -eq 0 ];then
                echo "${offset}${l}"
                continue
            fi
        fi
    done
}
#export -f em_lib__print_brief



# :END:
