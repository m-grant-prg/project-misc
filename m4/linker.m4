#! /usr/bin/env bash
#########################################################################
#									#
# Author: Copyright (C) 2021-2023  Mark Grant				#
#									#
# This file is maintained in the project at:-				#
#	https://github.com/m-grant-prg/project-misc			#
#		new versions are merely copied to consumer projects.	#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# Build a variable containing LDFLAGS.					#
#									#
#########################################################################

#########################################################################
#									#
# Script version	v1.2.0						#
#									#
#########################################################################


# MG_BUILD_LDFLAGS(LDFLAGS_Variable)
# ----------------------------------
AC_DEFUN([MG_BUILD_LDFLAGS],
[AC_MSG_NOTICE(placing LDFLAGS in $1 - starting ...)
AC_SUBST($1)
# The basic starting point.
$1="-Wl,-z,relro"
AC_MSG_NOTICE(LDFLAGS to be used are $$1)
AC_MSG_NOTICE(placing LDFLAGS in $1 ... done)
])

