# vimconfig
stuff from my vimrc breaks into pieces for keeping organised things more organised

### Install
On Unix execute:
```sh
#backup current vimrc file if existed
mv ~/.vimrc{,_backup}
#clone project into special folder
git clone https://github.com/iiey/vimconfig ~/.vim/bundle/vimconfig \
&& ln -sfn ~/.vim/bundle/vimconfig/vimrc ~/.vim/vimrc
```

#### Structure
  - Basic vim setting: ``vimconfig/plugin/setting.vim``
  - Commands: ``vimconfig/plugin/command.vim``
  - Mapping: ``vimconfig/plugin/mapping.vim``
  - Plugins configuration: ``vimconfig/plugin/bundle.vim``
  - Functions implementation: ``vimconfig/autoload/utilfunc.vim``

#### Note
  - Some plugin keybindings may changed to avoid conflict with default vim mapping
  - More detail see each plugin SECTION under **bundle.vim**
  - ``~/.vim/bundle`` is path where plugins are stored and managed by [vim-plug][1]

##### [airline][2]
  - Modify setting.vim to enable statusline with powerline symbols
```vim
let g:airline_powerline_fonts=0
```
  - Make sure powerline-fonts installed
    - On Linux: [fontconfig][3] should work out for any font without patching
    - On MacOS: download and install patched [fonts][4] from [powerline-fonts][5], set terminal using patched fonts

##### [ultisnip][6]
  - See also ``:h ultisnips-triggers``
  - Key changes in section ULTISNIPS
```vim
g:UltiSnipsExpandTrigger            <c-l>
g:UltiSnipsListSnippets             <c-l>l
g:UltiSnipsJumpForwardTrigger       <c-l>n
g:UltiSnipsJumpBackwardTrigger      <c-l>p
```

##### [clang\_complete][7]
  - Set default library path
```vim
let g:clang_library_path=expand("$HOME")."/lib/"
```

  - Avoid conflict with tagjump ``<c-]>``
```vim
g:clang_jumpto_declaration_key      <c-w>[
```


#####  [ctrlp][8]
  - Default shortcut to not conflict with behaviours ``<c-n>`` ``<c-p>``
```vim
let g:ctrlp_map =[p
```
  - Just fall back method which rarely used. Better using ``[f`` to call [fzf][9]

[1]: https://github.com/junegunn/vim-plug
[2]: https://github.com/vim-airline/vim-airline
[3]: http://powerline.readthedocs.io/en/master/installation/linux.html#fontconfig
[4]: https://github.com/iiey/dotfiles/tree/master/fonts/Powerline
[5]: https://github.com/powerline/fonts
[6]: https://github.com/SirVer/ultisnips
[7]: https://github.com/Rip-Rip/clang_complete
[8]: https://github.com/ctrlpvim/ctrlp.vim
[9]: https://github.com/junegunn/fzf
