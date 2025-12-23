/**
 * 
 * Release under GPLv-3.0.
 * 
 * @file    hy_module.c
 * @brief   
 * @author  gnsyxiang <gnsyxiang@163.com>
 * @date    23/03 2022 16:48
 * @version v0.0.1
 * 
 * @since    note
 * @note     note
 * 
 *     change log:
 *     NO.     Author              Date            Modified
 *     00      zhenquan.qiu        23/03 2022      create the file
 * 
 *     last modified: 23/03 2022 16:48
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "hy_module.h"

typedef struct {
    char buf[4];
} _module_context_s;

void HyModuleDestroy(void **handle)
{
    assert(handle);
    assert(*handle);

    _module_context_s *content = *handle;

    free(content);
}

void *HyModuleCreate(void)
{
    _module_context_s *content = malloc(sizeof(*content));
    if (!content) {
        perror("malloc failed \n");
        return NULL;
    }

    return content;
}

