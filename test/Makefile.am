# ===============================================================
# 
# Release under GPLv-3.0.
# 
# @file    Makefile.am
# @brief   
# @author  gnsyxiang <gnsyxiang@163.com>
# @date    22/03 2022 16:34
# @version v0.0.1
# 
# @since    note
# @note     note
# 
#     change log:
#     NO.     Author              Date            Modified
#     00      zhenquan.qiu        22/03 2022      create the file
# 
#     last modified: 22/03 2022 16:34
# ===============================================================

SUBDIRS = $(run_os)

# ------------------
# defining variables
# ------------------
_no_error_com   =
_define_com     =
_include_com    = $(include_com)
_sources_com    =
_cppflags_com   =
_cflags_com     =
_cxxflags_com   =
_ldflags_com    =
_ldadd_com      =
bin_PROGRAMS    =

# ---------------------
# add necessary content
# ---------------------
_no_error_com   +=

_define_com     +=

_include_com    += \
                   -I$(top_srcdir)/include/$(run_os) \
                   -I$(top_srcdir)/include

_sources_com    += \
                   hy_calc_test.c \
                   hy_module_test.c

_cppflags_com   += \
                   $(_no_error_com) \
                   $(_include_com) \
                   $(_define_com)

_cflags_com     +=

_cxxflags_com   +=

_ldflags_com    +=

_ldadd_com      += \
                   $(top_builddir)/src/$(run_os)/lib$(project_name).la \
                   $(ldadd_com)

bin_PROGRAMS                        += hy_autotools_demo_lib_test
hy_autotools_demo_lib_test_SOURCES  = $(_sources_com) main.c
hy_autotools_demo_lib_test_CPPFLAGS = $(_cppflags_com)
hy_autotools_demo_lib_test_CFLAGS   = $(_cflags_com)
hy_autotools_demo_lib_test_CXXFLAGS = $(_cxxflags_com)
hy_autotools_demo_lib_test_LDFLAGS  = $(_ldflags_com)
hy_autotools_demo_lib_test_LDADD    = $(_ldadd_com)

