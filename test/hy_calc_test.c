/**
 * 
 * Release under GPLv-3.0.
 * 
 * @file    hy_calc_test.c
 * @brief   
 * @author  gnsyxiang <gnsyxiang@163.com>
 * @date    22/03 2022 19:00
 * @version v0.0.1
 * 
 * @since    note
 * @note     note
 * 
 *     change log:
 *     NO.     Author              Date            Modified
 *     00      zhenquan.qiu        22/03 2022      create the file
 * 
 *     last modified: 22/03 2022 19:00
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <CUnit/Basic.h>
#include <CUnit/Console.h>
#include <CUnit/CUnit.h>
#include <CUnit/TestDB.h>
#include <CUnit/Automated.h>

#include "hy_calc.h"

int calc_is_equal(int a, int b, int real)
{
    return (real == HyCalcAdd(a, b));
}

int calc_not_equal(int a, int b, int real)
{
    return (real != HyCalcAdd(a, b));
}

void calc_equal_cases(void)
{
    CU_ASSERT(calc_is_equal(3, 4, 7));
    CU_ASSERT(calc_is_equal(1, 4, 5));
}

void calc_not_equal_cases(void)
{
    CU_ASSERT(calc_not_equal(4, 5, 10));
    CU_ASSERT(calc_not_equal(1, 5, 10));
}

int calc_suite_init()
{
    return 0;
}

int calc_suite_clean()
{
    return 0;
}

CU_TestInfo calc_test_cases[] = {
    {"test <HyCalcAdd> equal cases:", calc_equal_cases},
    {"test <HyCalcAdd> not equal cases:", calc_not_equal_cases},
    CU_TEST_INFO_NULL
};

CU_SuiteInfo suites[] = {
    {"test <HyCalcAdd>:", calc_suite_init, calc_suite_clean, NULL, NULL, calc_test_cases},
    CU_SUITE_INFO_NULL
};

void calc_add_suite(void)
{
    assert(NULL != CU_get_registry());
    assert(!CU_is_test_running());

    if (CUE_SUCCESS != CU_register_suites(suites)) {
        exit(EXIT_FAILURE);
    }
}

