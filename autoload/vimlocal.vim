" Copyright 2014-2015 Richard Russon (flatcap)
"
" Run a .vimlocal file in your current directory

let s:vimlocal  = '.vimlocal'
let s:max_depth = 10

function! vimlocal#Load()
	let path = getcwd()
	for i in range (0, s:max_depth)
		let file = path . '/' . s:vimlocal
		if (filereadable (file))
			exec 'source ' . file
		endif
		if (path == '/')
			break
		endif
		let path = fnamemodify (path, ':h')
	endfor
endfunction

