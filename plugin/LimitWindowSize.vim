" LimitWindowSize.vim: Reduce the current window size by placing an empty padding window next to it. 
" LimitWindowSize.vim: Reduce the curreXt window size by placing an empty paddiX
" LimitWindowSize.vim: Reduce the curreX
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"	001	10-May-2008	file creation

" Avoid installing twice or when in unsupported VIM version. 
if exists('g:loaded_LimitWindowSize') || (v:version < 700)
    finish
endif
let g:loaded_LimitWindowSize = 1

function! s:GetNetWindowWidth()
    " TODO: signs column
    " TODO: numberwidth is only the minimal width, can be more if buffer has many lines
    return winwidth(0) - &l:foldcolumn - (&l:number ? &l:numberwidth : 0)
endfunction

function! s:LimitWindowWidth(width)
    if a:width <= 0
	echohl Error
	echomsg 'Must specify positive window width!'
	echohl None
	return
    endif

    let l:winNr = winnr()
    let l:paddingWindowWidth = s:GetNetWindowWidth() - a:width - 1
    if l:paddingWindowWidth > 0
	execute 'belowright ' . l:paddingWindowWidth . 'vnew +file\ [Padding]' 
	setlocal filetype=
	setlocal nonumber
	setlocal bufhidden=delete
	setlocal buftype=nofile
	setlocal noswapfile
	setlocal nobuflisted
	setlocal nomodifiable
	setlocal nocursorline
	setlocal nocursorcolumn
	wincmd p
    endif
endfunction

command! -nargs=1 LimitWindowWidth call <SID>LimitWindowWidth(<f-args>)

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
