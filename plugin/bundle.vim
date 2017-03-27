"Configure setting for plugins

"VIM-AIRLINE {{{
let g:airline_powerline_fonts=1                     "enable powerline font

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


"AIRLINE-THEMES EXTENSION
"theme name must match one of files under airline-themes/autoload/airline/themes
"change theme in vim with command :AirlineTheme [theme]
"let g:airline_theme='solarized'

"TMUXLINE EXTENSION
"1. set a a colortheme and a preset with :Tmuxline [theme] [preset]
"available templates under tmuxline/autoload/tmuxline/[theme|preset]
"2. create a snapshot file with :TmuxlineSnapshot [file]
"3. add it to .tmux.conf: if-shell "test -f [file]" "source [file]"
let g:airline#extensions#tmuxline#enabled = 0       "disable autoload same theme as vim when starts vim
" }}}


"CTAGS {{{
"TODO: ensure env var not take effect other session
"guess projRootDir by checking version control system
for vcs in ['.git', '.svn', '.hg']
    "searching from current "." upwards ";" to "~/sources"
    let projRootDir = fnamemodify(finddir(vcs, '.;$HOME/sources'), ':h')
    if isdirectory(projRootDir.'/'.vcs)
        "init env-var for later uses
        let $proj = projRootDir
        break
    else
        let $proj = ''
    endif
endfor
"}}}


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

    "FIXME loading time 25ms
    "custom footer
"    let g:startify_custom_footer = map(split(system('vim --version | head -n1'), '\n'), '"   ". v:val') + [''] +
"                                 \ map(split(strftime("%c"), '\n'), '"   ". v:val') +
"                                 \ ['   Hey ' . $USER . '! This cow has a vimtip for you:']

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


"CLANG_COMPLETE {{{
"Using omnifunc=ClangComplete because builtin ccomplete don't work correctly
"<c-x><c-u> to trigger specific completefunc

"path to directory which contains libclang.{dll|so|dylib} (win/linux/macos)
"no need to configure if using default path /usr/lib
let g:clang_library_path=expand("$HOME")."/lib/"

"also complete parameters of function
let g:clang_snippets = 1
"default engine cannot jump between parameters
"use ultisnip if it's available
if v:version >= 704
    let g:clang_snippets_engine = 'ultisnips'
endif
"prevent default key from disable tagjump <c-]>
let g:clang_jumpto_declaration_key = '<c-w>['
"}}}


"ULTISNIPS {{{
"Do not declare if not use
if v:version >= 704
    "using snippets template from: https://github.com/honza/vim-snippets.git
    "note: it will search in runtimepath for dir with names on the list below
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    "<c-tab> reserved by iterm for switching tab
    let g:UltiSnipsListSnippets='<c-h>'
    "<c-k> interferes with completion i_ctrl-x
    let g:UltiSnipsJumpBackwardTrigger='<c-l>'
endif
" }}}


"CTRLP {{{
"ctrlp auto. finds projectRoot based on .svn/.git...
let g:ctrlp_working_path_mode = 'ra'                "working dir is nearest acestor of current file
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](.git|.svn|build|tmp)$',
    \ 'file': '\v\.(exe|so|dll|swp|tags|zip)$'}          "exclude file and directories
"set wildignore+=*/tmp/*,*/build/*,*.so,*.swp,*.zip
let g:ctrlp_by_filename = 1                         "default searching by filename instead of full path
let g:ctrlp_map = '[p'
"let g:ctrlp_cmd = 'CtrlPMixed'                      "invoke default command to find in file, buffer and mru
" }}}


"NERD_TREE {{{
"ignore files and folder
let NERDTreeIgnore=['build', '\~$']
"hide first help line
let NERDTreeMinimalUI = 1

"NERDTREE_TABS
let g:nerdtree_tabs_autofind = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

"NETRW
let g:NERDTreeHijackNetrw = 0   "do not deactivate netrw (for opening directory)
let g:netrw_liststyle = 3       "tree style
"}}}


"DEVICON {{{
"Devicon for nerdtree

"loading devicon
let g:webdevicons_enable = 1

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"padding between symbol and text
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''


"NERDTREE_HIGHLIGHT
"disable highlight, lag with big tree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1

"Disable uncommon file extensions highlighting, reduce lag when scrolling
let g:NERDTreeLimitedSyntax = 1
"highlight files
let g:NERDTreeFileExtensionHighlightFullName = 1
" }}}


"EASYMOTION {{{
"uncomment for using <leader> instead of <leader>²
"map <leader> <Plug>(easymotion-prefix)

"remap only one feature
nmap <leader>f <Plug>(easymotion-f)

"v matches [v|V] and V matches only [V]
let g:EasyMotion_smartcase = 1
"}}}


"OTHER PLUGINS {{{
"CPP-ENHANCED-HIGHLIGHT
let g:cpp_class_scope_highlight = 1
"python-syntax
let g:python_highlight_all = 1

"UNDOTREE
if has("persistent_undo")               "set undodir to one place
    set undodir=~/.undodir/
    set undofile
endif

let g:undotree_SetFocusWhenToggle = 1   "cursor moved to undo-window when opened
let g:undotree_WindowLayout = 3         "undo-/diff-window open on the left side

"TAGBAR
let g:tagbar_autofocus=1                "focus on actual function

"BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist=['txt', 'csv', 'ppm']
let b:bad_whitespace_show=0
" }}}


"GREP - SILVER SEARCH {{{
if executable('ag')
  "use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  "use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  "ag is fast that ctrlp doesn't need to cache
  let g:ctrlp_use_caching = 0

endif
"}}}
