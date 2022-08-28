#!/bin/bash

# Created by yejq.jiaqiang@gmail.com
# 2022/08/28

openwrt_config() {
	if [ -x "${FTOPDIR}/download/symlink.sh" ] ; then
		# if download directory exists, create
		# symbolic links for download tarballs
		"${FTOPDIR}/download/symlink.sh" dl
	fi

	# remove files first before re-creating symlink
	rm -rf files ; sync
	local TARGETDIR="${FTOPDIR}/dongshanpi-riscv4-target"
	ln -sv "${TARGETDIR}/extra-files" files
	local rval=$?
	[ ${rval} -ne 0 ] && return 1

	# update feeds for openwrt
	./scripts/feeds update -a ; rval=$?
	[ ${rval} -ne 0 ] && return 2
	./scripts/feeds install -a ; rval=$?
	[ ${rval} -ne 0 ] && return 3

	# write .config file for openwrt
	cp -v -f "${TARGETDIR}/dongshanpi.config" .config ; rval=$?
	[ ${rval} -ne 0 ] && return 4

	# expand .config via make V=s -j1 defconfig
	make V=s -j1 defconfig
	return $?
}

openwrt_build() {
	make V=s "-j${MKJOB:-4}"
	return $?
}

openwrt_clean() {
	make V=s "-j${MKJOB:-4}" clean
	return $?
}

register_source openwrt \
	openwrt_config openwrt_build openwrt_clean
