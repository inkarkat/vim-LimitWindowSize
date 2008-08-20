" LimitWindowSize.vim: Reduce the current window size by placing an empty padding window next to it. 
"                                      X                                       X
"                                      X
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"	002	13-Jun-2008	Added -bar to :LimitWindowWidth. 
"	001	10-May-2008	file creation

" Avoid installing twice or when in unsupported VIM version. 
if exists('g:loaded_LimitWindowSize') || (v:version < 700)
    finish
endif
let g:loaded_LimitWindowSize = 1

" This global setting is about the minimum width in the _current_ buffer. 
" Without this setting, jumping into a padding buffer could increase its width. 
set winwidth=1

function! s:GetNetWindowWidth()
    " TODO: signs column
    " TODO: numberwidth is only the minimal width, can be more if buffer has many lines
    return winwidth(0) - &l:foldcolumn - (&l:number ? &l:numberwidth : 0)
endfunction

function! s:HasPaddingWindow()
    let l:winNr = winnr()
    wincmd l
    if bufname('') =~# '^\[Padding\%(\d\+\)\?\]$'
	return 1
    else
	" Return to original window. 
	execute l:winNr . 'wincmd w'
	return 0
    endif
endfunction

function! s:CreatePaddingWindow(width)
    if a:width < 2
	" The vertical window separator (|) takes up one space, and the net
	" width must be at least 1. Smaller widths cannot be created. 
	return
    endif

    " The name of the padding buffer must be unique to avoid an E95 error. 
    let l:paddingName = '[Padding]'
    let l:paddingCnt = 0
    while bufexists(l:paddingName)
	let l:paddingCnt += 1
	let l:paddingName = '[Padding' . l:paddingCnt . ']'
    endwhile

    silent execute 'belowright ' . (a:width - 1) . 'vnew +file\ ' . l:paddingName

    " The padding buffer is read-only and empty. 
    setlocal filetype=nofile
    setlocal statusline=%f  " Show just the padding name in the statusline, no line numbers etc.  
    setlocal nonumber
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nocursorline
    setlocal nocursorcolumn
    " Note: Somehow, the :file command needs to be applied once during opening
    " and once again at the end. Otherwise (when :LimitWindowWidth is executed
    " from a ftplugin), the filename isn't set correctly (it is listed as ""),
    " causing the netrw plugin to take over the padding buffer. 
    " Note: :silent is used to suppress the duplicate "[Padding] 1 line" message
    " which may result from the duplicate :file command. 
    silent execute 'file ' . l:paddingName
endfunction

function! s:LimitWindowWidth(width)
    if a:width <= 0
	echohl ErrorMsg
	echomsg 'Must specify positive window width!'
	echohl None
	return
    endif

    let l:paddingWindowWidth = s:GetNetWindowWidth() - a:width
    if l:paddingWindowWidth == 0
	return
    endif

    let l:winNr = winnr()
    if s:HasPaddingWindow()
	if l:paddingWindowWidth > 0
	    " Must increase existing padding window. 
	    execute l:paddingWindowWidth . 'wincmd >'
	elseif l:paddingWindowWidth < 0
	    if - l:paddingWindowWidth >= winwidth(0)
		" The entire padding window gets eaten by the increased window
		" size, so remove it. 
		wincmd c
	    else
		" Reduce width of padding window. 
		execute - l:paddingWindowWidth . 'wincmd <'
	    endif
	else
	    throw 'Assert: paddingWindowWidth != 0'
	endif
    elseif l:paddingWindowWidth > 0
	call s:CreatePaddingWindow(l:paddingWindowWidth)
    endif

    " Return to original window. 
    execute l:winNr . 'wincmd w'
endfunction

command! -bar -nargs=1 LimitWindowWidth call <SID>LimitWindowWidth(<f-args>)

"****D
function! NetWidth()
    return s:GetNetWindowWidth()
endfunction
" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
