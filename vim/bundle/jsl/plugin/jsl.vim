" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    jsl.vim                                            :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mgalliou <mgalliou@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2018/09/27 10:46:54 by mgalliou          #+#    #+#              "
"    Updated: 2018/09/27 10:47:51 by mgalliou         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

set laststatus=2
set ruler

let g:currentmode=
			\{
			\'n'  : 'Normal',
			\'no' : 'N-Operator Pending',
			\'v'  : 'Visual',
			\'V'  : 'V-Line',
			\'' : 'V-Block',
			\'s'  : 'Select',
			\'S'  : 'S-Line',
			\'' : 'S-Block',
			\'i'  : 'Insert',
			\'R'  : 'Replace',
			\'Rv' : 'V-Replace',
			\'c'  : 'Command',
			\'cv' : 'Vim Ex',
			\'ce' : 'Ex',
			\'r'  : 'Prompt',
			\'rm' : 'More',
			\'r?' : 'Confirm',
			\'!'  : 'Shell',
			\}

function! SetStatusLine(cur)
	"if !(exists("b:NERDTree") && b:NERDTree.isTabTree())
	setl statusline=
	setl statusline+=%(%1*%3{&filetype!='help'?bufnr('%'):''}\ %) "buffer nb
	if (a:cur)
		setl statusline+=%0*\  "separator
		setl statusline+=%(%4*\ %{toupper(g:currentmode[mode()])}\ %) "mode
	endif
	setl statusline+=%0*\  "separator
	setl statusline+=%(%2*\ %f\ %) "filepath
	setl statusline+=%<
	setl statusline+=%0*\  "separator
	setl statusline+=%(%3*%{&modified?'\ +\ ':''}%2*%) "modif indicator
	setl statusline+=%{&readonly?'\ #\ ':''} "read-only indicator
	setl statusline+=%(%h\ %) "help indicator
	setl statusline+=%0*%=
	setl statusline+=%(%2*\ %p\ %%\ %)
	setl statusline+=%0*\  "separator
	setl statusline+=%(%2*\ %{''!=#&filetype?&filetype:'none'}\ %)
	setl statusline+=%0*\  "separator
	"endif
endfunction

highlight link User1 PmenuSel
highlight link User2 PmenuSbar
highlight link User3 DiffDelete
highlight link User4 DiffChange

if version >= 700
	autocmd InsertLeave * highlight link User4 DiffChange
	autocmd InsertEnter * highlight link User4 DiffAdd
	autocmd VimEnter,WinEnter,BufEnter * call SetStatusLine(1)
	autocmd WinLeave * call SetStatusLine(0)
endif
