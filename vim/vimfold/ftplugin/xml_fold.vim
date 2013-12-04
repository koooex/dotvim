" Vim folding file
" Language:	Python
" Author:	Jorrit Wiersma (foldexpr), Max Ischenko (foldtext), Robert
" Ames (line counts)
" Last Change:	2005 Jul 14
" Version:	2.3
" Bug fix:	Drexler Christopher, Tom Schumm, Geoff Gerrietts
"
"
function! FoldText()
    let title = getline(v:foldstart)
    let size = 1 + v:foldend - v:foldstart
    return g:FormatFoldText(size, title)
endfunction

setlocal foldtext=FoldText()

