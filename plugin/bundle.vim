"Configure setting for plugins

"VIM-AIRLINE {{{
let g:airline_powerline_fonts=0                     "enable/disable powerline
let g:airline_symbols_ascii = 1                     "do not use fancy symbol

"TABLINE (upper bar)
let g:airline#extensions#tabline#enabled = 1        "show tabline
let g:airline#extensions#tabline#fnamemod = ':t'    "show just the filename
let g:airline#extensions#tabline#show_tab_nr = 0    "hide useless tab number
let g:airline#extensions#tabline#tab_min_count = 2  "show tabline with condition

"hide right side of tabline (buffer list)
let g:airline#extensions#tabline#buffer_nr_show = 0 "hide confusing (when editing same file in multiple tabs) buffer index
let g:airline#extensions#tabline#show_buffers = 0   "do not show buffers on tabline (when only tab exists)
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#close_symbol = 'x'
"let g:airline#extensions#tabline#show_close_button = 0

"enable/disable detection of whitespace errors
let g:airline#extensions#whitespace#enabled = 0
"display progress in statusline
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

"show file encoding on statusline if only it's other than utf-8 unix
"mostly edited files are utf-8 so skip this info
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

"statusline: shorten most used modes with characters e.g. N instead of NORMAL
"see also :h vim-modes
let g:airline_mode_map = {
    \ '__'      : '-',
    \ 'c'       : 'C',
    \ 'cv'      : 'VIM EX',
    \ 'ce'      : 'EX',
    \ 'i'       : 'I',
    \ 'ic'      : 'I-C',
    \ 'ix'      : 'I-C',
    \ 'multi'   : 'MULTI',
    \ 'n'       : 'N',
    \ 'ni'      : '(INSERT)',
    \ 'no'      : 'N-OP',
    \ 'R'       : 'R',
    \ 'Rv'      : 'R-V',
    \ 's'       : 'S',
    \ 'S'       : 'S-L',
    \ ''      : 'S-B',
    \ 't'       : 'T',
    \ 'v'       : 'V',
    \ 'V'       : 'V-L',
    \ ''      : 'V-B',
    \ }


"AIRLINE-THEMES EXTENSION
"theme name must match one of files under airline-themes/autoload/airline/themes
"change theme in vim with command :AirlineTheme [theme]
"let g:airline_theme='tomorrow'

"TMUXLINE EXTENSION
"1. set a a colortheme and a preset with :Tmuxline [theme] [preset]
"available templates under tmuxline/autoload/tmuxline/[theme|preset]
"2. create a snapshot file with :TmuxlineSnapshot [file]
"3. add it to .tmux.conf: if-shell "test -f [file]" "source [file]"
let g:airline#extensions#tmuxline#enabled = 0       "disable autoload same theme as vim when starts vim
"enable/disable powerline symbols (default 1)
"let g:tmuxline_powerline_separators = 0
" }}}


"STARTIFY (modified) {{{
if !empty(glob("~/.vim/bundle/*startify"))
    "STARTUP limit lists to show
    let g:startify_list_order = [['MRU:'], 'files',  ['Bookmark:'], 'bookmarks', ['Session:'], 'sessions']

    "MRU limit list of mru files
    let g:startify_files_number = 7
    "ignore session in mru
    let g:startify_session_ignore_files = 1

    "BOOKMARK
    let g:startify_bookmarks = [{'v': '~/.vimrc'}, {'g': '~/.gvimrc'}, {'m': '~/.myrc'}, {'b': '~/.bashrc'}, {'t': '~/.tmux.conf'}]

    "SESSION
    "where to store and load session
    let g:startify_session_dir = '~/.vim/session'
    "auto. update current session when leaving vim (:qa) or loading new one (:SLoad)
    let g:startify_session_persistence = 1
    "set empty. Do not auto. remove commands from session file
    let g:startify_session_remove_lines = []

    "FOOTER
    "add vimtip to footer
    let g:startify_enable_vimtip = 1

    "custom footer
    let g:startify_custom_footer = [''] +
                                 \ map(split(strftime("%c"), '\n'), '"   ". v:val') +
                                 \ ['   Hey ' . $USER . '! This cow has a vimtip for you:']

    let g:startify_session_before_save = ['silent! NERDTreeTabsClose', 'silent! TagbarClose']

    "set color
    highlight StartifyBracket ctermfg=240
    highlight StartifyHeader  ctermfg=114
    highlight StartifyFooter  ctermfg=245
    highlight StartifyNumber  ctermfg=215
    highlight StartifyPath    ctermfg=245
    highlight StartifySlash   ctermfg=240
    highlight StartifyVar     ctermfg=250
endif
"}}}

"LSP {{{
"ALE - asynchronous lint engine
"put options out of autocmd so it set before plugin loaded
let g:ale_linters = {
    \   'cpp'   : ['clangd'],
    \   'python': ['flake8'],
    \   'bash'  : ['bash-language-server']
    \}

let g:ale_fixers = {
    \   'python': ['yapf']
    \}

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
"disable background color of signs
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"disable background color of code error lines
let g:ale_set_highlights = 0

"linter not work well with c++ (external libs)
let g:ale_enabled = 0
let g:ale_completion_enabled = 1
"do not overwhelm with trivial
let g:ale_completion_max_suggestions = 20
"do not interrupt, delay or swallow words while typing
"could manually trigger with c-x_c-o (see maplsp)
let g:ale_completion_delay = 900

"COC - intellisense for vim
"see :h coc-nvim
"configuration coc-settings.json in ~/.vim or ~/.config/nvim
"could manually trigger 'intellisense' with c-space (see maplsp)
" }}}


"ULTISNIPS {{{
"Do not declare if not use
if v:version >= 704
    "using snippets template from: https://github.com/honza/vim-snippets.git
    "note: it will search in runtimepath for dir with names on the list below
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    "<tab> slows down normal use-case dramatically
    let g:UltiSnipsExpandTrigger='<c-l>'
    "<c-tab> reserved by iterm for switching tab
    let g:UltiSnipsListSnippets='<c-l>l'
    "<c-k> interferes with i_ctrl-k
    let g:UltiSnipsJumpBackwardTrigger='<c-l>p'
    let g:UltiSnipsJumpForwardTrigger='<c-l>n'
endif
" }}}


"NERD_TREE {{{
"ignore files and folder
let NERDTreeIgnore=['build', '\~$']
"hide first help line
let NERDTreeMinimalUI = 1
"do not deactivate netrw (for opening directory)
let g:NERDTreeHijackNetrw = 0

"NERDTREE_TABS
let g:nerdtree_tabs_autofind = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

"NETRW
":help netrw-quickmap --> to see all shortcuts
"suppress banner, I to toggle it
let g:netrw_banner = 0
"enter to open file in previous window
"o/v/t open file in new horizontal/vertical split or new tab
"x open file with default system app
"p to preview in split. Default 0 is vertical split
let g:netrw_preview = 1
"specify action when opening file with <cr>
"let g:netrw_browse_split = 1
"tree style, i to cycle modes
let g:netrw_liststyle = 3
"define width
let g:netrw_winsize = 25
"}}}


"DEVICON {{{
"Devicon for nerdtree

"loading devicon
let g:webdevicons_enable = 1

"force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"padding between symbol and text
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

"disable icon on vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 0


"NERDTREE_HIGHLIGHT
"disable highlight, lag with big tree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1

"Disable uncommon file extensions highlighting, reduce lag when scrolling
let g:NERDTreeLimitedSyntax = 1
"highlight files
let g:NERDTreeFileExtensionHighlightFullName = 1
" }}}


"FZF.VIM {{{
"define window layout
let g:fzf_layout = { 'down': '~30%' }

":Buffers -- jump to the existing window if possible
let g:fzf_buffers_jump = 1
":Commands -- expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

"change default behaviour jump to existing tab if possible
let g:fzf_action = {
    \ 'ctrl-t': 'tab drop',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
"}}}


"OTHER PLUGINS {{{
"CPP-ENHANCED-HIGHLIGHT
let g:cpp_class_scope_highlight = 1

"TAGBAR
let g:tagbar_autofocus=1                "focus on actual function

"BETTER-WHITESPACE
"show bad whitespace on open, manual enable with :ToggleWhitespace
let g:better_whitespace_enabled = 0

"disable highlight on file, don't use default list, override it
let g:better_whitespace_filetypes_blacklist=['markdown', 'qf']

"auto clear on save
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 1

"ZEAVIM
"configure default docsets searching based on file types
let g:zv_file_types = {
            \   'cpp': 'cpp,opencv,qt' }
" }}}


"GREP {{{
"fzf.vim uses FZF_DEFAULT_COMMAND
"':Ag' uses grepgrp

"SILVER SEARCH
if executable('ag')
  "use ag over vimgrep
  set grepprg=ag\ --vimgrep
endif

"RIPGREP
if executable('rg')
  "use rg over ag
  set grepprg=rg\ --vimgrep
endif
"}}}
