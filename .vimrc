" set cdo syntax on .sh files
au BufRead,BufNewFile *.sh set filetype=cdo
au! Syntax newlang source $VIM/cdo.vim 
syntax on

" autointend
set ai
set ru

"tab = 4 spaces
set tabstop=4

" autocomplete to longest common string
" check for other options: 'completeopt' in vimDoc:
" http://vimdoc.sourceforge.net/htmldoc/options.html#'completeopt'
set completeopt=longest,menuone
" instead of longest, menuone, more terminal-like
"set completeopt=preview

" to include keywords with comma separation
set iskeyword+=,

" autocompletion for file on key <F7>
set autochdir
imap <F7> <C-X><C-F>

" supress autointend when pasting, press <F2> before
set pastetoggle=<F2>

" use <Tab> instead of <C-N> for autocompletion if already written letter
" "Use TAB to complete when typing words, else inserts TABs as usual.
" "Uses dictionary and source files to find matching words to complete.
"
" "See help completion for source,
" "Note: usual completion is on <C-n> but more trouble to press all the time.
" "Never type the same word twice and maybe learn a new spellings!
" "Use the Linux dictionary when spelling is in doubt.
" "Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
 	  return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
