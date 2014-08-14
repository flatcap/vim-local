" Copyright 2014 Richard Russon (flatcap)
"
" Run a .vimlocal file in your current directory

let s:vimlocal = '.vimlocal'

function! vimlocal#Load()
	if (!filereadable (s:vimlocal))
		return
	endif

	exec "source ".s:vimlocal
endfunction

