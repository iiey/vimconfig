"Define commands which functions are implemented in autoload/utilfunc.vim

"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available
"Note plugins are not run, we cannot check if exists(':AsyncRun')
":Make runs :make in background with asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
":Ag runs :grep in background with asyncrun
command! -bang -nargs=* -complete=file Ag AsyncRun -program=grep @ <args>

"FIXME search pattern with double quotes not work, :h <args>
if !exists(':Ag') && (executable('ag') || executable('rg'))
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
"}}}

"CPPMAN {{{
"manual page viewer
"note: using "$cppman -m true" to call cppman from default man
"it's handy if vim-man is installed
if executable('tmux') && executable('cppman')
    command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
    command! -nargs=+ CppMan silent! call system("tmux split-window -h cppman " . expand(<q-args>))

"    autocmd FileType cpp nnoremap <silent><buffer> <leader>k <Esc>:Cppman <cword><CR>
"    autocmd FileType cpp nnoremap <silent><buffer> <leader>K <Esc>:CppMan <cword><CR>
endif
"}}}

"FZF.VIM {{{
"Files command with preview window
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
"}}}

" COMMANDS DEFINITION {{{
command! OnQuit         call utilfunc#onquit()
command! UpdateCtags    call utilfunc#updatectags($proj)
command! ToggleCode     call utilfunc#togglecode()
command! ToggleColor    call utilfunc#togglecolor()
command! ToggleLine     call utilfunc#toggleline()
command! ToggleTree     call utilfunc#toggletree()
command! -nargs=* -complete=color ChangeTheme call utilfunc#changetheme('<args>')
command! -nargs=* Search call utilfunc#search('<args>')
"}}}


" AUTOCMD {{{
augroup vimplug
    "prevent calling multiple times by sourcing
    autocmd!
    "download new coming plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                        \| PlugInstall --sync | q | endif
augroup END

augroup vimrc
    autocmd!
    "update tags on saving
    "autocmd BufWritePost *.cpp,*.h,*.c silent! call UpdateCtags(projRootDir)
    "change directory of current local window
    "autocmd bufenter * silent! lcd %:p:h

    "TODO write function in case more than one left behind windows of these kinds
    "close vim if one left behind window is nerdtree, quickfix or help
"    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'quickfix') | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'help') | q | endif

    "open when asyncrun starts
    autocmd User AsyncRunStart if exists(':AsyncRun') | call asyncrun#quickfix_toggle(8, 1)
    "and close on success
    autocmd User AsyncRunStop if exists(':AsyncRun') | call utilfunc#async_onexit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif

    "FIXME set specific folding for vim files
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python setlocal foldmethod=indent
    "Do not fold small file
    "autocmd FileType c,cpp,vim if line('$') < 500 | normal zR | endif

    "FIXME autoread for vim terminal
    "using this event to update file silently but not trigger too often
    "autocmd CursorHold * checktime
augroup END
"}}}
