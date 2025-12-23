# ===============================================================
# 
# Release under GPLv-3.0.
# 
# @file    Makefile.am
# @brief   
# @author  gnsyxiang <gnsyxiang@163.com>
# @date    02/02 2024 11:19
# @version v0.0.1
# 
# @since    note
# @note     note
# 
#     change log:
#     NO.     Author              Date            Modified
#     00      zhenquan.qiu        02/02 2024      create the file
# 
#     last modified: 02/02 2024 11:19
# ===============================================================

# ------------------
# defining variables
# ------------------
_dist_file_com  =

# ------------------
# make install files
# ------------------


# ---------------
# make dist files
# ---------------
_dist_file_com  += config.sh

EXTRA_DIST      = $(_dist_file_com)

dist-hook:
	@echo "modify configure.ac"; \
		\
		sed -i 's/product=.*/product=$(product)/g' $(top_distdir)/build-script/$(vender)/$(chip)/config.sh; \
		sed -i 's/language=.*/language=$(language)/g' $(top_distdir)/build-script/$(vender)/$(chip)/config.sh; \
		\
		sed -i '/test/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a test/$(run_os)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a test/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i '/res/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a res/voice/$(language)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a res/voice/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a res/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i '/src/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a src/$(run_os)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a src/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i '/include/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a include/$(run_os)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a include/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i '/example/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a example/$(run_os)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a example/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i '/build-script/d' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a build-script/$(vender)/$(chip)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a build-script/$(vender)/Makefile' $(top_distdir)/configure.ac; \
		sed -i '/project_name.pc/a build-script/Makefile' $(top_distdir)/configure.ac; \
		\
		sed -i 's/doc\/Makefile/doc\/Makefile])/g' $(top_distdir)/configure.ac; \
		\
		sed -i '/AC_INIT/i m4_include([m4/check_project_info.m4])' $(top_distdir)/configure.ac

