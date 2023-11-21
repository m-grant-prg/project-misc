#! /usr/bin/env bash
#########################################################################
#									#
# Author: Copyright (C) 2014-2019, 2021-2023  Mark Grant		#
#									#
# This file is maintained in the project at:-				#
#	https://github.com/m-grant-prg/project-misc			#
#		new versions are merely copied to consumer projects.	#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# Macros pertaining to the Java VM.					#
#									#
#########################################################################

#########################################################################
#									#
# Script version	v1.2.0						#
#									#
#########################################################################


# MG_JAVA_VERSION_OK(Required_Java_Version, Start_Dir)
# ----------------------------------------------------
AC_DEFUN([MG_JAVA_VERSION_OK],
[echo -n "checking for java version >= "$1" ... "
if ! java -jar $2/JavaVersionCheckDist/JavaVersionCheck.jar -m $1; then
   	AC_MSG_ERROR([java jre not suitable])
fi])
