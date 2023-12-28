"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"									"
" Author: Copyright (C) 2021-2023  Mark Grant				"
"									"
" This file is maintained in the project at:-				"
"	https://github.com/m-grant-prg/project-misc			"
"		new versions are merely copied to consumer projects.	"
"									"
" Released under the GPLv3 only.					"
" SPDX-License-Identifier: GPL-3.0					"
"									"
" Purpose:								"
" This file works in conjunction with the vim-localrc plugin.		"
" The file should be placed in the project root directory, i.e. where	"
" the .git directory exists. The plugin then, for any file edited in	"
" that project tree, will look higher in the directory hierarchy until	"
" this file is found, and then it will be processed.			"
"									"
" Defaults And Examples:						"
" Whitespace settings. Values below are the vim defaults.		"
" setlocal tabstop=8		Tab width is set to 8. It is still a \t	"
" setlocal shiftwidth=8		Indents will have a width of 8		"
" setlocal softtabstop=0	Switch off mix tabs and spaces to value	"
" setlocal noexpandtab		Do not expand tabs to spaces.		"
" Changes to these values may best be done by FileType. Example below.	"
" autocmd FileType python setlocal ts=4 sts=0 sw=4 et			"
"									"
" Project Targets:							"
" My C projects. (Covers bash, AutoTools files etc.. in the project).	"
"									"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"									"
" Version	v1.0.5							"
"									"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Setup clang-format.
" -------------------
" The script is installed in different places on different distros
let $clang_format_py_location = "/usr/share/vim/addons/syntax/clang-format.py"
if filereadable("/usr/share/clang/clang-format.py")
	let $clang_format_py_location = "/usr/share/clang/clang-format.py"
endif
" Current line / Visual block.
imap <C-K> :py3f $clang_format_py_location<cr>
nmap <C-K> :py3f $clang_format_py_location<cr>
vmap <C-K> :py3f $clang_format_py_location<cr>
" Current block.
nmap <C-K><C-K> [{V]}:py3f $clang_format_py_location<cr>''
" Entire buffer
nmap <C-K><C-K><C-K> ggVG:py3f $clang_format_py_location<cr>''

