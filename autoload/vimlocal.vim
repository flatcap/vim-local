" Copyright 2014-2015 Richard Russon (flatcap)
"
" Run a .vimlocal file in your current directory or its parents.

if (exists('g:loaded_vimlocal') || &cp || (v:version < 700))
	finish
endif
let g:loaded_vimlocal = 1

" Set default values
let g:vimlocal_file      = exists('g:vimlocal_file')      ? g:vimlocal_file      : '.vimlocal'
let g:vimlocal_max_depth = exists('g:vimlocal_max_depth') ? g:vimlocal_max_depth : 50
let g:vimlocal_verbose   = exists('g:vimlocal_verbose')   ? g:vimlocal_verbose   : 0

let s:home_dir = expand ('~')

function! vimlocal#Load()
	let path = getcwd()

	" Not at home
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

