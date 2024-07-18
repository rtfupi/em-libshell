#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib__expand_tilda_quote.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-01-12 00:21
##!
##! \brief  .
##|
##'###########################################################################'


em_source "./em_lib__quote.sh"


# :BEGIN:
##.***************************************************************************.
##| Lib: misc/em_lib__expand_tilda_quote.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief Make quoted and expanded path.
##!
##! \return - stdout : quoted path.
##|
##'================================================================'
em_lib__expand_tilda_quote () {
    local path=$(em_lib__quote "${1}")
    echo "${path/#\\~/${HOME}}"
}

#export -f em_lib__expand_tilda_quote



# :END:
