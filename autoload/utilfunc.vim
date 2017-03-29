"Note: function name prefix must match the script filename

"UTILS FUNCTIONS {{{
"Ctags
function! utilfunc#updatectags(proDir)
    "generate ctags only for projects
    if empty(a:proDir) | echom "project directory empty!" | return | endif
    "execute 'ctags' at projDir to take advantage of --tag-relative=yes
    let cmd = 'cd ' . a:proDir . '&&' . 'ctags -f ./.tags .'
    if exists(":AsyncRun")
        execute "AsyncRun " . cmd
    else
        call system(cmd) | echom "write:" . a:proDir . "/.tags"
    endif
endfunction

"Change colorscheme and airlinetheme
function! utilfunc#changetheme(color)
    let l:color = a:color
    let l:airline = a:color

    "specify configuration for some colors
    if a:color == 'codeschool'
        let l:airline = 'cobalt2'
    elseif a:color == 'pencil'
        set background = dark
    elseif a:color == 'solarized'
        set background = dark
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

"Toggle solarized/wombat colorscheme
function! utilfunc#togglecolor()
    if g:colors_name != 'solarized'
        set background=dark
        colorscheme solarized
        AirlineTheme solarized
    else
        colorscheme wombat256mod
        AirlineTheme wombat
    endif
endfunction

"Toggle cpp header
"@see :h filename-modifiers
"TODO expand file extension with tab
function! utilfunc#togglecode()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

"Head-up digraphs
function! utilfunc#hudigraphs()
    digraphs
    call getchar()
    return "\<c-k>"
endfunction

"Browser stuff
"search current keyword
function! utilfunc#googlit()
    let url = "http://www.google.com/search?q=" . expand("<cWORD>")
    call netrw#BrowseX(url, 0)
endfunction

"search phrase with command :Search
function! utilfunc#search(phrase)
    let url = "http://www.google.com/search?q=" . a:phrase
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
"asyncrun
"helper function for closing quickfix after finishing job
function! utilfunc#onasyncexit()
    "user can close quickfix manually if it displays grep results
    let l:grep_job = 0
    for cmd in ['^ag', '^ack', '^grep']
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
            "TODO fix stupid nerdtab behaviour
            NERDTreeTabsOpen
            NERDTreeFocusToggle
            NERDTreeTabsFind
        endif
        return
    endif

    "use nerdtree otherwise
    if g:NERDTree.IsOpen() | NERDTreeClose | else | NERDTreeFind | endif
endfunction
"}}}
