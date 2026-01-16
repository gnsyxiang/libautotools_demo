#!/usr/bin/env bash

# set -x

format_str_array_output()
{
    for i in $1; do
        echo "    $i"
    done
}

select_vender()
{
    echo "support vender: "

    local _array
    local _vender
    local _flag="false"

    _array=$(find ./build-script/ -maxdepth 1 -type d)
    for i in ${_array}; do
        _vender="${_vender} ${i##*/}"
    done

    format_str_array_output "${_vender}"

    echo -n "please select vender: "
    echo -n -e "\e[32m"
    read -r usr_select_vender
    echo -n -e "\e[0m"

    for i in ${_array}; do
        if [[ ${i##*/} = "${usr_select_vender}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ -z "${usr_select_vender}" || ${_flag} != "true" ]]; then
        echo "error select vender !!!"
        exit 1
    fi

    configure_param="${configure_param} --with-vender=${usr_select_vender}"
}

select_chip()
{
    echo "support chip: "

    local _array
    local _chip
    local _flag="false"

    _array=$(find ./build-script/"${usr_select_vender}" -name "config.sh")

    for i in ${_array}; do
        _chip=$(sed '/^chip=/!d;s/.*=//' "$i")
        chip="${chip} ${_chip}"
    done

    format_str_array_output "${chip}"

    echo -n "please select chip: "
    echo -n -e "\e[32m"
    read -r usr_select_chip
    echo -n -e "\e[0m"

    for i in ${_array}; do
        _chip=$(sed '/^chip=/!d;s/.*=//' "$i")
        if [[ ${_chip} = "${usr_select_chip}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ ${_flag} != "true" ]]; then
        echo "error select chip !!!"
        exit 1
    fi

    configure_param="${configure_param} --with-chip=${usr_select_chip}"
}

select_os()
{
    echo "support os: "

    local _product_file
    local _os
    local _flag="false"

    _product_file=./build-script/${usr_select_vender}/${usr_select_chip}/config.sh

    _os=$(sed '/^os=/!d;s/.*=//' "$_product_file")

    format_str_array_output "${_os}"

    echo -n "please select os: "
    echo -n -e "\e[32m"
    read -r usr_select_os
    echo -n -e "\e[0m"

    for i in ${_os}; do
        if [[ $i = "${usr_select_os}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ ${_flag} != "true" ]]; then
        echo "error select os !!!"
        exit 1
    fi

    configure_param="${configure_param} --with-os=${usr_select_os}"
}

select_product()
{
    echo "support product: "

    local _product_file
    local _product
    local _flag="false"

    _product_file=./build-script/${usr_select_vender}/${usr_select_chip}/config.sh

    _product=$(sed '/^product=/!d;s/.*=//' "$_product_file")

    format_str_array_output "${_product}"

    echo -n "please select product: "
    echo -n -e "\e[32m"
    read -r usr_select_product
    echo -n -e "\e[0m"

    for i in ${_product}; do
        if [[ $i = "${usr_select_product}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ ${_flag} != "true" ]]; then
        echo "error select product !!!"
        exit 1
    fi

    configure_param="${configure_param} --with-product=${usr_select_product}"
}

select_language()
{
    echo "support language: "

    local _product_file
    local _language
    local _flag="false"

    _product_file=./build-script/${usr_select_vender}/${usr_select_chip}/config.sh

    _language=$(sed '/^language=/!d;s/.*=//' "$_product_file")

    format_str_array_output "${_language}"

    echo -n "please select language: "
    echo -n -e "\e[32m"
    read -r usr_select_language
    echo -n -e "\e[0m"

    for i in ${_language}; do
        if [[ $i = "${usr_select_language}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ ${_flag} != "true" ]]; then
        echo "error select language !!!"
        exit 1
    fi

    configure_param="${configure_param} --with-language=${usr_select_language}"
}

select_build_version()
{
    echo "support build version: "

    local _build_version="release debug"
    local _flag="false"

    format_str_array_output "${_build_version}"

    echo -n "please select build version: "
    echo -n -e "\e[32m"
    read -r usr_select_build_version
    echo -n -e "\e[0m"

    for i in ${_build_version}; do
        if [[ $i = "${usr_select_build_version}" ]]; then
            _flag="true"
            break
        fi
    done
    if [[ ${_flag} != "true" ]]; then
        echo "error select build version !!!"
        exit 1
    fi
}

get_com_config()
{
    cppflag="${cppflag} -D_GNU_SOURCE"
    cppflag="${cppflag} -pipe"
    cppflag="${cppflag} -W -Wall -Werror=all"
    cppflag="${cppflag} -ffunction-sections"
    cppflag="${cppflag} -fdata-sections"
    cppflag="${cppflag} -Wno-error=unused-parameter -Wno-unused-parameter"
    cppflag="${cppflag} -Wno-error=unused-result -Wno-unused-result"
    cppflag="${cppflag} -Wno-error=unused-variable"
    cppflag="${cppflag} -Wno-error=unused-function"
    cppflag="${cppflag} -Wno-error=unused-value -Wno-unused-value"

    ldflag="${ldflag} -Wl,-rpath=../lib"
    ldflag="${ldflag} -Wl,--gc-sections"
    ldflag="${ldflag} -Wl,--as-needed"
}

get_config()
{
    _config_file=./build-script/${usr_select_vender}/${usr_select_chip}/config.sh

    host=$(sed '/^host=/!d;s/.*=//' "$_config_file")
    cross_gcc_path=$(sed '/^cross_gcc_path=/!d;s/.*=//' "$_config_file")

    _cppflag=$(sed '/^cppflag=/!d;s/cppflag=//' "$_config_file")
    _cflag=$(sed '/^cflag=/!d;s/cflag=//' "$_config_file")
    _cxxflag=$(sed '/^cxxflag=/!d;s/cxxflag=//' "$_config_file")
    _ldflag=$(sed '/^ldflag=/!d;s/ldflag=//' "$_config_file")
    _lib=$(sed '/^lib=/!d;s/lib=//' "$_config_file")
    _debug=$(sed '/^debug=/!d;s/debug=//' "$_config_file")
    _release=$(sed '/^release=/!d;s/release=//' "$_config_file")

    install_path=$(sed '/^install_path=/!d;s/.*=//' "$_config_file")

    _configure_param=$(sed '/^configure_param=/!d;s/configure_param=//' "$_config_file")

    cppflag="${cppflag} ${_cppflag}"
    cflag="${cflag} ${_cflag}"
    cxxflag="${cxxflag} ${_cxxflag}"
    ldflag="${ldflag} ${_ldflag}"
    lib="${lib} ${_lib}"

    if [[ ${usr_select_build_version} = "debug" ]]; then
        cppflag="${cppflag} ${_debug}"
        configure_param="${configure_param} --enable-debug_info"
    else
        cppflag="${cppflag} ${_release}"
    fi

    configure_param="${configure_param} ${_configure_param}"
}

select_vender
select_chip
select_os
# select_product
select_language
select_build_version
get_com_config
get_config

cur_path=$(pwd)

if [ ${#1} -gt 0 ]; then
    install_path=$1
fi

cppflag="${cppflag} -I${install_path}/include"
ldflag="${ldflag} -L${install_path}/lib"

make distclean

cd "${cur_path}" && ./autogen.sh "${cross_gcc_path}" && cd - >/dev/null 2>&1 || exit 1

export STRIP=${cross_gcc_path}strip
"${cur_path}"/configure                                     \
    CC="${cross_gcc_path}"gcc                               \
    CXX="${cross_gcc_path}"g++                              \
    CPPFLAGS="${cppflag}"                                   \
    CFLAGS="${cflag}"                                       \
    CXXFLAGS="${cxxflag}"                                   \
    LDFLAGS="${ldflag}"                                     \
    LIBS="${lib}"                                           \
    PKG_CONFIG_PATH="${install_path}/lib/pkgconfig"         \
    --prefix="${install_path}"                              \
    --build=                                                \
    --host="${host}"                                        \
    --target="${host}"                                      \
    \
    ${configure_param}

if [[ $? -ne 0 ]]; then
    exit 1
fi

thread_jobs=$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)

if [ x"$usr_select_build_version" = x"debug" ]; then
    make -j"${thread_jobs}" && make install
else
    make -j"${thread_jobs}" && make install-strip
fi

