"Define commands which functions are implemented in autoload/utilfunc.vim

"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available
"Note plugins are not run, we cannot check if exists(':AsyncRun')
":Make runs :make in background with asyncrun
"and make again determined by makeprg see also @utilfunc#setbuilddir()
"Usage: :Make PROG_NAME -- -jN
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
"}}}

"CPPMAN {{{
"manual page viewer
"note: using "$cppman -m true" to call cppman from default man
"it's handy if vim-man is installed
if executable('tmux') && executable('cppman')
    command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
    command! -nargs=+ CppMan silent! call system("tmux split-window -h cppman " . expand(<q-args>))
endif
"}}}

"FZF.VIM {{{
if executable('fzf')
    "Files command with preview window
    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    "fzf#vim#grep(command, with_column, [options], [fullscreen])
    "with_column: 0 -> output of 'command' not include column numbers, otherwise 1
    "fullscreen: bang<0> evaluates to 0 if no bang (!) right after 'command', otherise 1
    "git grep
    command! -bang -nargs=* GGrep
                \ call fzf#vim#grep(
                \   'git grep --color=always --line-number '.shellescape(<q-args>), 0,
                \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

    "ripgrep
    command! -bang -nargs=* -complete=file Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case ' . shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:70%')
                \           : fzf#vim#with_preview('right:50%', '?'),
                \   <bang>0)
endif
"}}}

" COMMANDS DEFINITION {{{
command! -nargs=1 -complete=color   ChangeTheme     call utilfunc#changetheme('<args>')
command! -nargs=*                   Search          call utilfunc#search('<args>')
command! -nargs=1 -complete=dir     SetBuildDir     call utilfunc#setbuilddir('<args>')
command! -nargs=1                   ToggleCode      call utilfunc#togglecode('<args>')
"}}}

" AUTOCMD {{{
augroup lsp | autocmd!
    "<buffer> mapping so it enabled only for certain filetypes
    autocmd FileType c,cpp,python,sh call utilfunc#maplsp()
augroup END

augroup vimplug | au!
    "download new coming plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                        \| PlugInstall --sync | q | endif
augroup END

augroup vimrc
    "prevent calling multiple times by sourcing
    autocmd!

    "normal: hydrid relative line, insert: absolute line
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set nu rnu | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu  | endif
    augroup END

    "TODO write function in case more than one left behind windows of these kinds
    "close vim if one left behind window is nerdtree, quickfix or help
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'quickfix') | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'help') | q | endif

    "open when asyncrun starts
    autocmd User AsyncRunStart if exists(':AsyncRun') | call asyncrun#quickfix_toggle(8, 1)
    "and close on success
    autocmd User AsyncRunStop if exists(':AsyncRun') | call utilfunc#async_onexit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif

    "specific folding method
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python setlocal foldmethod=indent

    "disable fmd=syntax on large file (causing lagging when editing)
    autocmd FileType c,cpp,python,sh,xml if line('$') > 4000 | setlocal foldmethod=indent | endif

    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " modify path according to mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
augroup END
"}}}
