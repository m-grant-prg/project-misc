#! /usr/bin/env bash
#########################################################################
#									#
# Macro ID: m4extra/linker.m4						#
# Author: Copyright (C) 2021  Mark Grant				#
#									#
# Released under the GPLv3 or later.					#
# SPDX-License-Identifier: GPL-3.0-or-later				#
#									#
# Purpose:								#
# Build a variable containing LDFLAGS.					#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 26/07/2021	MG	1.0.1	Initial release.			#
#									#
#########################################################################


# BUILD_LDFLAGS(LDFLAGS_Variable)
# -------------------------------
AC_DEFUN([BUILD_LDFLAGS],
[AC_MSG_NOTICE(placing LDFLAGS in $1 - starting ...)
AC_SUBST($1)
# The basic starting point.
$1="-Wl,-z,relro"
AC_MSG_NOTICE(LDFLAGS to be used are $$1)
AC_MSG_NOTICE(placing LDFLAGS in $1 ... done)
])

