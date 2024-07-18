#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib__passwd_input_xterm.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2024-01-08 15:13 UTC+00:00
##!
##! \brief  Enter the password through the xterm window.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: misc/em_lib__passwd_input_xterm.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} xterm"

##.================================================================.
##! \brief Enter the password through the xterm window.
##!
##! \param $1 - the title;
##! \param $2 - geometry;
##!
##! \return  - return code :
##!                   stdout : password
##|
##'================================================================'
em_lib__passwd_input_xterm () {
    local pipe
    local geom="${2}"

    [ -z "${geom}" ] && geom="=50x5+100+100"

    mkdir -p "/tmp/${SN}"
    pipe=$(mktemp -u -p "/tmp/${SN}/" ".XXXXXXX")
    mkfifo -m 0600 $pipe

    
    export -f em_lib__passwd_input_fn
    export -f em_lib__passwd_input_trap
    export -f em_lib__passwd_input_trap_15
    export -f em_lib__passwd_input_trap_2
    export -f em_lib__passwd_input_trap_1
    export -f em_lib__passwd_input_proc_rc_pipe

    xterm -g "${geom}"  -title "${1}" \
          -e "bash -c \"em_lib__passwd_input_trap '${pipe}';em_lib__passwd_input_fn '${pipe}'\"" \
          > /dev/null 2>&1 &
    
    # 'head' заменил на 'read', т.к. 'head' может блокировать pipe
    # head -n1 "${pipe}"
    
    # bash, чтобы было видно через 'ps'
    # поскольку 'read' - встроенная ф-ия bash
    # line_sBrW3 - переменная с уникальным именем для поиска в выводе
    # 'ps'
    bash -c "read line_sBrW3 < ${pipe}; echo \${line_sBrW3}"

    rm "${pipe}"; pipe=

    export -fn em_lib__passwd_input_fn
    export -fn em_lib__passwd_input_trap
    export -fn em_lib__passwd_input_trap_15
    export -fn em_lib__passwd_input_trap_2
    export -fn em_lib__passwd_input_trap_1
    export -fn em_lib__passwd_input_proc_rc_pipe
}
#export -f em_lib__passwd_input_xterm



##.================================================================.
##! \brief xterm helper function.
##!
##! \param $1 - named pipe;
##|
##'================================================================'
em_lib__passwd_input_fn () {
    local prompt
    local rcode
    
    echo "Press Esc,Ctrl-C or Ctrl-D to Exit"

    # https://superuser.com/questions/1267984/how-to-exit-read-bash-builtin-by-pressing-the-esc-key
    set -o emacs
    bind '"\C-w": kill-whole-line'
    bind '"\e": "\C-w\C-d"'
    bind '"\e\e": "\C-w\C-d"'
    bind '"\e\e\e": "\C-w\C-d"'
    prompt="Password:"
    
    IFS= read -resp "${prompt}"  REPLY
    rcode=$?

    case "${rcode}" in
        0)
            echo "${REPLY}" > "${1}"
            return 0
            ;;
        1) # получен Ctrl-D
            printf '\nAborting\n'
            sleep 1
            echo 'signal://SIGQUIT' > "${1}"
            return 1
           ;;
        *) return 2
           ;;
    esac
}
#export -f em_lib__passwd_input_fn



##.=======================================================================.
##! \brief Trap signals
##!
##! \param $1 - path to named pipe.
##|
##'======================================================================='
em_lib__passwd_input_trap (){
    trap "em_lib__passwd_input_trap_1 ${1}"   1
    trap "em_lib__passwd_input_trap_2 ${1}"   2
    trap "em_lib__passwd_input_trap_15 ${1}" 15
}
#export -f em_lib__passwd_input_trap


# Trap SIGHUP
em_lib__passwd_input_trap_1 () {
    if [ -n "$(em_lib__passwd_input_proc_rc_pipe ${1})" ];then
        echo 'signal://SIGHUP' > "${1}"
    fi
    printf '\n\nAborting\n'
    sleep 1
    rm "${1}"
    trap - 1
    exit
}
#export -f em_lib__passwd_input_trap_1


# Trap SIGINT (ctrl-c)
em_lib__passwd_input_trap_2 () {
    if [ -n "$(em_lib__passwd_input_proc_rc_pipe ${1})" ];then
        echo 'signal://SIGINT' > "${1}"
    fi
    printf '\n\nAborting\n'
    sleep 2
    rm "${1}"
    trap - 2
    exit
}
#export -f em_lib__passwd_input_trap_2

# Trap SIGTERM
em_lib__passwd_input_trap_15 () {
    if [ -n "$(em_lib__passwd_input_proc_rc_pipe ${1})" ];then
        echo 'signal://SIGTERM' > "${1}"
    fi
    printf '\n\nExit\n'
    sleep 1
    rm "${1}"
    trap - 15
    exit
}
#export -f em_lib__passwd_input_trap_15


##.=======================================================================.
##! \brief Find the pipe receiver process.
##!
##! \param $1 - path to named pipe.
##|
##'======================================================================='
em_lib__passwd_input_proc_rc_pipe () {
    #Страховка от зависания пайпа при внештатных случаях
    # head -n1 "${pipe}" - это выход pipe в 'em_lib__passwd_input_xterm'
    # ps -eo args|sed -n "s|^head[\t ]\+.\+${1}\$|\0|p" 
    ps -eo args|sed -n "s|.*read[\t ]\+line_sBrW3.\+${1};.*\$|\0|p" 
}
#export -f em_lib__passwd_input_proc_rc_pipe




# :END:
