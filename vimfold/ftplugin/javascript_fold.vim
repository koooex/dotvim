" fold javascript code.
" @see http://amix.dk/blog/viewEntry/19132
" @see http://vim.sourceforge.net/scripts/script.php?script_id=515
" @see http://amix.dk/vim/vimrc.html

function! Folding()
    setl foldmethod=syntax

    function! FoldText()
        if &diff
            let b:Start=getline(v:foldstart).' ... '
            let b:End=getline(v:foldend)
        else
            let b:Start=substitute(substitute(getline(v:foldstart),'\t','    ','g'),'{.*','{...','')
            let b:End=substitute(substitute(getline(v:foldend),'\t','    ','g'),'.*}','}','')
        endif
        let b:lines='['.(v:foldend-v:foldstart).' lines]'

        "return b:Start . b:End . repeat(' ',&columns-strlen(b:Start.b:End.b:lines)-8) . b:lines

        let title = b:Start . b:End
        let lines = b:lines
        return g:FormatFoldText(lines, title)
    endfunction
    setl foldtext=FoldText()
endfunction

au BufNewFile,BufRead,BufEnter *.js call Folding()
au BufNewFile,BufRead,BufEnter *.js setl foldenable


