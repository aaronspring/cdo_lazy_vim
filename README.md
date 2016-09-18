in progress...

CDO_lazy_vim README
===================

If you are using vi/vim/gvim for scripting with cdo, you can sometimes hardly remember cdo commands or you are just too lazy to type out "sellonlatbox" all the time, this might be something for you.

![animation]( cdo_completion.gif )

Configuration instructions
--------------------------

* Add the lines to your "add_cdo_complete_to_your_vimrc" to your "~/.vimrc" to include the complete function <br>
```
cat add_cdo_complete_to_your_vimrc >> ~/.vimrc
```

Optional: <br>
1. Variable completion: Set a file path and enable vars_completion in your ".vimrc"  
2. If you want to use &lt;Tab> for auto-completion like in your shell, add those lines to your .vimrc <br> FIXME: Doesnt replace <C-U><C-U> yet, but only <C-N>
```
" Use TAB to complete when typing words, else inserts TABs as usual.
" Uses dictionary and source files to find matching words to complete.
" "See help completion for source,
" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
" Window users can copy the file to their machine.
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
The usual &lt;Tab> command will still be executed when no completion is feasable, eg. in the beginning of (empty) lines <br>
3. If you fancy other auto-completion setting, play with the line
```
set complete=longest,menuone
```
The current setting completes up to the last common string and then shows a menu. Other options are listed in the vim help or http://vimdoc.sourceforge.net/htmldoc/options.html#'completeopt' <br>

<br>

For syntax highlighting: <br>
1. coming soon <br>


Operating instructions
----------------------
Start typing your desired cdo command and hit &lt;Control-X>&lt;Control-U>
```
cdo sell<Ctrl-X><Ctrl-U>
```
Get the following autocompletion options 
```
sellevel                sellevel description
sellevidx               sellevidx description
sellonlatbox            sellonlatbox description
selltype                selltype description
...
```
Hit &lt;Ctrl-N> go get the first shown match
```
cdo sellevel
```
Hit another &lt;Ctrl-N> to choose the next match or move down with arrow keys and hit <Enter> for your choice 



Copyright and licensing information
-----------------------------------
* helpme

Known bugs
----------
* just starting
* list of dictionary items might be incomplete

Contact information
-------------------
Aaron Spring <br> Bundesstraße 53 <br> ZMAW Room 229 <br> aaron.spring@mpimet.mpg.de <br> <br> 
Looking forward to receiving your questions, comments or wishes


Changelog
---------
* v0.1: basic auto-complete function based on cdoCompletion.bash as of 2016/09/06
* v0.2: some MPI-ESM variables included for HAMOCC: 2d, 3d and sediment; MPIOM: 2d, 3d and ECHAM6: BOT, LOG, ...; checkout  this repositories ".vim/dictionary"
* v1.0: completly new approach: uses all 'cdo --operators' listings installed on your machine, requires cdo-1.7.1 or later, also completes variables gathered by 'cdo vardes files', requires '*.sh' files, variable_completion and cdo_completion can be enabled or disabled in .vimrc 

Working on
----------
* proper syntax highlighting
* anything else needed?

Credits and acknowledgements
----------------------------
* Uwe Schulzweida, creator of cdo
* Prince K Xavier, the dude who set up auto-completion for NCL and made me think about this 
* Ralf Müller

