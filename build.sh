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

    # 作用: 加快编译过程
    # 默认情况下，gcc在编译时会生成临时文件来保存中间结果，这些文件可能会暂用磁盘空间并导致一些性能开销。
    # 通过使用-pipe参数，GCC会将这些中间结果通过管道传递给后续的编译阶段，而不是写入到临时文件中。
    # 这样可以减少磁盘I/O操作，提高编译速度，特别是在多核处理器上可以更好地利用并行编译的优势
    cppflag="${cppflag} -pipe"

    # 通常用于指定编译器的警告和错误处理级别。具体来说：
    #   * -W: 启用警告。这个选项告诉编译器输出警告信息，但不会将警告视为错误。
    #   * -Wall: 启用更多的警告。它开启了一组额外的警告选项，以便检测到更多潜在的问题，比如未使用的变量或函数、潜在的类型不匹配等。
    #   * -Werror=all: 将所有警告都视为错误。这个选项会将编译器产生的所有警告都当作错误处理，即使是那些通常不会导致编译失败的警告也会被视为错误，强制开发者解决它们。
    # 这些选项有助于提高代码质量和可移植性，因为它们可以帮助发现潜在的错误和不规范的代码用法。
    cppflag="${cppflag} -W -Wall -Werror=all"

    # 用于指示编译器将每个函数放置在独立的代码段中，而不是将所有函数放在一个统一的代码段中。这个选项的作用包括：
    #   * 减小可执行文件的大小: 将每个函数放置在独立的代码段中，可以使链接器在链接时更容易地剔除未使用的函数，从而减小生成的可执行文件的大小。
    #   * 优化代码布局: 独立的函数段可以更好地利用现代处理器的指令缓存，提高代码执行效率。
    #   * 支持懒加载: 某些操作系统（如Linux）支持懒加载（lazy loading），即只在需要执行某个函数时才将该函数加载到内存中。使用 -ffunction-sections 可以更好地支持这种懒加载机制。
    # 总的来说，使用 -ffunction-sections 可以帮助优化生成的可执行文件的大小和执行效率，尤其对于嵌入式系统或需要优化代码大小的应用程序来说，这个选项非常有用。
    cppflag="${cppflag} -ffunction-sections"

    # -fdata-sections 是 GCC 编译器的一个选项，用于将数据（全局变量和静态变量）放置在独立的数据段中。这个选项与 -ffunction-sections 类似，但是针对的是数据而不是函数。
    # 当你使用 -fdata-sections 编译你的程序时，GCC 将每个全局变量和静态变量放置在单独的数据段中。这种分段的好处之一是可以减小可执行文件的大小，因为链接器可以更好地优化未使用的变量的排列，或者删除未引用的变量。此外，这也有助于提高执行效率，因为可以更容易地在运行时将未使用的数据段从内存中卸载。
    # 总的来说，-fdata-sections 选项可以帮助优化可执行文件的大小和运行效率，特别是对于包含大量全局变量和静态变量的程序来说。
    cppflag="${cppflag} -fdata-sections"

    # -Wl,--gc-sections 是 GCC 编译器的一个链接器选项，它告诉链接器启用垃圾收集（Garbage Collection）功能，用于删除未使用的代码和数据段。
    # 具体来说，--gc-sections 选项告诉链接器在链接过程中删除未使用的代码段和数据段。这可以减小最终可执行文件的大小，并且可以提高程序的加载速度和运行效率，因为未使用的代码和数据不会被包含在最终的可执行文件中。
    # 这个选项通常与 -ffunction-sections 和 -fdata-sections 一起使用，因为这些编译器选项会将函数和数据放置在单独的代码段和数据段中，使得链接器能够更容易地识别和删除未使用的部分。
    # 总的来说，-Wl,--gc-sections 选项可以帮助减小可执行文件的大小，并提高程序的加载速度和执行效率，特别是对于大型项目来说，其中可能存在大量未使用的代码和数据。
    ldflag="${ldflag} -Wl,--gc-sections"

    # -Wl,--as-needed 是 GCC 编译器的一个链接器选项，用于指示链接器只在需要时链接库文件。这个选项告诉链接器仅将那些包含未定义符号的库文件链接到最终的可执行文件中。
    # 通常情况下，当链接器遇到一个库文件时，它会将整个库文件链接到最终的可执行文件中，即使其中只有一小部分代码被使用。这可能导致最终的可执行文件包含大量未使用的代码，从而增加文件大小并降低程序加载速度和执行效率。
    # 使用 -Wl,--as-needed 选项可以帮助减小可执行文件的大小，因为它只会链接那些包含程序实际需要的函数或符号的库文件。这样可以避免将未使用的代码包含在最终的可执行文件中，从而减少文件大小并提高程序的加载速度和执行效率。
    # 总的来说，-Wl,--as-needed 选项可以帮助优化可执行文件，确保只有实际需要的库文件被链接到最终的可执行文件中，从而减小文件大小并提高程序的性能。
    ldflag="${ldflag} -Wl,--as-needed"

    cppflag="${cppflag} -Wno-error=unused-parameter -Wno-unused-parameter"
    cppflag="${cppflag} -Wno-error=unused-result -Wno-unused-result"
    cppflag="${cppflag} -Wno-error=unused-variable"
    cppflag="${cppflag} -Wno-error=unused-function"
    cppflag="${cppflag} -Wno-error=unused-value -Wno-unused-value"

    ldflag="${ldflag} -Wl,-rpath=../lib"

    # -rdynamic的作用是:
    # 1, 导出符号: 将所有符号（包括那些由动态加载函数使用的符号）导出到动态符号表中
    # 2，允许符号在动态加载时可见：当你在使用动态加载库时（比如dlopen），动态加载的代码可以看到这些符号，从而能正确链接和使用他们
    # ldflag="${ldflag} -rdynamic"
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

cd "${cur_path}" && ./autogen.sh && cd - || exit 1

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

