" Vim syntax File    
" Language: CDO
" Author:   Aaron Spring
" Updated xxx

syn keyword cdoBUILTIN add sub mul abs max min 
syn keyword cdoCONTRIB ueberallmusswasstehen
syn keyword cdoResource fldsum vertsum 
syn keyword cdoKeyword cdo   

syn match cdoOperator "(/"
syn match cdoOperator "\/)"
syn match cdoOperator "\\"
syn match cdoOperator "{"
syn match cdoOperator "\}"
syn match cdoOperator "\.eq\."
syn match cdoOperator "\.ne\."
syn match cdoOperator "\.lt\."
syn match cdoOperator "\.le\."
syn match cdoOperator "\.gt\."
syn match cdoOperator "\.ge\."
syn match cdoOperator "\.eqc\."
syn match cdoOperator "\.nec\."
syn match cdoOperator "\.lec\."
syn match cdoOperator "\.ltc\."
syn match cdoOperator "\.gtc\."
syn match cdoOperator "\.gec\."


" cdo numbers (ripped off from  fortran.vim)
syn match cdoNumber	display "\<\d\+\(_\a\w*\)\=\>"
syn match cdoNumber	display	"\<\d\+[deq][-+]\=\d\+\(_\a\w*\)\=\>"
syn match cdoNumber	display	"\.\d\+\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
syn match cdoNumber	display	"\<\d\+\.\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
syn match cdoNumber	display	"\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>"
syn match cdoNumber	display	"\<\d\+\.\d\+\(e[-+]\=\d\+\)\=\(_\a\w*\)\=\>"


"syn match cdoBoolean	"\.\s*\(True\|False\)\s*\."
syn keyword cdoBoolean   True False 

" pattern matching for comments
syn match   cdoComment	"^\ *#.*$"
syn match   cdoComment    "#.*"

" pattern matching for strings
syn region  cdoString		start=+"+  end=+"+

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cdo_syn_inits")
  if version < 508
    let did_cdo_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cdoBUILTIN     Function
  HiLink cdoCONTRIB     Special
  HiLink cdoKeyword     Keyword
  HiLink cdoOperator    Operator
  HiLink cdoNumber	Number
  HiLink cdoBoolean     Boolean
  HiLink cdoComment	Comment
  HiLink cdoString	String

  delcommand HiLink
endif

let b:current_syntax = "cdo"

" vim: ts=8

