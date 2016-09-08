in progress...

CDO_lazy_vim README
===================

If you are using vi/vim/gvim for scripting with cdo, you can sometimes hardly remember cdo commands or you are just too lazy to type out sellonlatbox all the time, this might be something for you.

Configuration instructions
--------------------------
For completion: <br>
1. Copy all desired dictionary files but definately including ".vim/dictionary/cdo.dic" to "~/.vim/dictionary" <br>
2. Copy the file ".vim/ftdetect/cdo.vim" to "~/.vim/ftdetect" <br>
3. Add the following line to your .vimrc file "~/.vimrc" <br>
```
set completeopt=longest,menuone
```

Optional completion: <br>
1. If you don't need some dictionaries, eg. those of some other model variables just comment those out in ".vim/ftdetect/cdo.vim" <br>
2. If you want to use <Tab> for auto-completion like in your shell, add those lines to your .vimrc <br>
```
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
      return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
```
Source: http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion <br>
The usual <Tab> command will still be executed when no completion is feasable, eg. in the beginning of (empty) lines <br>
3. If you fancy other auto-completion setting, play with the line
```
set complete=longest,menuone
```
The current setting completes up to the last common string and then shows a menu. Other options are listed in the vim help or http://vimdoc.sourceforge.net/htmldoc/options.html#'completeopt' <br>

<br><br>

For syntax highlighting: <br>
1. coming soon <br>


Operating instructions
----------------------
Start typing your desired cdo command and hit &lt;Control-N>
```
cdo sell<Ctrl-N>
```
Get the following autocompletion options 
```
sellevel                /..path..to..dic-file/cdo.dic
sellevidx               /..path..to..dic-file/cdo.dic
sellonlatbox            /..path..to..dic-file/cdo.dic
selltype                /..path..to..dic-file/cdo.dic
```
Hit another &lt;Ctrl-N> go get the first shown match
```
cdo sellevel
```
hit another &lt;Ctrl-N> to choose the next match or move down with arrow keys and hit <Enter> for your choice 



Copyright and licensing information
-----------------------------------
* helpme

Known bugs
----------
* just starting
* list of dictionary items might be incomplete

Contact information
-------------------
Aaron Spring
Bundesstraße 53
ZMAW Room 229
aaron.spring@mpimet.mpg.de


Changelog
---------
* 0.1: basic auto-complete function based on cdoCompletion.bash as of 2016/09/06
* 0.2: some MPI-ESM variables included for HAMOCC 2d, 3d and Sedi, MPIOM 2d, 3d and ECHAM6 BOT, LOG, ... checkout .vim/dictionary

Working on
----------
* proper syntax highlighting
* more description in completion popup, eg. syntax or variable longname

Credits and acknowledgements
----------------------------
* Uwe Schulzweida, creator of cdo
* Pierre X, the dude who did this for ncl and made me think about this 


