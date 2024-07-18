#!/bin/echo It's a library file

##.###########################################################################.
##! Copyright (C) Марков Евгений 2023
##!
##! \file   em_lib__quote_re.sh
##! \author Марков Евгений <upirtf@gmail.com>
##! \date   2023-01-11 14:54
##!
##! \brief  Make quoted regexp string.
##|
##'###########################################################################'


# :BEGIN:
##.***************************************************************************.
##| Lib: misc/em_lib__quote_re.sh
##|
##'***************************************************************************'

##.================================================================.
##! \brief Make quoted regexp string.
##!
##! \param $1 - input string.
##!
##! \return - stdout : quoted string.
##|
##'================================================================'
em_lib__quote_re () {
    echo "${1}"|sed 's,[]/\\$*^.[],\\&,g'
}

#export -f em_lib__quote_re



# :END: