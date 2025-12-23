dnl ===============================================================
dnl 
dnl Release under GPLv-3.0.
dnl 
dnl @file    select_chip.m4
dnl @brief   
dnl @author  gnsyxiang <gnsyxiang@163.com>
dnl @date    10/03 2022 20:11
dnl @version v0.0.1
dnl 
dnl @since    note
dnl @note     note
dnl 
dnl     change log:
dnl     NO.     Author              Date            Modified
dnl     00      zhenquan.qiu        10/03 2022      create the file
dnl 
dnl     last modified: 10/03 2022 20:11
dnl ===============================================================

# SELECT_CHIP()
# --------------------------------------------------------------
# select chip

AC_DEFUN([SELECT_CHIP],
    [
        chip=""

        AC_ARG_WITH([chip],
                    [AS_HELP_STRING([--with-chip=@<:@ubuntu|windows|rk3568|esp32|stm32h743xx|stm32f429xx@:>@],
                                    [select chip about @<:@ubuntu|windows|rk3568|esp32|stm32h743xx|stm32f429xx@:>@ @<:@default=ubuntu@:>@])],
                    [],
                    [with_chip=ubuntu])

        case "$with_chip" in
            ubuntu)
                AC_DEFINE(HAVE_SELECT_CHIP_UBUNTU,  1, [select ubuntu chip])
                AC_DEFINE(HAVE_SELECT_OS_LINUX,  1, [select linux os])
                chip="ubuntu"
            ;;
            windows)
                AC_DEFINE(HAVE_SELECT_CHIP_WINDOWS,  1, [select windows chip])
                AC_DEFINE(HAVE_SELECT_OS_WINDOWS,  1, [select windows os])
                chip="windows"
            ;;
            rk3568)
                AC_DEFINE(HAVE_SELECT_CHIP_RK3568,  1, [select rk3568 chip])
                AC_DEFINE(HAVE_SELECT_OS_LINUX,  1, [select linux os])
                chip="rk3568"
            ;;
            esp32)
                AC_DEFINE(HAVE_SELECT_CHIP_ESP32,  1, [select esp32 chip])
                AC_DEFINE(HAVE_SELECT_OS_FREERTOS,  1, [select freertos os])
                chip="esp32"
            ;;
            stm32h743xx)
                AC_DEFINE(HAVE_SELECT_CHIP_STM32H743XX,  1, [select stm32h743xx chip])
                AC_DEFINE(HAVE_SELECT_OS_MCU,  1, [select mcu os])
                chip="stm32h743xx"
            ;;
            stm32f429xx)
                AC_DEFINE(HAVE_SELECT_CHIP_STM32F429XX,  1, [select stm32f429xx chip])
                AC_DEFINE(HAVE_SELECT_OS_MCU,  1, [select mcu os])
                chip="stm32f429xx"
            ;;
            *)
                AC_MSG_ERROR([bad value ${with_chip} for --with-chip=@<:@ubuntu|windows|rk3568|esp32|stm32h743xx|stm32f429xx@:>@])
            ;;
        esac

        AC_SUBST(chip)

        AM_CONDITIONAL([COMPILE_SELECT_CHIP_UBUNTU],        [test "x$with_chip" = "xubuntu"])
        AM_CONDITIONAL([COMPILE_SELECT_CHIP_WINDOWS],       [test "x$with_chip" = "xwindows"])
        AM_CONDITIONAL([COMPILE_SELECT_CHIP_RK3568],        [test "x$with_chip" = "xrk3568"])
        AM_CONDITIONAL([COMPILE_SELECT_CHIP_ESP32],         [test "x$with_chip" = "xesp32"])
        AM_CONDITIONAL([COMPILE_SELECT_CHIP_STM32H743XX],   [test "x$with_chip" = "xstm32h743xx"])
        AM_CONDITIONAL([COMPILE_SELECT_CHIP_STM32F429XX],   [test "x$with_chip" = "xstm32f429xx"])
    ])
