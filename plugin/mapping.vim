" MAPPING {{{
"LEADER KEY (by default is backslash "\")
"let mapleader = "["

"buffers
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
"toggle colortheme
nnoremap <silent> <leader>c :ToggleColor<cr>
"relative line number
nnoremap <silent> <leader>l :ToggleLine<cr>
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
inoremap <expr> <c-d> utilfunc#hudigraphs()
"quit all not save
nnoremap <C-q> :qa!<cr>
"save all & quit
nnoremap <C-s> :xa<cr>

"silver search (disable line substitute)
"<c-r> inserts contain of named register, '=" register expr, <cword> expr of word under cursor
"see :h c_ctrl-r
"use double quote to escape regex character
nnoremap S :Ag<space>"<c-r>=expand("<cword>")<cr>"
"change working directory
nnoremap [cd :cd %:p:h<cr>:pwd<cr>

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

"SEARCHING:
"make matches appear in the middle of screen (add zz)
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <c-]> <c-]>zz
"search on browser
nnoremap <silent> gy :call utilfunc#googlit()<cr>
"manual change cword forwards
"repeat with: <c-[>(goto normal) n(ext match) .(repeat)
nnoremap c* *<c-o>cgn

"SWITCH HEADER:
nnoremap ,s :ToggleCode<cr>

"TABS JUMP:
"tabprevious (gT) and tapnext (gt)
"or ngt for jumping to n.te tab
noremap <C-S><left> :tabp<cr>
noremap <C-S><right> :tabn<cr>
"these interfere shift lines left and right
noremap < :tabp<cr>
noremap > :tabn<cr>
"using (s-)tab and and repeat with dot command to shift instead
vnoremap <tab> >
vnoremap <s-tab> <

"map vertical help
cnoremap vh vert botright help<space>
"map vertical splitfind
cnoremap vf vert sf<space>

"FN:
nnoremap <silent>   <F2> :ToggleTree<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :UpdateCtags<cr>
nnoremap            <F5> :UndotreeToggle<cr>

nnoremap <silent>   <F10> :OnQuit<cr>
imap                <F10> <c-o><F10>                        "if in Insert-Mode switch to Insert-Normal-Mode to execute F10

"DEACTIVATION:
"useless substitutions
"nnoremap s <NOP>
"nnoremap S <NOP>
"backtick as tmux keybind, disable in vim
nnoremap ` <NOP>
"join line
nnoremap J <NOP>
"show manual
nnoremap K <NOP>
"Ex mode
nnoremap Q <NOP>

" cppman
"command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
"autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}
