syntax on " set syntax highlighting to on
set nocompatible " not vi compatible
set number " set line numbers to on
set ruler " set display cursor position to on
" configure tab settings
set expandtab " expand tab to spaces
set shiftwidth=4 " set indent width to four
set softtabstop=4 " set backspace to delete four spaces
set tabstop=4 " set tab width to four
set showtabline=2 " set display tabline to always

" plug, set the runtime path to include
call plug#begin('~/.vim/plugged') " note: pkgbuild for powerline fonts
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-powerline'
Plug 'Yggdroot/indentLine'
Plug 'neomake/neomake'
Plug 'romainl/vim-qf'
Plug 'airblade/vim-gitgutter'
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
" airline, powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" powerline
let g:Powerline_symbols = 'fancy'

" :help neomake
call neomake#configure#automake('rw', 750)
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_cpp_enabled_makers = ['g++']
let g:neomake_css_enabled_makers = ['csslint'] " npm install csslint
let g:neomake_html_enabled_makers = ['html-angular-validate'] " npm install html-angular-validate
let g:neomake_java_enabled_makers = ['javac']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_lua_enabled_makers = ['luac']
let g:neomake_python_flake8_maker = {'args': ['--format=default'],
    \'errorformat': '%E%f:%l: could not compile,%-Z%p^,%A%f:%l:%c: %t%n %m,%A%f:%l: %t%n %m,%-G%.%#',}
let g:neomake_python_flake8_exe = '/usr/bin/flake8-python2'
let g:neomake_python_enabled_makers = ['flake8'] " pacman -S flake8
let g:neomake_scss_enabled_makers = ['scss_lint']
let g:neomake_sh_enabled_makers = ['shellcheck'] " pacman -S shellcheck
let g:neomake_yaml_enabled_makers = ['yamllint'] " AUR yamllint
let g:neomake_place_signs = 0
let g:neomake_highlight_columns = 0 "help neomake-highlight
let g:neomake_highlight_lines = 0
let g:neomake_open_list = 0

" :help colorscheme
colorscheme PerfectDark

" :help gitgutter
let g:gitgutter_sign_added = 'a'
let g:gitgutter_sign_modified = 'm'
let g:gitgutter_sign_removed = 'r'
let g:gitgutter_sign_removed_first_line = 'r'
let g:gitgutter_sign_modified_removed = 'mr'
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 1
highlight link GitGutterAddLine DiffAdd
highlight link GitGutterChangeLine DiffAdd
highlight link GitGutterDeleteLine DiffAdd
highlight link GitGutterChangeDeleteLine background

" map key(s) to command
nnoremap ,o :lopen<CR>
nnoremap ,c :lclose<CR>
nnoremap ,x :call system('xclip', @0) <CR>
