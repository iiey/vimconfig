"BASIC SETTING {{{

"LANGUAGE INTERFACE
"set language for output :messages
if has('unix')
    language messages C
else
    language messages en
endif

"INTERACTION
set cursorline
set incsearch               "show matching while searching
set ignorecase              "ignore case in search pattern
set hlsearch                "highlight matching search string
set number                  "show line number
set relativenumber          "show relative line number
set mouse=a                 "activate mouse in all modes 'a'/ normal mode 'n'
set scrolloff=3             "screen lines offset above and below cursor
set t_Co=256                "enable term color 256
set laststatus=2            "always show status line
set encoding=utf-8
"use :set list/nolist to show/hide invisiable characters
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•

if v:version > 703
    set formatoptions+=j      "delete comment character when joining commented lines
endif

if !&autoread               "default turn on autoread
    set autoread            "notify changes outside vim and update file
endif                       "note: 'checktime' needs to call for comparing timestamp of buffer

if exists('&belloff')
    set belloff=all           "never ring the bell
endif

if has('clipboard')
    set clipboard=unnamed   "write system clipboard to unnamed register
endif

if has('linebreak')         "show character when long line's wrapped to fit the screen
    let &showbreak='↪ '     "downwards arrow with tip rightwards (U+21B3, UTF-8: E2 86 B3)
endif

"warning: extremely slow by editing large file with fmd syntax
if has('folding')           "folding option
    set foldmethod=syntax   "global folding method
    set foldlevel=3         "fold with higher level with be closed (0: always)
    set foldnestmax=1       "close only outermost fold
endif

if has('vertsplit')
    set splitright            "open vertical splits to the right of the current window
endif

if has('windows')
    set splitbelow            "open horizontal splits below current window
endif

"SYNTAX & FILETYPE
"loading time 20ms(vim74), 35ms(vim80)
if has('syntax') && !exists('g:syntax_on')
    syntax enable           "enable syntax highlighting
endif
"loading time 1ms
filetype plugin indent on   "smartindent based filetype, set cindent for c/c++

"CODING STYLE
set tabstop=4
set softtabstop=4           "using <BS> like <Tab>
set shiftwidth=4
set expandtab
set autoindent              "same indent in newline
set backspace=2             "solve some hw vs system conflict, make it work like other apps. See also :help backspace
"set smartindent             "increase indent in newblock

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
"Open vim with theme instead default
set background=dark
let g:airline_theme='minimalist'
if $KONSOLE_PROFILE_NAME =~? "solarized"
    if $KONSOLE_PROFILE_NAME =~? "light" | set background=light | endif
    "loading time: 6ms
    silent! colorscheme solarized
    let g:airline_theme='solarized'
elseif $KONSOLE_PROFILE_NAME ==? "tomorrow"
    silent! colorscheme tomorrow-night
else
    "loading time: 7ms
    silent! colorscheme codedark
endif

"DIFFING
"note: a colorscheme must set first before request 'g:colors_name'
if &diff && exists('g:colors_name') && g:colors_name != 'solarized'
    highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
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

"THESAURUS
"Add personal synonym files
if !empty(glob("~/.vim/dict"))
    set thesaurus+=~/.vim/dict/thesaurus-vim-en
    set thesaurus+=~/.vim/dict/thesaurus-vim-de
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
"}}}

"MISCELLANEOUS {{{
""Improve tab completion in command mode
""if searching for file, tell vim to look downwards recursive (two asterisks)
""See also help path, file-searching and cpt
"set path +=**

""make vim aware of repo files by adding git root directory to 'path'
""use systemlist() and get first elem without handling newline in result
""like system() but results of shell cmd as list (no trailing newline or space)
"let gitRootDir = get(systemlist("git rev-parse --show-toplevel"), 0)
""check exit_status of last shell cmd
"if v:shell_error == 0 && strlen(gitRootDir) != 0
"    let &path.= gitRootDir . "/**"
"endif

""show candidates in a menu line, iterate with tab and shift-tab
"set wildmenu
""or list all matches with tab (same as ctrl-d)
"set wildmode=longest,list

"Use verticale split when starting termdebug
let g:termdebug_wide = 1
"}}}

"EXUBERANT CTAGS {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current upwards to ~/sources (stop-dir)
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/opencv
"set tags+=$HOME/.vim/tags/qt
" }}}

"MAKE {{{
"loading time 1ms
"identify build-folder by searching "upwards" for "build" from "." to "~/sources"
let projBuildDir = fnamemodify(finddir('build', '.;$HOME/sources'), ':p:h')
if projBuildDir =~ "/build"
    let &makeprg='cmake --build ' . shellescape(projBuildDir) . ' --target '
else
    unlet projBuildDir
endif
"Note: Using "-- -jN" to pass jobs config to make command
"Note: above is just a personal case which comes into handy, consider remove it later
"use SetBuildDir command to manual set a cmake project build directory
"}}}
