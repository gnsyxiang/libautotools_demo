#!/usr/bin/env bash

chip=stm32f429xx

os=freertos mcu

product=stm32

language=cn en

host=arm-none-eabi
cross_gcc_path=/opt/toolchains/mcu/arm-gnu-toolchain_arm-none-eabi/bin/arm-none-eabi-

configure_param=

cppflag=-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard -I/opt/toolchains/mcu/arm-gnu-toolchain_arm-none-eabi/arm-none-eabi/include
cflag=-Dgcc -std=c99 -DUSE_HAL_DRIVER -DSTM32F429xx
cxxflag=
ldflag=-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard -specs=nano.specs -specs=nosys.specs
lib=-lc -lm -lnosys
debug= -Og -g -gdwarf-2
release=-Os

install_path=/mnt/nfs/stm32/stm32f429xx

