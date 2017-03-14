"Define commands which functions are implemented in autoload/utilfunc.vim

"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available
"Note plugins are not run, we cannot check if exists(':AsyncRun')
":Make runs :make in background with asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
":Ag runs :grep in background with asyncrun
command! -bang -nargs=* -complete=file Ag AsyncRun -program=grep @ <args>

"FIXME search pattern with double quotes not work
if !exists(':Ag') && executable('ag')
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
"}}}


" COMMANDS DEFINITION {{{
command! OnQuit         call utilfunc#onquit()
command! UpdateCtags    call utilfunc#updatectags($proj)
command! ToggleCode     call utilfunc#togglecode()
command! ToggleColor    call utilfunc#togglecolor()
command! ToggleLine     call utilfunc#toggleline()
command! ToggleTree     call utilfunc#toggletree()
command! -nargs=* -complete=color ChangeTheme call utilfunc#changetheme('<args>')
"}}}


" AUTOCMD {{{
augroup vimrc
    "prevent calling multiple times by sourcing
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
    autocmd User AsyncRunStop if exists(':AsyncRun') | call utilfunc#onasyncexit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif

    "set specific folding for vim files
    autocmd FileType vim setlocal foldmethod=marker
    "Do not fold small file
    autocmd Syntax c,cpp,vim if line('$') < 500 | normal zR | endif

    "FIXME autoread for vim terminal
    "using this event to update file silently but not trigger too often
    "autocmd CursorHold * checktime
augroup END
"}}}
