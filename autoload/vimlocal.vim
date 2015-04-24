" Copyright 2014-2015 Richard Russon (flatcap)
"
" Run a .vimlocal file in your current directory

let g:vimlocal      = '.vimlocal'
let g:max_depth     = 50
let g:stop_at_home  = 1
let g:home_dir_only = 1

let s:home_dir      = expand ('~')

function! vimlocal#Load()
	let path = getcwd()

	if ((g:home_dir_only == 1) && (path !~ '^' . s:home_dir))
		" echohl error
		" echom 'not at home'
		" echohl none
		return
	endif

	for i in range (0, g:max_depth)
		let file = path . '/' . g:vimlocal
		if (filereadable (file))
			" echohl cursorline
			" echom file
			" echohl none
			exec 'source ' . fnameescape (file)
		else
			" echohl error
			" echom path
			" echohl none
		endif

		if ((path == s:home_dir) && (g:stop_at_home == 1))
			break
		endif
		if (path == '/')
			break
		endif
		let path = fnamemodify (path, ':h')
	endfor
endfunction

