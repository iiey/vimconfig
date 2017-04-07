# vimconfig
stuff from my vimrc breaks into pieces for keeping organised things more organised

### Install
On Unix backup the existing ~/.vimrc and replace it by executing:
```sh
git clone https://github.com/iiey/vimconfig ~/.vim/bundle/vimconfig
\ && ln -sfn ~/.vim/bundle/vimconfig/vimrc ~/.vimrc
```
#### Structure
  - Basic setting: ``vimconfig/plugin/setting.vim``
  - Commands: ``vimconfig/plugin/command.vim``
  - Mapping: ``vimconfig/plugin/mapping.vim``
  - Plugins configuration: ``vimconfig/plugin/bundle.vim``
  - Functions: ``vimconfig/autoload/utilfunc.vim``

#### Note
1. [airline](https://github.com/vim-airline/vim-airline) Install powerline fonts:
    - On Linux: [fontconfig](http://powerline.readthedocs.io/en/master/installation/linux.html#fontconfig) should work out for any coding font without patching
    - On MacOS: download patched [fonts](https://github.com/iiey/dotfiles/tree/master/fonts/Powerline) from [powerline-fonts](https://github.com/powerline/fonts), double click to install, set terminal using patched fonts
    - Or disable if don't need powerline symbols. In bundle.vim: ``let g:airline_powerline_fonts=0``
1. [clang_complete](https://github.com/Rip-Rip/clang_complete) default library path:
    - In bundle.vim: ``let g:clang_library_path=expand("$HOME")."/lib/"``
1.  [ctrlp](https://github.com/ctrlpvim/ctrlp.vim) avoid breaking default behaviours ``<c-n>`` ``<c-p>``
    - In mapping.vim: ``let g:ctrlp_map =[p``
