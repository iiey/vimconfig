if !empty(glob('~/.vim/local.vimrc'))
    source ~/.vim/local.vimrc
endif

"Install vimplug {{{1
"auto install plugin manager if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
    let s:link='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if executable('curl')
        execute 'silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs ' . shellescape(s:link)
    elseif executable('wget')
        execute 'silent !wget -nd -P ~/.vim/autoload/ ' . shellescape(s:link)
    else
        finish
    endif
    "flag --sync blocks execution until install is finish
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"Load Plugins {{{1
"specific directory to load
call plug#begin('~/.vim/bundle')

""note: plugins are added to &runtimepath in the order they are defined here
""first load personal stuff: setting, command, mapping
Plug 'iiey/vimconfig'

"BASIC (essential) {{{2
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'wsdjeg/vim-fetch'
Plug 'tpope/vim-surround'
"}}}

"ENHANCED (productive) {{{2
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'skywind3000/asyncrun.vim'

"no zeal support on mac os because of dash
if ! has('mac') || ! has('osx')
    Plug 'KabbAmine/zeavim.vim'
endif

"ultisnip requires vim 7.4
Plug 'SirVer/ultisnips', v:version >= 704 ? { 'tag': '3.2' } : { 'on' : [] }
    Plug 'honza/vim-snippets', v:version >= 704 ? {} : {'on' : []}
"Plug 'xavierd/clang_complete', {'for': ['c', 'cpp']}

Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-f)'}
"}}}

"OTHERS (optional) {{{2
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'iiey/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree', {'on': []}
    Plug 'ryanoasis/vim-devicons'
Plug 'edkolev/tmuxline.vim'
Plug 'blueyed/vim-diminactive'
Plug 'peterhoeg/vim-qml'
"}}}

"initalize plugin system
call plug#end()
"}}}

"Defer loading {{{1
"vimplug defers some plugins (lazzy loader)
"do onetime loading based events
augroup load_on_move
  autocmd!
  autocmd CursorMoved * call plug#load('nerdtree') | autocmd! load_on_move
augroup END
"}}}
