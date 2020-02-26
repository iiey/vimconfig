" MAPPING {{{
"LEADER KEY (by default is backslash "\")
"let mapleader = "["

"buffers
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
"relative line number
nnoremap <silent> <leader>l :call utilfunc#toggleline()<cr>
"toggle highlight cursor
nnoremap <silent> <leader>h :set cursorline!<cr>
"find used keyword under cursor & ignore default [i
nnoremap <silent> <leader>i [I:let nr = input("Enter item: ")<bar>if nr != ''<bar>exe "normal " . nr ."[\t"<bar>endif<cr>
"marks
nnoremap <silent> <leader>m :marks<bar>:let nr = input("Enter mark: ")<bar>if nr != ''<bar>exe "\'" . nr<bar>endif<cr>
"turn off highlighting searched pattern
nnoremap <silent> <leader>s :nohlsearch<cr>
"refresh vimrc
nnoremap <silent> <leader>r :if &mod <bar>:write<bar>endif<bar>:source $MYVIMRC<bar>:redraw<bar>:echo ".vimrc reloaded!"<cr>
"change tab
nnoremap <silent> <leader>t :tabs<cr>:let nr = input("Enter tab: ")<bar>if nr!= ''<bar>exe "normal" . nr . "gt"<bar>endif<cr>

"enter Ex command
nnoremap ; :
"replacement for next match with focus f
nnoremap <space> ;

"QUICKFIX:
nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(8)<cr>
nnoremap <C-n> :cnext<cr>zz
nnoremap <C-p> :cprevious<cr>zz

"Head up diagraph
"usage: c-k twice in insert-mode get digraph table, scroll to the end
"enter to quit, type two chars which presents the symbol
inoremap <expr> <c-k><c-k> utilfunc#hudigraphs()
"quit all not save
nnoremap <C-q> :qa!<cr>
"save all
nnoremap <C-s> :wa<cr>

"WINDOW:
"s for split and disable word substitude
noremap s <c-w>
"simulate tmux key-z
"not overwrite behaviour of ctrl-w_z, resize back ctrl-w_=
noremap sz :wincmd _<bar>wincmd \|<cr>
"win-resize vertical
nnoremap s, 5<c-w><
nnoremap s. 5<c-w>>
"win-resize horizontal
nnoremap s0 5<c-w>+
nnoremap s- 5<c-w>-

"MOVEMENT:
"increase steps of basic moves
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
"this is convenient and more comfortable
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

"MOVEMENT IN INSER-MODE:
"override default i_ctrl-a and i_ctrl-e
inoremap <c-a> <home>
inoremap <c-e> <end>
"don't need funtion i_ctrl-b and i_ctrl-f
inoremap <c-b> <left>
inoremap <c-f> <right>

"SEARCHING:
"make matches appear in the middle of screen (add zz)
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g; g;zz
nnoremap g, g,zz
"append zz to '<char> when jumping to mark triggered
nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
"search on browser
nnoremap <silent> [b :call utilfunc#search()<cr>
"search with git grep
"<c-r> inserts contain of named register, '=" register expr, <cword> expr of word under cursor. See :h c_ctrl-r
"use double quote to escape regex character
nnoremap [g :GGrep<space><c-r>=expand("<cword>")<cr>
nnoremap [G :GGrep<space><c-r>=expand("<cword>")<cr><cr>
"search with ripgrep
nnoremap [r :Rg!<space><c-r>=expand("<cword>")<cr><cr>
nnoremap [R :Rg<space><c-r>=expand("<cword>")<cr><cr>
"search with fuzzy finder
nnoremap [f :Files<cr>
nnoremap [w :Windows<cr>
"change working directory
" %:p current filename, %:p:h truncate name -> current dir
nnoremap [cd :cd %:p:h<cr>:pwd<cr>

"SWITCH HEADER:
"sourcecode-toggle
nnoremap [v :ToggleCode vsplit<cr>
nnoremap [t :ToggleCode tab drop<cr>

"TAG JUMP:
"get desired behaviour with simpler keystroke
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
"swap tjump g_ctrl-] with above commands
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

"manual change cword forwards
"repeat with: <c-[>(goto normal) n(ext match) .(repeat)
nnoremap c* *<c-o>cgn

"COMMANDLINE MODE:
"map vertical help
cnoremap vh vert botright help<space>
"map vertical splitfind
cnoremap vf vert sf<space>
"recall cmd-line history
cnoremap <c-p> <up>
cnoremap <c-n> <down>

"FN:
nnoremap <silent>   <F2> :call utilfunc#toggletree()<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :call utilfunc#updatectags(g:projRootDir)<cr>  "see bundle.vim#CTAGS

nnoremap <silent>   <F10> :call utilfunc#onquit()<cr>
imap                <F10> <c-o><F10>                            "switch to Insert-Normal-Mode to exec F10

"DEACTIVATION:
"useless substitutions
"nnoremap s <NOP>
"nnoremap S <NOP>
"backtick as tmux keybind, disable in vim
nnoremap ` <NOP>
"join line
"nnoremap J <NOP>
"show manual
nnoremap K <NOP>
"Ex mode
nnoremap Q <NOP>
" }}}
