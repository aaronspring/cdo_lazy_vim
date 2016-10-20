syntax on

" format intendation in whole document with "gg=G" or single line with "gg"
filetype plugin indent on

" autointend
set ai
set ru

set showmatch

"tab = 4 spaces
set tabstop=2

" autocompletion for file
set autochdir
imap <F7> <C-X><C-F>

" list left side
"set nu

" supress autointend when pasting, press <F2> before
set pastetoggle=<F2>

" Use <Tab> instead of <C-N> for autocompletion if already written letter
" Use TAB to complete when typing words, else inserts TABs as usual.
" Uses dictionary and source files to find matching words to complete.
"
" See help completion for source,
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


"++++++++++++++++++++++++++++++++++++
"++++++++ Variable COMPLETION +++++++
"++++++++++++++++++++++++++++++++++++
" reads in all variables from certain datasets
" by executing cdo vardes datasets and completes those if
"  * you hit <C-X><C-U>
"  * vars_completion is enabled
"  * cdo is installed
"  * ncl_completion or cdo_completion are enabled

" 'ENABLE' variablecompletion or 'DISABLE'
let s:vars_completion = 'ENABLE' 

" variable completion data gathering
" set path for file to act cdo vardes on
" CHANGE for your own data
if s:vars_completion == 'ENABLE'
  silent echo "vars completion enabled"
  let s:vars_data_dir = '/work/mh1007/mpiesm1/experiments/lkm0101/outdata/'
  let s:vars_data_strs = ['hamocc/lkm0101_hamocc_data_2d_mm_19990101_19991231.nc', 'mpiom/lkm0101_mpiom_data_2d_mm_19990101_19991231.nc', 'mpiom/lkm0101_mpiom_data_3d_mm_19990101_19991231.nc', 'hamocc/lkm0101_hamocc_data_3d_ym_19990101_19991231.nc' ]

  let s:vars_data = [] 
  for s:vars_data_str in s:vars_data_strs
    let s:cdo_vardes_str = 'cdo vardes ' . s:vars_data_dir . s:vars_data_str
    let s:vars_data += split(system(s:cdo_vardes_str), nr2char(10))
  endfor
endif


"++++++++++++++++++++++++++++++++++++
"++++++++++ CDO COMPLETION ++++++++++
"++++++++++++++++++++++++++++++++++++
" reads in all cdo operators from your locally installed cdo
" by executing cdo --operator and completes those if
"  * you hit <C-X><C-U>
"  * cdo_completion is enabled
"  * cdo_version is later than 1.7.1
"  * filename extension is 'sh'
"
" also a variable completion for your most-used files is done if
"  * filepath of those datasets is  set
"  * vars completion is enabled


" 'ENABLE' cdo completion or 'DISABLE'
let s:cdo_completion = 'ENABLE'

" cdo completion
" if filename ends with 'sh' use cdo completion
if bufname("%")[-2:] == 'sh' && s:cdo_completion == 'ENABLE'
  let s:completion_language='cdo'

  " check for cdo version  
  " let s:cdo_version_data = system('which cdo | grep -o "cdo-[0-9].[0-9].[0-9]"')  
  let s:cdo_version_data = system('cdo --version 2>&1 | head -n 1 | grep -o "[0-9].[0-9].[0-9]"')
  " gets cdo version 1.7.2 as 170 
  let s:cdo_version = s:cdo_version_data[0] . s:cdo_version_data[2] . s:cdo_version_data[4] 		
  silent echo s:cdo_version

  " check if cdo version is capable of cdo --operator, so if version later than 1.7.1
  if s:cdo_version <=170 && s:cdo_completion == 'ENABLE'
    echo "need to update to cdo 1.7.1 or later to use vim autocompletion for cdo"
	let s:cdo_completion = 'DISABLE'
  elseif s:cdo_version == ''
	echo "cannot get cdo -V, needed for autocompletion"
	let s:cdo_completion = 'DISABLE'
  " if cdo --operator works
  elseif s:cdo_version >= 171
    silent echo "for vim autocompletion use C-X C-U"
	let s:cdo_completion = 'ENABLE'
 
    "cdo does --operators
    "get cdo operators from your cdo version
    let s:cdo_data = split(system('cdo --operator'), nr2char(10))
    " check if list has entries
    if empty(s:cdo_data)
  	  echo "ERROR:List from 'cdo --operator' is empty"
    endif
	
    set completefunc=CDOComplete
    " modify completition options, more info in :help completeopt or 
	" http://vimdoc.sourceforge.net/htmldoc/options.html#'completeopt' 
    set completeopt=longest,menu
   
    " to be executed by user by C-X C-U
    fun! CDOComplete(findstart, base)
      if a:findstart && s:cdo_completion == 'ENABLE'
        let l:line = getline('.')
        let l:start = col('.') - 1
        while l:start > 0 && l:line[l:start - 1] =~ '\a'
          let l:start -= 1
        endwhile
        return start
      elseif s:cdo_completion == 'ENABLE'
        " Record what matches − we pass this to complete() later
        let l:res = []
        " Find cdo matches
        for l:line in s:cdo_data
        " Check if it matches what we're trying to complete
          if split(l:line)[0] =~ '^' . a:base
          " It matches! See :help complete() for the full docs on the key names
          " for this dict.
            call add(l:res, {
              \ 'icase': 1,
              \ 'word': split(l:line)[0],
              \ 'abbr': split(l:line)[0],
              \ 'menu': 'CDO: ' . join(split(l:line)[1:]),
              \ })
          endif
        endfor
		
	" varibale completion
	if s:vars_completion == 'ENABLE'
	  " Find variable matches
	  for l:line in s:vars_data
          " Check if it matches what we're trying to complete
            if split(l:line)[1] =~ '^' . a:base
              " It matches! See :help complete() for the full docs on the key names
              " for this dict.
              call add(l:res, {
                \ 'icase': 1,
                \ 'word': split(l:line)[1],
                \ 'abbr': split(l:line)[1],
                \ 'menu': 'Variable: ' . join(split(l:line)[2:]),
                \ })
            endif
          endfor
	endif 

        return res
      endif
    endfun
  endif "for check cdo_version > 1.7.1
" if filename is not *.sh  
else
  silent echo "if you want to use cdo completion, please change filename to *.sh or change your .vimrc"
endif

