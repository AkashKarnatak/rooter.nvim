if exists('g:loaded_rooter') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

if ! exists('g:rooter_pattern')
    let g:rooter_pattern = v:null
endif

if ! exists('g:outermost_root')
    let g:outermost_root = v:null
endif

lua require'rooter'

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_rooter = 1
