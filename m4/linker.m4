#! /usr/bin/env bash
#########################################################################
#									#
# Macro ID: m4extra/linker.m4						#
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
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 26/07/2021	MG	1.0.1	Initial release.			#
# 21/11/2021	MG	1.0.2	Tighten SPDX tag.			#
# 06/06/2022	MG	1.1.1	Add MG_ namespace.			#
# 22/02/2023	MG	1.1.2	Add a comment that this file is		#
#				maintained in another project.		#
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

