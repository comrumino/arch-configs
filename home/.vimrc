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
set updatetime=100 " set updatetime to 100 ms instead of default 4 seconds to improve gutter load
set signcolumn=yes
set backspace=indent,eol,start
" configure fold settings
" set foldmethod=indent
" set foldlevelstart=10
" set foldcolumn=2
" set mouse=a

" Dependencies (Arch Linux)
"  vim-plug
"   git clone https://aur.archlinux.org/vim-plug.git
"  powerline-fonts
"   git clone https://aur.archlinux.org/powerline-fonts-git.git
"   fc-cache -frv && xset fp rehash
"
"  instant-rst
"   git clone https://aur.archlinux.org/instant-rst.git
"  markdown-preview
"   git clone https://aur.archlinux.org/python-path-and-address-git.git
"   git clone https://aur.archlinux.org/python-grip-git.git
"  wordy and lexical:
"   extra/aspell-en
"
" Dependencies (macOS)
"  vim-plug
"   see https://github.com/junegunn/vim-plug
"  powerline-fonts
"   see https://github.com/powerline/fonts
"  instant-rst
"   pip install git+https://github.com/gu-fan/instant-rst.py.git
"  markdown-preview
"   pip install git+https://github.com/joeyespo/path-and-address.git
"   pip install git+https://github.com/joeyespo/grip.git
"  wordy and lexical:
"   brew install aspell
"
" plug, set the runtime path to include
call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'neomake/neomake'
Plug 'romainl/vim-qf'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'comrumino/vim-markdown-preview'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'gu-fan/InstantRst'
Plug 'gu-fan/riv.vim'
Plug 'hashivim/vim-terraform'
call plug#end() 

" airline
let g:airline_powerline_fonts = 1
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
call neomake#configure#automake('rw', 100)
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-Wall', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion'],
   \ }
let g:neomake_css_enabled_makers = ['csslint'] " npm install csslint
let g:neomake_html_enabled_makers = ['html-angular-validate'] " npm install html-angular-validate
let g:neomake_java_javac_args = ['-cp', '.']
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_lua_enabled_makers = ['luac']
let g:neomake_python_enabled_makers = ['flake8'] " pacman -S flake8
let g:neomake_python_flake8_maker = {'args': ['--format=default'],
    \'errorformat': '%E%f:%l: could not compile,%-Z%p^,%A%f:%l:%c: %t%n %m,%A%f:%l: %t%n %m,%-G%.%#',}
let g:neomake_scss_enabled_makers = ['scss_lint']
let g:neomake_sh_enabled_makers = ['shellcheck'] " pacman -S shellcheck
let g:neomake_yaml_enabled_makers = ['yamllint'] " AUR yamllint
let g:neomake_place_signs = 0
let g:neomake_highlight_columns = 0 "help neomake-highlight
let g:neomake_highlight_lines = 0
let g:neomake_open_list = 0

" :help colorscheme
colorscheme PerfectDark
"highlight GitGutterAdd    guifg=#009900 ctermfg=green
"highlight GitGutterChange guifg=#bbbb00 ctermfg=green
"highlight GitGutterChangeDelete guifg=#ff2222 ctermfg=red
"highlight GitGutterDelete guifg=#ff2222 ctermfg=red


" :help gitgutter
let g:gitgutter_signs = 1
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_sign_added = ' +'
let g:gitgutter_sign_modified = ' 𝚫'
let g:gitgutter_sign_removed = ' −'
let g:gitgutter_sign_removed_first_line = '^−'
let g:gitgutter_sign_modified_removed = ' 𝚫'
let g:gitgutter_set_sign_backgrounds = 1


" markdown-preview
let vim_markdown_preview_github = 1
let vim_markdown_preview_use_xdg_open = 1
let vim_markdown_preview_browser = 'chromium'


" wordy and lexical
let g:lexical#spell = 0
let g:lexical#spelllang = ['en_us']
let g:lexical#dictionary = ['/usr/lib/aspell/',]

function! LexicalToggle(...) abort
    let g:lexical#spell = g:lexical#spell ? 0 : 1
    if g:lexical#spell
        :call call (function('lexical#init'), [{ 'spell': 1 }])
    else
        :call call (function('lexical#init'), [{ 'spell': 0 }])
    endif
endfunction

" open/close spit window for terminal
let s:termbufnr = 0
function! TermToggle(...) abort
    if s:termbufnr && !bufexists(s:termbufnr)
        let s:termbufnr = 0
    endif
    if !s:termbufnr
        let s:termbufnr = term_start($SHELL, {"term_kill": "kill"})
    else
        :exe "bd!" . s:termbufnr
        let s:termbufnr = 0
    endif
endfunction

let s:unitbufnr = 0
function! UnitTest(...) abort
    if s:unitbufnr && !bufexists(s:unitbufnr)
        let s:unitbufnr = 0
    endif
    if !s:unitbufnr
        let l:abspath = expand('%:p')
        let l:relpath = expand('%:p:h')  " dir of file beinging edited
        let l:class = "cpp-coursework"
        if abspath =~ ".*" . class . ".*"
            " c++ preferences
            let l:cmakedir = substitute(abspath, '\(/.*' . class . '/\)\(.*\)', '\1', '')
            let l:cmakelists = cmakedir . "CMakeLists.txt"
            let l:cmake_o = system('cd ' . cmakedir . ' && RELPATH=' . relpath . ' /usr/bin/cmake ' . cmakelists . ' && make && ./CPROGRM')
            new
            setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
            let s:unitbufnr = bufnr("%")
            silent put=cmake_o
            :exe "map <buffer> <ESC> :call UnitTest()<Esc>"
        endif
    else
        exec "nnoremap " . s:unitbufnr . "<ESC> <ESC>"
        :exe "bd " . s:unitbufnr . ""
        let s:unitbufnr = 0
    endif
endfunction

let s:quickbufnr = 0
function! QuickfixToggle(...) abort
    if s:quickbufnr && !bufexists(s:quickbufnr)
        let s:quickbufnr = 0
    endif
    if !s:quickbufnr && len(getloclist(0))
        :lopen
        let s:quickbufnr = bufnr("%")
        exec "map <buffer> <ESC> :call QuickfixToggle()<Esc>"
    elseif s:quickbufnr
        exec "nnoremap " . s:quickbufnr . "<ESC> <ESC>"
        :exe "bd " . s:quickbufnr . ""
        let s:quickbufnr = 0
    endif
endfunction

" map key(s) to command
let mapleader=","
nnoremap <leader>o :call QuickfixToggle()<CR>
nnoremap <leader>m :call Vim_Markdown_Preview()<CR>
nnoremap <leader>x :call system('pbcopy', @0)<CR>
nnoremap <leader>s :call LexicalToggle()<CR>
nnoremap <leader>a :AnsiEsc<CR>
nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader>t :call UnitTest()<Esc>
nnoremap <leader>u :call TermToggle()<Esc>
tnoremap <ESC> <C-w>:call TermToggle()<Esc>
au BufNewFile,BufRead *{,.log,.err,.info,.warn,.crit,.notice}{,.[0-9]*,-[0-9]*} setf messages
