" fold vim function code.

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= ' | '
else
    let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde< fdt<'


setlocal foldmethod=expr 
setlocal foldexpr=VimFold(v:lnum)
setlocal foldtext=VimFoldText()

if exists('*VimFold')
  finish
endif

function! VimFold(lnum)
  let line = getline(a:lnum)
  let next = getline(a:lnum + 1)
  let [ms, me] = split(&foldmarker, ',')
  let lv = 0
  while 0 <= stridx(line, ms)
    let marker = matchstr(line, '\V' . escape(ms, '\') . '\zs\d\*')
    if marker != ''
      return '>' . marker
    endif
    let line = substitute(line, '\V' . escape(ms, '\'), '', '')
    let lv += 1
  endwhile

  while 0 <= stridx(line, me)
    let marker = matchstr(line, '\V' . escape(me, '\') . '\zs\d\*')
    if marker != ''
      return '<' . marker
    endif
    let line = substitute(line, '\V' . escape(me, '\'), '', '')
    let lv -= 1
  endwhile

  if line =~# '^\s*:\?\s*endf\%[unction]\>'
  \   || line =~# '^\s*:\?\s*aug\%[roup]\s\+END'
    let lv -= 1
  elseif line =~# '^\s*:\?\s*fu\%[nction]'
  \   || line =~# '^\s*:\?\s*aug\%[roup]'
    let lv += 1
  endif
  if line =~# '^\s*\\'
    if next !~# '^\s*\\'
      let lv -= 1
    endif
  elseif next =~# '^\s*\\'
    let lv += 1
  endif

  return lv == 0 ? '=' :
  \      lv <  0 ? 's' . -lv :
  \                'a' . lv
endfunction

function! VimFoldText()
    let b:title = getline(v:foldstart)
    let b:linenr = v:foldstart + 1
    while getline(b:linenr) =~ '^\s*\\'
        let b:title .= matchstr(getline(b:linenr), '^\s*\\\s\{-}\zs\s\?\S.*$')
        let b:linenr += 1
    endwhile
    let b:count=(v:foldend-v:foldstart+1)
    return g:FormatFoldText(b:count, b:title)
endfunction



