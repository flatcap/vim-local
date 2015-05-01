# local.vim

## VimLocal runs scripts in local directories

Think of VimLocal as project-wide vim settings.

When run, VimLocal reads the `.vimlocal` file in the same directory as the file
you're editing.  Next it looks in the parent directory, then the grand-parent
directory and so on.  VimLocal stops when it reaches your home directory.

For safety, VimLocal will not run any scripts outside your home directory (as
defined by the environment variable $HOME).

## Running VimLocal

By default, VimLocal will not run.  To enable it, create a mapping or
autocommand. e.g.

    nmap <silent> <F6> <Plug>LoadVimLocal

    autocmd BufNewFile,BufRead * call LoadVimLocal()

## Configuration

VimLocal is configured by global variables:

The filename to read:

	let g:vimlocal_file = '.vimlocal'

The number of directories to descend:

	let g:vimlocal_max_depth = 50

Verbose mode -- show the script name before executing it

	let g:vimlocal_verbose = 0

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-local)

