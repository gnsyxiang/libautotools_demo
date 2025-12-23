/**
 * 
 * Release under GPLv-3.0.
 * 
 * @file    hy_module_test.c
 * @brief   
 * @author  gnsyxiang <gnsyxiang@163.com>
 * @date    23/03 2022 16:59
 * @version v0.0.1
 * 
 * @since    note
 * @note     note
 * 
 *     change log:
 *     NO.     Author              Date            Modified
 *     00      zhenquan.qiu        23/03 2022      create the file
 * 
 *     last modified: 23/03 2022 16:59
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <CUnit/Basic.h>
#include <CUnit/Console.h>
#include <CUnit/CUnit.h>
#include <CUnit/TestDB.h>
#include <CUnit/Automated.h>

#include "hy_module.h"

typedef struct {
    void *handle;
} _module_context_s;

static _module_context_s *context = NULL;

void module_create_cases(void)
{
    context->handle = HyModuleCreate();

    CU_ASSERT(context->handle != NULL);
}

void module_destroy_cases(void)
{
    HyModuleDestroy(&context->handle);
}

static CU_TestInfo module_test_cases[] = {
    {"test <HyModuleCreate>:", module_create_cases},
    {"test <HyModuleDestroy>:", module_destroy_cases},
    CU_TEST_INFO_NULL
};

int module_suite_init()
{
    context = malloc(sizeof(context));
    if (!context) {
        printf("malloc failed \n");
        return -1;
    }

    return 0;
}

int module_suite_clean()
{
    free(context);

    return 0;
}

static CU_SuiteInfo suites[] = {
    {"test <HyModule>:", module_suite_init, module_suite_clean, NULL, NULL, module_test_cases},
    CU_SUITE_INFO_NULL
};

void module_suite(void)
{
    assert(NULL != CU_get_registry());
    assert(!CU_is_test_running());

    if (CUE_SUCCESS != CU_register_suites(suites)) {
        exit(EXIT_FAILURE);
    }
}

