"BASIC SETTING {{{
"Folding option for this file
setlocal foldmethod=marker  "use marker curved bracket for folding
setlocal foldlevel=2        "over level 1 will be closed

"LANGUAGE INTERFACE
"set language for output :messages
if has('unix')
    language messages C
else
    language messages en
endif

"INTERACTION
set cursorline
set incsearch       "show matching while searching
set ignorecase      "ignore case in search pattern
set hlsearch        "highlight matching search string
set number          "show line number
set relativenumber  "show relative line number
set mouse=a         "activate mouse in all modes 'a'/ normal mode 'n'
set scrolloff=3     "screen lines offset above and below cursor
"set ttymouse=xterm2 "xterm-like mouse handling (support drag to resize split windows)
set t_Co=256        "enable term color 256
set laststatus=2    "always show status line
set encoding=utf-8
"loading time 20ms
syntax on                               "enable syntax highlighting
filetype on                             "enable filetype detecting
filetype plugin indent on               "smartindent based filetype, set cindent for c/c++

"CODING STYLE
set tabstop=4
set softtabstop=4           "using <BS> like <Tab>
set shiftwidth=4
set expandtab
set autoindent              "same indent in newline
set backspace=2             "solve some hw vs system conflict, make it work like other apps. See also :help backspace
"set smartindent             "increase indent in newblock

"DIFFING
if &diff && g:colors_name != 'solarized'
    highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endif

"SESSION
"prevent annoying if vimrc changed after session saved
set ssop-=options    " do not store global and local values in a session

"file format linux
"set ff=unix
"set autochdir // auto. change current working directory
" }}}


"TMUX - Handle some issues {{{
"FIX ARROWS
"vim not recognize arrow characters
"vim handles keywords correctly if it 'TERM=xterm-...' but tmux using screen-256color
if &term =~? '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    "need to be set in tmux.conf: set-window-option -g xterm-keys on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
"TODO Alt not work, not tmux but general problem of terminals by redirect
"keystroke to vim
"}}}


" COLORSCHEME {{{
set background=dark
if $KONSOLE_PROFILE_NAME ==? "solarized"
    silent! colorscheme solarized
    let g:airline_theme='solarized'
else
    silent! colorscheme codedark
    let g:quantum_black=1
    let g:airline_theme='codedark'
endif
"}}}


"COMPLETION (builtin) {{{
"DICTIONARY
"Add default file if on FreeBSD
if filereadable("/usr/share/dict/words")
    set dictionary+=/usr/share/dict/words
    "Enable completion from defined dictionary
    set complete+=k                     "<c-x><c-k> to trigger this list
endif

"OMNI COMPLETION
set omnifunc=syntaxcomplete#Complete    "open in I-Mode <c-x><c-o>, navigate <c-n/p>, close <c-e>

"Custom behaviour of completion menu
"longest: don't select first macht but the longest common text of all matches
"menuone: menu will come up even if there's one match
set completeopt=longest,menuone

"improve c-n: keep popup menu on while typing to narrow the matches
"pumvisible: return non-zero if PopUpMenu visible otherwise false
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"COMMAND-LINE
"Improve tab completion in command mode
"if searching for file, tell vim to look downwards recursive (two asterisks)
"See also help path, file-searching and cpt
"set path +=**
"show candidates in a menu line, iterate with tab and shift-tab
"set wildmenu
"or list all matches with tab (same as ctrl-d)
"set wildmode=longest,list
"}}}


"EXUBERANT CTAGS {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current upwards to ~/sources (stop-dir)
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/opencv
"set tags+=$HOME/.vim/tags/qt
" }}}


"MAKE {{{
"identify build-folder by searching "upwards" for "build" from "." to "~/sources"
let projBuildDir = finddir('build', '.;$HOME/sources')
if projBuildDir !=""
    let &makeprg='cmake --build ' . shellescape(projBuildDir) . ' --target '
endif
"Note: Using "-- -jN" to pass jobs config to make command
"}}}
