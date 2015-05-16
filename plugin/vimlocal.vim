" local.vim - Run local vim scripts
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_vimlocal') || &cp || (v:version < 700))
	finish
endif
let g:loaded_vimlocal = 1

" Set default values
if (!exists ('g:vimlocal_file'))      | let g:vimlocal_file      = '.vimlocal' | endif
if (!exists ('g:vimlocal_max_depth')) | let g:vimlocal_max_depth = 50          | endif
if (!exists ('g:vimlocal_verbose'))   | let g:vimlocal_verbose   = 0           | endif

let s:home_dir = expand ('~')

function! LoadVimLocal()
	" Ignore scratch files, help pages and quickfix windows
	if ((&l:bt == 'nofile') || (&l:bt == 'help') || (&l:bt == 'quickfix'))
		return
	endif

	" Ignore our script files for safety
	let l:file = expand ('%:t')
	if (l:file == g:vimlocal_file)
		return
	endif

	" Full path of the current file
	let l:path = expand ('%:p:h')

	" Is is within the user's home?
	if (l:path !~# '^' . s:home_dir)
		return
	endif

	for l:i in range (0, g:vimlocal_max_depth)
		let l:file = l:path . '/' . g:vimlocal_file
		if (filereadable (l:file))
			let l:cmd = 'source ' . fnameescape (l:file)
			if (g:vimlocal_verbose)
				echom l:cmd
			endif
			exec l:cmd
		endif

		" Stop at the user's home, or root directory
		if ((l:path == s:home_dir) || (l:path == '/'))
			break
		endif

		" Trim the last directory from the path
		let l:path = fnamemodify (l:path, ':h')
	endfor
endfunction


nnoremap <silent> <Plug>LoadVimLocal :call LoadVimLocal()<CR>

" vim:set noet ts=8 sw=8:
