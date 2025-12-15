#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
# diy-part2.sh

# =======================================================================
# 修复 Python 3.11.14 交叉编译错误
# 错误: configure: error: Cross compiling required --host=HOST-TUPLE and --build=ARCH
# =======================================================================
# =======================================================================
# 修复 Python 3.11.14 交叉编译错误 (确保以下代码没有被注释)
# =======================================================================

PYTHON3_MK="feeds/packages/lang/python/python3/Makefile"

if [ -f "$PYTHON3_MK" ]; then
    echo "Applying patch for python3 cross-compile error..."

    # 1. 在 Python 的 configure 选项中添加明确的 --build 参数
    # 替换规则：找到包含 --host=$(GNU_HOST_TUPLE) 的行，并在后面加上 --build=$(GNU_BUILD_TUPLE)
    sed -i 's/--host=$(GNU_HOST_TUPLE)/--host=$(GNU_HOST_TUPLE) --build=$(GNU_BUILD_TUPLE)/' "$PYTHON3_MK"
    
    # 2. 移除 Makefile 中错误的 --target 参数
    sed -i 's/--target=$(GNU_TARGET_TUPLE)//' "$PYTHON3_MK"

    echo "Python3 Makefile patched successfully."
else
    echo "Warning: Python3 Makefile not found at $PYTHON3_MK"
fi
