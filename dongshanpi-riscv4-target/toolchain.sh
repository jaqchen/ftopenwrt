#!/bin/bash

# Created by yejq.jiaqiang@gmail.com
# 2022/08/28

RISCV64_TC=/opt/riscv64-glibc-gcc-thead_20200702
if [ ! -d "${RISCV64_TC}" ] ; then
	echo "Error, riscv64 toolchain not found int /opt" 1>&2
	echo "Extract riscv64-glibc-gcc-thead_20200702.tar.xz to /opt before retry." 1>&2
	exit 1
fi

# setting PATH with toolchain path is not needed
# for building openwrt-22.03, but set it anyway
export PATH="${RISCV64_TC}/bin:/usr/sbin:/sbin:/sbin:/bin"

# remove no longer needed variable
unset RISCV64_TC
