#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])

m4_include([m4/check_project_info.m4])

AC_INIT([PROJECT_NAME], [VERSION_NUM], [EMAIL_INFO], [PROJECT_NAME], [PROJECT_URL])
AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([foreign -Wall -Werror])
AM_SILENT_RULES([yes])
AM_PROG_AR
LT_INIT

PKG_PROG_PKG_CONFIG([0.24])
PKG_INSTALLDIR

SELECT_VENDER
SELECT_CHIP
SELECT_OS
# SELECT_PRODUCT
SELECT_LANGUAGE

# check m4 macro
CHECK_PROJECT_INFO
CHECK_VERSION_INFO
CHECK_DOXYGEN
CHECK_DEBUG_RELEASE
# CHECK_JAVA
CHECK_PTHREAD

# Checks for programs.
AC_PROG_CXX
AC_PROG_AWK
AC_PROG_CC
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
# AC_PROG_RANLIB

# Checks for libraries.

CHECK_LIBCUNIT

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_FUNC_MALLOC

AC_CONFIG_FILES([Makefile
                 $project_name.pc
                 build-script/Makefile
                 build-script/esp32/Makefile
                 build-script/esp32/esp32/Makefile
                 build-script/pc/Makefile
                 build-script/pc/ubuntu/Makefile
                 build-script/pc/windows/Makefile
                 build-script/rock-chips/Makefile
                 build-script/rock-chips/rk3568/Makefile
                 build-script/stm32/Makefile
                 build-script/stm32/stm32f429xx/Makefile
                 build-script/stm32/stm32h743xx/Makefile
                 doc/Makefile
                 example/Makefile
                 example/freertos/Makefile
                 example/linux/Makefile
                 example/mcu/Makefile
                 example/windows/Makefile
                 include/Makefile
                 include/freertos/Makefile
                 include/linux/Makefile
                 include/windows/Makefile
                 res/Makefile
                 res/voice/Makefile
                 res/voice/cn/Makefile
                 res/voice/en/Makefile
                 src/Makefile
                 src/freertos/Makefile
                 src/linux/Makefile
                 src/windows/Makefile
                 test/Makefile
                 test/freertos/Makefile
                 test/linux/Makefile
                 test/windows/Makefile])
AC_OUTPUT

AC_MSG_RESULT([
               $PACKAGE $VERSION

               CC:                  ${CC}
               CPPFLAGS:            ${CPPFLAGS}
               CFLAGS:              ${CFLAGS}
               CXX:                 ${CXX}
               CXXFLAGS:            ${CXXFLAGS}
               LDFLAGS:             ${LDFLAGS}
               LIBS:                ${LIBS}

               prefix:              ${prefix}
               sysconfdir:          ${sysconfdir}
               libdir:              ${libdir}
               includedir:          ${includedir}
               pkgconfigdir:        ${pkgconfigdir}
               ])
