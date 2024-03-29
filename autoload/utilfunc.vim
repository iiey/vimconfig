"Note: function name prefix must match the script filename

"UTILS FUNCTIONS {{{
"Ctags
function! utilfunc#updatectags(proDir)
    "generate ctags only for projects
    if empty(a:proDir) | echom "project directory empty!" | return | endif
    "execute 'ctags' at projDir to take advantage of --tag-relative=yes
    let cmd = 'cd ' . a:proDir . ' && ' . 'ctags -R -f ./.tags .'
    if exists(":AsyncRun")
        execute "AsyncRun " . cmd
    else
        call system(cmd) | echom "write:" . a:proDir . "/.tags"
    endif
endfunction

"Set project build directory
function! utilfunc#setbuilddir(buildDir)
    let &makeprg='cmake --build ' . shellescape(a:buildDir) . ' --target '
endfunction

"Change colorscheme and airlinetheme
function! utilfunc#changetheme(color)
    let l:color = a:color
    let l:airline = a:color

    "specify configuration for some colors
    if a:color == 'codeschool'
        let l:airline = 'cobalt2'
    elseif a:color == 'pencil'
        set background=dark
    elseif a:color == 'solarized'
        set background=dark
    elseif a:color == 'tomorrow-night'
        let l:airline = 'tomorrow'
    elseif a:color == 'quantum'
        let g:quantum_black = 1
        if has('gui_running')
            let g:quantum_italics = 0
        endif
    elseif a:color == 'wombat256mod'
        let l:airline = 'wombat'
    endif

    "Using 'execute' to evaluate value of argument not the argument
    execute ':colorscheme' l:color
    execute ':AirlineTheme' l:airline
endfunction

"Toggle line number: hydrid/absolute/none
function! utilfunc#toggleline()
    "consider (nu/rnu)-pairs are states of line number => 00, 01, 10, 11
    "transition in 7.3: 00 -> 01 -> 10 -> 00 (11 only available up 7.4)
    "transition in 7.4: 00 -> 11 -> 10 -> 00 (don't toggle trivial 01)
    if &number == 0 && &relativenumber == 0
        if v:version >= 704 | set number | endif
        set relativenumber
    elseif &relativenumber == 1
        set number
        set norelativenumber
    else
        set nonumber
        set norelativenumber
    endif
endfunc

"Toggle c header/code
"@see :h filename-modifiers
"arg: 'e[dit]', 'tabe', '[v]split'
function! utilfunc#togglecode(...) abort
    if &filetype !~ '^c.*' | return | endif
    let open = (a:0 == 1) ? a:1 : 'edit'
    execute open '%:p:r.' .. (expand("%:e") =~ '^c.*' ? 'h' : 'c*')
endfunction

"Head-up digraphs
function! utilfunc#hudigraphs()
    digraphs
    call getchar()
    return "\<c-k>"
endfunction

"Search keyword in browser
"see :h function-argument
function! utilfunc#search(...)
    let url = "http://www.google.com/search?q="
    let url .= (a:0 > 0) ? join(a:000, '') : expand("<cword>")
    call netrw#BrowseX(url, 0)
endfunction

"Exit
function! utilfunc#onquit()
    if &mod
        echo "Save & Quit [Y|y]es/[N|n]o/[c]ancle: "
        let l:saved = getchar()
        let l:saved = nr2char(l:saved)

        if l:saved ==# 'Y'
            execute ':xa'
        elseif l:saved ==# 'y'
            execute ':x'
        elseif l:saved ==# 'N'
            execute ':qa!'
        elseif l:saved ==# 'n'
            execute ':q!'
        elseif l:saved ==? 'c'
            redraw | echo "File not saved"
        endif
    else
        execute ':qa'
    endif
endfunction
" }}}


"PLUGIN FUNCTIONS {{{
"lsp
"create map for ale and coc
function! utilfunc#maplsp()
    if get(g:, 'loaded_ale', 0)
        "<plug> mapping not work with 'nore'
        imap <buffer> <leader>ac <Plug>(ale_complete)
        nmap <buffer> <leader>ar <Plug>(ale_find_references)
        nmap <buffer> <leader>ad <Plug>(ale_go_to_definition)
        nmap <buffer> <leader>ah <Plug>(ale_hover)
        nmap <buffer> <leader>at <Plug>(ale_toggle)

        "use to trigger manually with c-x_c-o
        if executable('clangd') || executable('pyls')
            setlocal omnifunc=ale#completion#OmniFunc
        endif
    endif

    if get(g:, 'did_coc_loaded', 0)
        inoremap <buffer> <silent> <expr> <c-space>  coc#refresh()  "work in gui
        inoremap <buffer> <silent> <expr> <nul>      coc#refresh()  "workaround in terminal
    endif
endfunction

"asyncrun
"helper function for closing quickfix after finishing job
function! utilfunc#async_onexit()
    "user can close quickfix manually if it displays grep results
    let l:grep_job = 0
    for cmd in ['^ag', '^ack', '^grep', '^rg']
        if @: =~? cmd | let l:grep_job += 1 | endif
    endfor
    "create a timer if only job other than grep succeeded
    if g:asyncrun_status == 'success' && grep_job == 0
        "fire a timer with lambda as it's function callback
        "lambda body handles only an expression expr1
        "using execute() to have expr1 from an Ex command
        let timer = timer_start(500, {-> execute(":call asyncrun#quickfix_toggle(8, 0)")})
    endif
endfunc

"NERDTree
function! utilfunc#toggletree()
    "check if nerdtree is available
    if !exists('g:loaded_nerd_tree') | return | endif

    "use nerdtreetabs if it's available
    if exists('g:nerdtree_tabs_loaded')
        if g:NERDTree.IsOpen()
            execute ':NERDTreeTabsClose'
        else
            "workaround for stupid nerdtab
            NERDTreeTabsOpen        "the focus's on tree if only command executes from first buffer
            NERDTreeFocus           "these two commands make sure focus always on file
            NERDTreeFocusToggle
            NERDTreeTabsFind        "because this command works if only focus's on file
        endif
        return
    endif

    "use nerdtree otherwise
    if g:NERDTree.IsOpen() | NERDTreeClose | else | NERDTreeFind | endif
endfunction
"}}}
