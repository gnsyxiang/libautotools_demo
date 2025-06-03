# ===============================================================
# 
# Release under GPLv-3.0.
# 
# @file    Makefile.am
# @brief   
# @author  gnsyxiang <gnsyxiang@163.com>
# @date    05/03 2021 10:32
# @version v0.0.1
# 
# @since    note
# @note     note
# 
#     change log:
#     NO.     Author              Date            Modified
#     00      zhenquan.qiu        05/03 2021      create the file
# 
#     last modified: 05/03 2021 10:32
# ===============================================================

include res/doxygen.am

SUBDIRS = \
          include \
          src \
          doc \
          example \
          res \
          build-script

if COMPILE_LIBCUNIT
SUBDIRS += test
endif

# ------------------
# defining variables
# ------------------
_install_files_com  =
_dist_files_com     =
include_com         =
ldadd_com           =

ACLOCAL_AMFLAGS     = -I m4
include_com         += $(ACLOCAL_AMFLAGS)

export include_com
export ldadd_com 

# ---------------------
# add necessary content
# ---------------------


# ------------------
# make install files
# ------------------
_install_files_com  += \
                       LICENSE \
                       README.md
dist_doc_DATA       = $(_install_files_com)
pkgconfig_DATA      = $(project_name).pc

# ---------------
# make dist files
# ---------------
_dist_files_com     += \
                       autogen.sh \
                       build.sh \
                       $(project_name).pc.in
EXTRA_DIST          = $(_dist_files_com)

DISTCLEANFILES = $(project_name).pc

distclean-local:
	-rm -rf .cache/ node_modules/ autom4te.cache/ build-aux/
	-rm -rf compile_commands.json aclocal.m4 config.h.in config.h.in~ configure package.json

