"VIMPLUG {{{
"the minimalist plugin manager

"automatic install vimplug if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"load plugins from specific directory
call plug#begin('~/.vim/bundle')

"note: plugins are added to &runtimepath in the order they are defined here
"first load personal stuff: setting, command, mapping
Plug 'iiey/vimconfig'

"basic
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'bitc/vim-bad-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bogado/file-line'

"extended
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Rip-Rip/clang_complete'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-f)'}

"enhanced
Plug 'iiey/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree', {'on': []}
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'ryanoasis/vim-devicons'
Plug 'wincent/terminus'
Plug 'iiey/vimcolors'

"initalize plugin system
call plug#end()

"vimplug defers some plugins (lazzy loader)
"do onetime loading based events
augroup load_on_move
  autocmd!
  autocmd CursorMoved * call plug#load('nerdtree') | autocmd! load_on_move
augroup END

"more easy way: load plugins at startup
"execute pathogen#infect()
"}}}
