/**
 * 
 * Release under GPLv-3.0.
 * 
 * @file    main.c
 * @brief   
 * @author  gnsyxiang <gnsyxiang@163.com>
 * @date    23/03 2022 16:56
 * @version v0.0.1
 * 
 * @since    note
 * @note     note
 * 
 *     change log:
 *     NO.     Author              Date            Modified
 *     00      zhenquan.qiu        23/03 2022      create the file
 * 
 *     last modified: 23/03 2022 16:56
 */
#include <stdio.h>
#include <stdlib.h>

#include <CUnit/Basic.h>
#include <CUnit/Console.h>
#include <CUnit/CUnit.h>
#include <CUnit/TestDB.h>
#include <CUnit/Automated.h>

extern void calc_add_suite(void);
extern void module_suite(void);

int main(int argc, char *argv[])
{
    if (CU_initialize_registry()) {
        fprintf(stderr, " Initialization of Test Registry failed. ");
        exit(EXIT_FAILURE);
    } else {
        calc_add_suite();
        module_suite();

        /* 直接输出测试结果 */
        CU_basic_set_mode(CU_BRM_VERBOSE);
        CU_basic_run_tests();

        /* 交互式的输出测试结果 */
        /* CU_console_run_tests(); */

        /* 自动生成xml等文件 */
        /* CU_set_output_filename("TestMax"); */
        /* CU_list_tests_to_file(); */
        /* CU_automated_run_tests(); */

        CU_cleanup_registry();

        return CU_get_error();
    }

    return 0;
}

