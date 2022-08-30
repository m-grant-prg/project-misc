#! /usr/bin/env bash
#########################################################################
#									#
# Macro ID: m4extra/c-compiler.m4					#
# Author: Copyright (C) 2019, 2021, 2022  Mark Grant			#
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
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 10/02/2019	MG	1.0.1	Initial release. Checked up to gcc v8.2	#
# 02/03/2019	MG	1.0.2	Change file name to c-compiler.m4	#
# 05/05/2019	MG	1.0.3	Remove manual specification of implicit	#
#				fallthrough from v7 as it is included	#
#				in Wextra.				#
#				Establish baseline warnings as of	#
#				gcc v6.3				#
#				Checked up to v9.1			#
# 16/06/2019	MG	1.0.4	Backported to gcc v5 to facilitate use	#
#				with xenial build VMs on Travis CI.	#
# 24/07/2021	MG	1.0.5	Add Wformat-security			#
#				Add fasynchronous-unwind-tables		#
#				Add -fstack-clash-protection		#
#				Checked up to v11.1			#
# 25/07/2021	MG	1.0.6	Add g to always provide some debug	#
#				information.				#
#				Add grecord-gcc-switches		#
# 26/07/2021	MG	1.0.7	Add function for preprocessor flags.	#
# 28/09/2021	MG	1.0.8	Specify gcc starting point -std=gnu11	#
#				to satisfy sparse, but this allows	#
#				mixed declarations and code, so		#
#				re-introduce that warning.		#
# 14/10/2021	MG	1.0.9	Specify macro HAVE_WINSOCK2_H as false.	#
# 05/11/2021	MG	1.0.10	Create debug versions of flags.		#
# 21/11/2021	MG	1.0.11	Tighten SPDX tag.			#
# 06/06/2022	MG	1.1.1	Add gcc analyzer CFLAGS.		#
#				Create new namespace MG_.		#
#				Checked up to v12.1			#
# 22/08/2022	MG	1.2.1	Add support for clang from v11.0	#
# 30/08/2022	MG	1.2.2	Refactor to a common gcc clang baseline.#
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
$1+=" -Wmissing-include-dirs"
$1+=" -Wmissing-prototypes"
$1+=" -Wredundant-decls"
$1+=" -Wshadow"
$1+=" -Wstrict-prototypes"

if [[ $ax_cv_c_compiler_vendor == gnu ]]; then
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "6")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -fasynchronous-unwind-tables"
		$1+=" -Wduplicated-cond -Wnull-dereference"
	fi
	AX_COMPARE_VERSION($ax_cv_c_compiler_version, ge, "8")
	if [[ x${ax_compare_version} == xtrue ]]; then
		$1+=" -fstack-clash-protection"
		$1+=" -Wmultistatement-macros"
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

