#!/usr/bin/env bash

set -eo pipefail

codename=$(lsb_release -c | grep 'Codename' | sed 's/Codename\:[[:space:]]*//g')
dpkg-buildflags --dump | sed 's:\-ffile\-prefix\-map\='$(pwd)'\=\.::g' \
	> dpkg-buildflags-$codename.txt

