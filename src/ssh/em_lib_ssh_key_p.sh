#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib_ssh_key_p.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-12-19 16:27
##!
##! \brief  Check if the host has key access.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: ssh/em_lib_ssh_key_p.sh
##|
##'***************************************************************************'

EM_LIB_CHECK_CMD="${EM_LIB_CHECK_CMD} ssh"

##.=======================================================================.
##! \brief Check if the host has key access.
##!
##! \param $1     - connect timeout (in seconds);
##! \param $2..$n - ssh args.
##!
##! \return   - return code :
##!                 >0 - нет доступа.
##!
##! https://ru.stackoverflow.com/questions/1016540/как-проверить-есть-ли-доступ-по-ключам-ssh
##! https://superuser.com/questions/161609/can-someone-explain-the-passwordauthentication-in-the-etc-ssh-sshd-config-fil
##| 
##'======================================================================='
em_lib_ssh_key_p (){

    local tm="${1}"

    shift
    # -o StrictHostKeyHecking=no — это чтобы не было запроса 'доверяем новому
    #                               компьютеру? ответьте: yes/no";
    # -o UserKnownFostsfile=/dev/null — а это чтобы публичный ключ нового
    #                                   компьютера не добавился в "штатный"
    #                                   ~/.ssh/known_hosts (благодаря
    #                                   предыдущей опции он бы добавился
    #                                   "молча");
    #
    # https://superuser.com/questions/161609/can-someone-explain-the-passwordauthentication-in-the-etc-ssh-sshd-config-fil
    #
    # -o PasswordAuthentication=no — запрещаем спрашивать пароль по схеме
    #                                аутентификации, определенной в RFC-4252
    #                                (section 8) в случае если другими
    #                                способами подключиться не удалось.
    # -o ChallengeResponseAuthentication=no — запрещаем спрашивать пароль по
    #                                         схеме 'keyboard-interactive'
    #                                         аутентификации, определенной в
    #                                         RFC-4256 в случае если другими
    #                                         способами подключиться не
    #                                         удалось.
    ssh -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o ConnectTimeout="${tm}" \
        -o PasswordAuthentication=no \
        -o ChallengeResponseAuthentication=no \
        ${@} \
        : \
        2>/dev/null

}
#export -f em_lib_ssh_key_p



# :END:
