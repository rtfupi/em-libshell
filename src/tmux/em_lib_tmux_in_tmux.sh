#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023.
##!
##! \file   em_lib_tmux_in_tmux.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-02-09 10:13
##!
##! \brief  Nested tmux.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: dir/em_lib_tmux_in_tmux.sh
##|
##'***************************************************************************'

# Префих для вложенного tmux.
EM_INNER_PREFIX='C-a'
# Текущий префих для внешнего tmux.
EM_OUTER_CUR_PREFIX='C-a'
# Временный префих для внешнего tmux окна из которого запущен вложенный tmux.
EM_OUTER_TMP_PREFIX='C-b'
# Клавиша вход/выход для включения режима вложенного tmux.
EM_INNER_IO_KEY='S-F12'
# Key table для клавиши EM_INNER_IO_KEY
EM_INNER_IO_KEY_TABLE='-Troot'
# Стиль статуса окна, который находится в режиме 'Tmux in tmux'
EM_OUTER_WIN_STATUS="bg=brown,fg=white"
# Стиль статуса окна в режиме 'Tmux in tmux', если окно текущее.
EM_OUTER_WIN_STATUS_CURR="bg=black,fg=white"
# Стиль линии статуса, если окна в режиме 'Tmux in tmux' выбрано текущем.
EM_OUTER_STATUS_STYLE="bg=grey,fg=black"


EM_SESS_NESTED_EXP2='if [ -n "${EM_SESS_NESTED}" ];then '`
                       `'. /dev/stdin <<< "${EM_SESS_NESTED}";'`
                       `'em_lib_tmux_inner_change_pane;'`
                   `'fi'

EM_SESS_NESTED_EXP='. /dev/stdin <<< "${EM_SESS_NESTED}";em_lib_tmux_switch_nested'


##.===============================================================.
##! \brief Set pane inner prefix.
##!
##! \param $1 - inner prefix key (C-a|C-b|...).
##|
##'==============================================================='
em_lib_tmux_set_pane_inner_prefix () {
    if ! tmux show-option -vp @em-inner-prefix > /dev/null 2>&1;then
        tmux set-option -p @em-inner-prefix ${1}
    fi
    tmux show-option -vp @em-inner-prefix
}


##.===============================================================.
##! \brief To inner tmux.
##!
##! \param $1 - если 'enter', то "с нуля" создать inner mode.
##|
##'==============================================================='
em_lib_tmux_2inner_tmux () {
    local cur_prefix=$(tmux show-options -v @em-outer-cur-prefix)
    local inner_prefix=$(tmux show-options -v @em-inner-prefix)
    local tmp_prefix=$(tmux show-options -v @em-outer-tmp-prefix)

    inner_prefix="$(em_lib_tmux_set_pane_inner_prefix "${inner_prefix}")"

    # session-bound
    tmux set-option prefix "${tmp_prefix}"
    # session-bound
    tmux bind -n "${cur_prefix}" send-keys "${inner_prefix}"

    # window bound
    tmux set-option -w window-status-current-style "${EM_OUTER_WIN_STATUS_CURR}" #2.9
    # window bound
    tmux set-option -w window-status-style "${EM_OUTER_WIN_STATUS}"
    # session-bound
    tmux set-option status-style "${EM_OUTER_STATUS_STYLE}"

    [ "${1}" = enter ] && tmux set-option -p @em-inner-pane on

    tmux display-message -d 1000 \
         "Inner prefix: ${inner_prefix}. Outer prefix: ${tmp_prefix}"
    sleep 1
}


##.===============================================================.
##! \brief To outer tmux.
##!
##! \param $1 - если 'exit', то полностью завершить inner mode.
##|
##'==============================================================='
em_lib_tmux_2outer_tmux () {
    local cur_prefix=$(tmux show-options -v @em-outer-cur-prefix)

    tmux set-option -u prefix        # session-bound
    tmux unbind -n "${cur_prefix}"   # session-bound

    tmux set-option -uw window-status-current-style # window bound
    tmux set-option -uw window-status-style         # window bound
    tmux set-option -u status-style                 # session bound

    [ "${1}" = exit ] &&\
        tmux set-option -up @em-inner-pane \;\
             set-option -up @em-inner-prefix

    # чтобы всегда возврещал true, а то tmux ругается на код возврата.
    return 0
}


##.===============================================================.
##! \brief Change inner prefix.
##|
##'==============================================================='
em_lib_tmux_inner_change_pane () {

    if tmux show-option -vp @em-inner-pane > /dev/null 2>&1;then
        em_lib_tmux_2inner_tmux
    else
        em_lib_tmux_2outer_tmux
    fi
}


##.===============================================================.
##! \brief Change inner prefix.
##|
##'==============================================================='
em_lib_tmux_switch_inner_prefix () {
    local inner_prefix
    local inner_prefix_s=$(tmux show-options -v "@em-inner-prefix")
    local inner_prefix_in

    inner_prefix="$(em_lib_tmux_set_pane_inner_prefix "${inner_prefix_s}")"

    # Stn pane local option `@em-inner-prefix'
    tmux command-prompt -k \
         -p "Inner prefix is '${inner_prefix}' (press a key combination):" \
         "set-option -p @em-inner-prefix '%%'"

    inner_prefix_in="$(tmux show-options -pv @em-inner-prefix)"

    if [ "${inner_prefix_in}" = Enter ] \
           || [ "${inner_prefix_in}" = "${EM_INNER_IO_KEY}" ]
    then
        tmux set-option -p @em-inner-prefix "${inner_prefix}"
    fi
}


##.===============================================================.
##! \brief Переключить между outer и inner tmux.
##|
##'==============================================================='
em_lib_tmux_switch_nested () {
    local v=$(tmux show-options -v prefix) # session option 
    if [ -z "${v}" ];then
        em_lib_tmux_switch_inner_prefix
        em_lib_tmux_2inner_tmux enter
    else
        em_lib_tmux_2outer_tmux exit
    fi
}


EM_SESS_NESTED=$(\
                 declare -f em_lib_tmux_switch_nested; \
                 echo "export -f em_lib_tmux_switch_nested"; \
                 declare -f em_lib_tmux_switch_inner_prefix; \
                 echo "export -f em_lib_tmux_switch_inner_prefix"; \
                 declare -f em_lib_tmux_2inner_tmux; \
                 echo "export -f em_lib_tmux_2inner_tmux"; \
                 declare -f em_lib_tmux_2outer_tmux; \
                 echo "export -f em_lib_tmux_2outer_tmux"; \
                 declare -f em_lib_tmux_inner_change_pane; \
                 echo "export -f em_lib_tmux_inner_change_pane"; \
                 declare -f em_lib_tmux_set_pane_inner_prefix; \
                 echo "export -f em_lib_tmux_set_pane_inner_prefix"; \
              )



# :END:
