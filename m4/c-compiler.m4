#! /usr/bin/env bash
#########################################################################
#									#
# Author: Copyright (C) 2019, 2021-2023  Mark Grant			#
#									#
# This file is maintained in the project at:-				#
#	https://github.com/m-grant-prg/project-misc			#
#		new versions are merely copied to consumer projects.	#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# Build variables containing normal / debug pre-processor and compiler	#
# flags depending on compiler version.					#
#									#
# Check gcc version changes here:-					#
#	https://www.gnu.org/software/gcc/				#
#			and check under Changes, C-Family and C.	#
#									#
#########################################################################

#########################################################################
#									#
# Script version	v1.3.0						#
#									#
# Checked up to:-							#
#			gcc v12						#
#			clang v14					#
#			sparse v0.64					#
#									#
#########################################################################


# MG_BUILD_COMPILER_VERSION_CPPFLAGS(CPPFLAGS_Variable, CPPFLAGS_Debug_Variable)
# ------------------------------------------------------------------------------
AC_DEFUN([MG_BUILD_COMPILER_VERSION_CPPFLAGS],
[AC_MSG_NOTICE(placing compiler-dependent CPPFLAGS in $1 - starting ...)
AC_MSG_NOTICE(placing compiler-dependent debug CPPFLAGS in $2 - starting ...)
AC_SUBST($1)
AC_SUBST($2)
AX_COMPILER_VENDOR
AX_COMPILER_VERSION

# The basic starting point.
$1="-DHAVE_WINSOCK2_H=0"
$1+=" -Wdate-time"

# Sparse flags.
if test "$sparse" = true; then
	AC_MSG_CHECKING(for Sparse version)
	sparse_version=m4_esyscmd([ \
		sed --help 1>/dev/null 2>/dev/null \
		&& sparse --version \
			| sed -nre \
			's/^[^0-9]*(([0-9]+\.)*[0-9]+([-+]rc[0-9]*)?).*/\1/p'])
	AC_MSG_RESULT($sparse_version)
	AX_COMPARE_VERSION($sparse_version, ge, "0.4.2")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -Wno-unknown-attribute"
	fi
fi

$2=$$1

$1+=" -D_FORTIFY_SOURCE=2"

AC_MSG_NOTICE(CPPFLAGS to be used are $$1)
AC_MSG_NOTICE(placing compiler-dependent CPPFLAGS in $1 ... done)
AC_MSG_NOTICE(Debug CPPFLAGS to be used are $$2)
AC_MSG_NOTICE(placing compiler-dependent debug CPPFLAGS in $2 ... done)
])


# MG_BUILD_COMPILER_VERSION_CFLAGS(CFLAGS_Variable, CFLAGS_Debug_Variable)
# ------------------------------------------------------------------------
AC_DEFUN([MG_BUILD_COMPILER_VERSION_CFLAGS],
[AC_MSG_NOTICE(placing compiler-dependent CFLAGS in $1 - starting ...)
AC_MSG_NOTICE(placing compiler-dependent debug CFLAGS in $2 - starting ...)
AC_SUBST($1)
AC_SUBST($2)
AX_COMPILER_VENDOR
AX_COMPILER_VERSION

# The following non-vendor and non-version specific inclusions form the common
# baseline for this macro from gcc v5.4 and clang 11.
$1="-g -Wall -Wextra"
$1+=" -fstack-protector-strong"
$1+=" -grecord-gcc-switches"
$1+=" -std=gnu11"
$1+=" -Wbad-function-cast"
$1+=" -Wconversion"
$1+=" -Wdeclaration-after-statement"
$1+=" -Wformat-security"
$1+=" -Wmissing-declarations"
$1+=" -Wmissing-include-dirs"
$1+=" -Wmissing-prototypes"
$1+=" -Wnested-externs"
$1+=" -Woverlength-strings"
$1+=" -Wpointer-arith"
$1+=" -Wredundant-decls"
$1+=" -Wshadow"
# Wstack-protector is probably the way to go but the correct solution to the
# warning requires careful consideration.
# $1+=" -Wstack-protector"
$1+=" -Wstrict-prototypes"
$1+=" -Wswitch-default"
$1+=" -Wwrite-strings"

if [[ $ax_cv_c_compiler_vendor == gnu ]]; then
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "5")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -Wformat-signedness"
		$1+=" -Wlogical-op"
		$1+=" -Wsuggest-attribute=const"
	fi
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "6")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -fasynchronous-unwind-tables"
		$1+=" -Wduplicated-cond"
		$1+=" -Wnull-dereference"
	fi
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "7")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -Wduplicated-branches"
	fi
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "8")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -fstack-clash-protection"
		$1+=" -Wmultistatement-macros"
		$1+=" -Wsuggest-attribute=malloc"
	fi
fi
if [[ $ax_cv_c_compiler_vendor == clang ]]; then
	# The following non-version specific inclusions add to the baseline for
	# this macro from clang v11.0
	$1+=" -fasynchronous-unwind-tables"
	$1+=" -fdiagnostics-format=vi"
	$1+=" -fstack-clash-protection"
	$1+=" -Wnull-dereference"
fi

$2=$$1

# Optimisation
$1+=" -O2"
$2+=" -ggdb3 -O0"

AC_MSG_NOTICE(CFLAGS to be used are $$1)
AC_MSG_NOTICE(placing compiler-dependent CFLAGS in $1 ... done)
AC_MSG_NOTICE(Debug CFLAGS to be used are $$2)
AC_MSG_NOTICE(placing compiler-dependent debug CFLAGS in $2 ... done)
])


# MG_BUILD_COMPILER_VERSION_ANALYZER_CFLAGS(ANALYZER_CFLAGS_Variable)
# -------------------------------------------------------------------
AC_DEFUN([MG_BUILD_COMPILER_VERSION_ANALYZER_CFLAGS],
[AC_MSG_NOTICE(placing analyzer compiler-dependent CFLAGS in $1 - starting ...)
AC_SUBST($1)
AX_COMPILER_VENDOR
AX_COMPILER_VERSION

$1=""
if [[ $ax_cv_c_compiler_vendor == gnu ]]; then
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "10")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1=" -fanalyzer"
	fi
fi
AC_MSG_NOTICE(analyzer CFLAGS to be used are $$1)
AC_MSG_NOTICE(placing analyzer compiler-dependent CFLAGS in $1 ... done)
])

