" Copyright 2014-2015 Richard Russon (flatcap)
"
" Run a .vimlocal file in your current directory or its parents.

if (exists('g:loaded_vimlocal') || &cp || (v:version < 700))
	finish
endif
let g:loaded_vimlocal = 1

" Set default values
if (!exists('g:vimlocal_file'))      | let g:vimlocal_file      = '.vimlocal' | endif
if (!exists('g:vimlocal_max_depth')) | let g:vimlocal_max_depth = 50          | endif
if (!exists('g:vimlocal_verbose'))   | let g:vimlocal_verbose   = 0           | endif

let s:home_dir = expand ('~')

function! g:LoadVimLocal()
	" Ignore scratch files, help pages, quickfix windows
	if ((&bt == 'nofile') || (&bt == 'help') || (&bt == 'quickfix'))
		return
	endif

	" Ignore our script files for safety
	let file = expand('%:t')
	if (file == g:vimlocal_file)
		return
	endif

	" Full path of the current file
	let path = expand('%:p:h')

	" Is is within the user's home?
	if (path !~ '^' . s:home_dir)
		return
	endif

	for i in range (0, g:vimlocal_max_depth)
		let file = path . '/' . g:vimlocal_file
		if (filereadable (file))
			let cmd = 'source ' . fnameescape (file)
			if (g:vimlocal_verbose)
				echom cmd
			endif
			exec cmd
		endif

		" Stop at the home directory, or root
		if ((path == s:home_dir) || (path == '/'))
			break
		endif

		" Trim the last directory from the path
		let path = fnamemodify (path, ':h')
	endfor
endfunction

nnoremap <silent> <Plug>LoadVimLocal :call LoadVimLocal()<CR>

