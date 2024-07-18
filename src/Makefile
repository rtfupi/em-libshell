# (org-open-file "~/doc/make/GNU_make.htm")
#---------------------------------------------------------------------

include ../misc/make/function.mk

#export AT := @
export AT :=

EM_DEBUG := em-libshell


EM_SOURCE_SH  := ../../ext/em-libshell/lib/em-source.sh
SHELLSUBS_AWK := ../../ext/em-libshell/utils/shellsubs/em_shellsubs.awk

TIMESTAMP     := $(call get_timestamp_str)
DST_DIR       :=$(HOME)/bin
SRC_DIR       :=../..
BAK_DST_DIR   :=.ATTIC/backup
BAK_LOG       :=$(DST_DIR)/$(BAK_DST_DIR)/$(TIMESTAMP).log

CP_ONLY :=

AWK := awk
SED := sed
RM  := rm

EM_FILES_SRC := em-libshell

EM_FILES := $(patsubst %,../../%,$(EM_FILES_SRC))


.PHONY: all all2bin cleanall help test1

all: help

##.===========================================================================.
##! \fn all2bin
##! \brief Пересобрать все скрипты расположенный в каталоге ~/bin из исходных
##!        скрипт файлов.
##|
##| \hlp  all2bin         - пересобрать все скрипты из исходников и
##| \hlp                    скопировать в каталог ~/bin ,
##| \hlp                    например:
##| \hlp                    make all2bin
##| \hlp                    или только копирование из корня проекта
##| \hlp                    make all2bin CP_ONLY=yes ;
##| \hlp
##'==========================================================================='
all2bin: $(EM_FILES)


##.===========================================================================.
##! \fn Цель - скрипт в кталоге ~/bin
##! \brief Пересобрать скрипт расположенный в каталоге ~/bin из исходного
##!        скрипт файла.
##|
##| \hlp  ~/bin/<script>  - пересобрать целевой скрипт из исходника и
##| \hlp                    скопировать в каталог ~/bin ,
##| \hlp                    например:
##| \hlp                    make ~/bin/script_name
##| \hlp                    или только копирование из корня проекта
##| \hlp                    make ~/bin/script_name CP_ONLY=yes ;
##| \hlp
##'==========================================================================='
$(HOME)/bin/%: ../../%
	@echo -e ".----------------\n"
	$(AT)mkdir -p $(HOME)/bin/$(BAK_DST_DIR)
	$(AT)$(call rsync_bak,\
		--include $(subst ../../,,$<) --exclude '*',\
		$(BAK_DST_DIR),\
		$(TIMESTAMP),\
		$(BAK_LOG),\
		$(SRC_DIR),\
		$(DST_DIR))
	@echo -e "'----------------\n"


##.===========================================================================.
##! \fn Цель - скрипт в корне проекта.
##! \brief Пересобрать промежуточный скрипт расположенный в корне проекта из
##!        исходного скрипт файла.
##|
##| \hlp  ../../<script>  - пересобрать промежуточный вариант скрипта:
##| \hlp                    make ../../script_name ;
##| \hlp
##'==========================================================================='
../../%: %
ifneq ($(CP_ONLY),yes)
	cat $<|$(AWK) -v debug=0 -v cdir="./" -f $(SHELLSUBS_AWK) > $@;\
	sed -i '/^[ \t]*# 8< DEBUG 8<.*$$/,/^[ \t]*# >8 DEBUG >8.*$$/d' $@;\
	sed -i '/^[ \t]*EM_DEBUG .*$$/d' $@;\
	$(AT). $(EM_SOURCE_SH);\
	chmod ugo+x $@
endif


##.===========================================================================.
##! \fn cleanall.
##! \brief Удалить все промежуточные скрипты.
##|
##| \hlp  cleanall        - удалить все промежуточные скрипты:
##| \hlp                    make cleanall ;
##| \hlp
##'==========================================================================='
cleanall:
	$(RM) $(EM_FILES)


# Создать wraper для тестирования скрипта через запуск по WIN+F11.
# XFCE -> Settings -> Keyboard -> Aplication Shortcut -> em-test1 Super+F11

##.===========================================================================.
##! \fn test1.
##! \brief Создать wraper для тестирования скрипта через запуск по WIN+F11.
##!
##! XFCE -> Settings -> Keyboard -> Aplication Shortcut -> em-test1 Super+F11
##|
##| \hlp  test1           - Создать wraper для тестирования скрипта через
##| \hlp                    запуск по shotcut-у WIN+F11:
##| \hlp                    make test1;
##| \hlp
##'==========================================================================='
test1: ${HOME}/bin/em-test1

${HOME}/bin/em-test1: tests/$(EM_DEBUG) ./Makefile
	$(SED) "s|{{PWD}}|$$(pwd)|g" $<  > $@; chmod ugo+x $@


##.===========================================================================.
##! \fn help
##! \brief Help message.
##|
##| \hlp
##| \hlp  help            - this message.
##'==========================================================================='
help:
	@echo ""
	@echo "Use:"
	@echo " make [GOAL]"
	@echo ""
	@echo "GOALS:"
	@echo ""
	@grep '^##| \\hlp' ./Makefile|sed 's/^##| \\hlp//g'
