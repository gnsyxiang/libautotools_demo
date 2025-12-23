/**
 *
 * Release under GPLv-3.0.
 * 
 * @file    hy_module.h
 * @brief   
 * @author  gnsyxiang <gnsyxiang@163.com>
 * @date    23/03 2022 16:46
 * @version v0.0.1
 * 
 * @since    note
 * @note     note
 * 
 *     change log:
 *     NO.     Author              Date            Modified
 *     00      zhenquan.qiu        23/03 2022      create the file
 * 
 *     last modified: 23/03 2022 16:46
 */
#ifndef __AUTOTOOLS_DEMO_LIB_INCLUDE_HY_MODULE_H_
#define __AUTOTOOLS_DEMO_LIB_INCLUDE_HY_MODULE_H_

#ifdef __cplusplus
extern "C" {
#endif

void *HyModuleCreate(void);
void HyModuleDestroy(void **handle);

#ifdef __cplusplus
}
#endif

#endif

