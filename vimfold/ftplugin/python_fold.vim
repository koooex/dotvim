if exists('b:loaded_simplefold')
    finish
endif
let b:loaded_simplefold = 1

let s:blank_regex = '^\s*$'
let s:def_regex = '^\s*\%(class\|def\) \w\+'
let s:docstring_start_regex = '^\s*\("""\|''''''\)\%(.*\1\s*$\)\@!'
let s:docstring_end_single_regex = '''''''\s*$'
let s:docstring_end_double_regex = '"""\s*$'

" Determine the number of containing class or function definitions for the
" given line
function! s:NumContainingDefs(lnum)

    " Recall memoized result if it exists in the cache
    if has_key(b:cache_NumContainingDefs, a:lnum)
        return b:cache_NumContainingDefs[a:lnum]
    endif

    let this_ind = indent(a:lnum)

    if this_ind == 0
        return 0
    endif

    " Walk backwards to the previous non-blank line with a lower indent level
    " than this line
    let i = a:lnum - 1
    while 1
        if getline(i) !~ s:blank_regex
            let i_ind = indent(i)
            if i_ind < this_ind
                let ncd = s:NumContainingDefs(i) + (getline(i) =~ s:def_regex)
                break
            elseif i_ind == this_ind && has_key(b:cache_NumContainingDefs, i)
                let ncd = b:cache_NumContainingDefs[i]
                break
            endif
        endif

        let i -= 1

        " If we hit the beginning of the buffer before finding a line with a
        " lower indent level, there must be no definitions containing this
        " line. This explicit check is required to prevent infinite looping in
        " the syntactically invalid pathological case in which the first line
        " or lines has an indent level greater than 0.
        if i <= 1
            let ncd = getline(1) =~ s:def_regex
            break
        endif

    endwhile

    " Memoize the return value to avoid duplication of effort on subsequent
    " lines
    let b:cache_NumContainingDefs[a:lnum] = ncd

    return ncd

endfunction

" Compute fold level for Python code
function! SimpleFold(lnum)

    " If we are starting a new sweep of the buffer (i.e. the current line
    " being folded comes before the previous line that was folded), initialize
    " the cache of results of calls to `s:NumContainingDefs`
    if !exists('b:last_folded_line') || b:last_folded_line > a:lnum
        let b:cache_NumContainingDefs = {}
        let b:in_docstring = 0
    endif
    let b:last_folded_line = a:lnum

    " If this line is blank, its fold level is equal to the minimum of its
    " neighbors' fold levels, but if the next line begins a definition, then
    " this line should fold at one level below the next
    let line = getline(a:lnum)
    if line =~ s:blank_regex
        let next_line = nextnonblank(a:lnum)
        if next_line == 0
            return 0
        elseif getline(next_line) =~ s:def_regex
            return SimpleFold(next_line) - 1
        else
            return -1
        endif
    endif

    let docstring_match = matchlist(line, s:docstring_start_regex)
    if !b:in_docstring && len(docstring_match)
        let this_fl = s:NumContainingDefs(a:lnum) + 1
        let b:in_docstring = 1
        if docstring_match[1] == '"""'
            let b:docstring_end_regex = s:docstring_end_double_regex
        else
            let b:docstring_end_regex = s:docstring_end_single_regex
        endif
    elseif b:in_docstring
        let this_fl = s:NumContainingDefs(a:lnum) + 1
        if line =~ b:docstring_end_regex
            let b:in_docstring = 0
        endif
    else
        " Otherwise, its fold level is equal to its number of containing
        " definitions, plus 1, if this line starts a definition of its own
        let this_fl = s:NumContainingDefs(a:lnum) + (line =~ s:def_regex)

    endif
    " If the very next line starts a definition with the same fold level as
    " this one, explicitly indicate that a fold ends here
    if getline(a:lnum + 1) =~ s:def_regex && SimpleFold(a:lnum + 1) == this_fl
        return '<' . this_fl
    else
        return this_fl
    endif

endfunction

function! MySimpleFold(lnum)
    " Determine folding level in Python source
    "
    let line = getline(a:lnum)
    let ind  = indent(a:lnum)

    " Ignore blank lines
    if line =~ '^\s*$'
        return "="
    endif

    " Ignore triple quoted strings
    if line =~ "(\"\"\"|''')"
        return "="
    endif

    " Ignore continuation lines
    if line =~ '\\$'
        return '='
    endif

    " Support markers
    if line =~ '{{{'
        return "a1"
    elseif line =~ '}}}'
        return "s1"
    endif

    " Classes and functions get their own folds
    if line =~ '^\s*\(if\|while\|with\|for\|class\|def\)\s'
        return ">" . (ind / &sw + 1)
    endif

    let pnum = prevnonblank(a:lnum - 1)

    if pnum == 0
        " Hit start of file
        return 0
    endif

    " If the previous line has foldlevel zero, and we haven't increased
    " it, we should have foldlevel zero also
    if foldlevel(pnum) == 0
        return 0
    endif

    " The end of a fold is determined through a difference in indentation
    " between this line and the next.
    " So first look for next line
    let nnum = nextnonblank(a:lnum + 1)
    if nnum == 0
        return "="
    endif

    " First I check for some common cases where this algorithm would
    " otherwise fail. (This is all a hack)
    let nline = getline(nnum)
    if nline =~ '^\s*\(except\|else\|elif\)'
        return "="
    endif

    " Python programmers love their readable code, so they're usually
    " going to have blank lines at the ends of functions or classes
    " If the next line isn't blank, we probably don't need to end a fold
    if nnum == a:lnum + 1
        return "="
    endif

    " If next line has less indentation we end a fold.
    " This ends folds that aren't there a lot of the time, and this sometimes
    " confuses vim.  Luckily only rarely.
    let nind = indent(nnum)
    if nind < ind
        return "<" . (nind / &sw + 1)
    endif

    " If none of the above apply, keep the indentation
    return "="
endfunction

function! FoldText()
    let title = getline(v:foldstart)
    let nnum = nextnonblank(v:foldstart + 1)
    let nextline = getline(nnum)
    if nextline =~ '^\s\+"""$'
        let title = title . getline(nnum + 1)
    elseif nextline =~ '^\s\+"""'
        let title = title . ' ' . matchstr(nextline, '"""\zs.\{-}\ze\("""\)\?$')
    elseif nextline =~ '^\s\+"[^"]\+"$'
        let title = title . ' ' . matchstr(nextline, '"\zs.*\ze"')
    elseif nextline =~ '^\s\+pass\s*$'
        let title = title . ' pass'
    endif

    let size = v:foldend - v:foldstart + 1

    return g:FormatFoldText(size, title)
endfunction

setlocal foldtext=FoldText()
setlocal foldexpr=MySimpleFold(v:lnum)
setlocal foldmethod=expr
