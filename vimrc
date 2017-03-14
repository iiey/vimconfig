"Install vimplug {{{
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

"Load Plugins {{{
"specific directory to load
call plug#begin('~/.vim/bundle')

""note: plugins are added to &runtimepath in the order they are defined here
""first load personal stuff: setting, command, mapping
Plug 'iiey/vimconfig'


"BASIC
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'bitc/vim-bad-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'

"FIXME split window after install
Plug 'bogado/file-line'


"EXTENDED
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'

"ultisnip requires vim 7.4
Plug 'SirVer/ultisnips', v:version >= 704 ? {} : {'on' : []}
Plug 'honza/vim-snippets', v:version >= 704 ? {} : {'on' : []}
Plug 'Rip-Rip/clang_complete'

Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-f)'}


"ENHANCED
Plug 'iiey/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree', {'on': []}
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'ryanoasis/vim-devicons'
Plug 'wincent/terminus'

"do not load if no colorscheme is set
Plug 'blueyed/vim-diminactive', exists('g:colors_name') ? {} : {'on': []}

"initalize plugin system
call plug#end()
"}}}

"Defer loading {{{
"vimplug defers some plugins (lazzy loader)
"do onetime loading based events
augroup load_on_move
  autocmd!
  autocmd CursorMoved * call plug#load('nerdtree') | autocmd! load_on_move
augroup END

"more easy way: load plugins at startup
"execute pathogen#infect()
"}}}
