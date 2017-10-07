set nocompatible " be iMproved, required
set number " enable line numbers
set ruler " turn on the ruler
set softtabstop=0 noexpandtab
set shiftwidth=4
set laststatus=2 " always display the statusline in all windows
set showtabline=2 " always display the tabline
syntax on " syntax highlighting

" set the runtime path to include for plug
call plug#begin('~/.vim/plugged') " note: pkgbuild for powerline fonts

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/indentLine'

call plug#end()     

" airline
let g:airline_powerline_fonts = 1
let g:powerline_pycmd = 'py3'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" airline, unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" airline, symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" powerline
let g:Powerline_symbols = 'fancy'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers = ['w3']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': [] }

" remaps
nnoremap ,c  :SyntasticCheck<CR>
nnoremap ,t  :SyntasticToggleMode<CR>
nnoremap ,r  :SyntasticReset<CR>
