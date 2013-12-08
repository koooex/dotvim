"
"======================================================================
"   Author: Sam [kooex@gmail.com]
"  Version: 0.1
"  Changed: 05/03/2011 15:45:37
"  History:
"======================================================================
"
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global variable
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("mac")
    let g:OS#win  = 0
    let g:OS#mac  = 1
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#win  = 0
    let g:OS#mac  = 0
    let g:OS#unix = 1
else
    let g:OS#win  = 1
    let g:OS#mac  = 0
    let g:OS#unix = 0
endif

if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use bundle plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:OS#win
    set rtp+=~/dotvim/vimdoc
    set rtp+=~/dotvim/vimfold
    set rtp+=~/dotvim/bundle/vundle/
    call vundle#rc("$HOME/dotvim/bundle")
else
    set rtp+=~/.vim/vimdoc
    set rtp+=~/.vim/vimfold
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
endif

Bundle 'vundle'

Bundle 'clang-complete'
Bundle 'SirVer/ultisnips'
Bundle 'Shougo/neocomplete.vim'
Bundle 'koooex/neocomplete-ultisnips'

Bundle 'Tabular'
Bundle 'EasyMotion'
Bundle 'Auto-Pairs'
Bundle 'surround.vim'
Bundle 'ZenCoding.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/Gundo'
Bundle 'terryma/vim-expand-region'
Bundle 'terryma/vim-multiple-cursors'

Bundle 'ctrlp.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'

Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'hdima/python-syntax'
Bundle 'matchit.zip'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:OS#gui
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    set showtabline=0
    set gcr=a:blinkon0
endif

if g:OS#win
    set lines=38
    set columns=130
    set linespace=0

    set gfn=PowerMonaco:h8:cANSI
    " set gfn=Consolas:h10:cANSI
    " set gfn=Courier:h10:cANSI
    " set gfw=Microsoft_YaHei:h9

    lang message en_US
    autocmd! bufwritepost vimrc source $HOME/dotvim/vimrc
elseif g:OS#unix
    set t_Co = 8
else
    if g:OS#gui
        set lines=38
        set columns=120

        " set gfn=Monaco:h11
        " set gfw=MicrosoftYaHei:h12
        set gfn=PowerMonaco:h11
        set gfw=PowerMonaco:h11
    else
        set t_Co=16

        for i in range(65, 90) + range(97, 122)
            exe "set <M-".nr2char(i).">=\<Esc>".nr2char(i)
        endfor
        set notimeout
        set ttimeout
        set ttimeoutlen=50

        set lines=36
        set columns=118
        set linespace=3
    endif

    set title
    set titleold=Terminal
    set titlestring=Vim:\ %{expand('%:p:~')}

    runtime! ftplugin/man.vim
    autocmd! bufwritepost .vimrc source $HOME/.vimrc
endif

if exists('&autochdir')
    set bsdir=buffer
    set autochdir
endif

if exists('&autoread')
    set autoread
endif

if exists("&macmeta")
    set macmeta
endif

"
" if exists("&transp")
"     set transp=8
" endif
"
" if has("persistent_undo")
"     set undofile
"     set undolevels=1000
"     set undodir=$undodir
"
"     au BufWritePre undodir/* setlocal noundofile
" endif
"
set mouse=a

set history=500
set helplang=cn
set ambiwidth=single

set ruler
set number
set hidden

" set ve=onemore
"
set wildmenu
set wildmode=longest:full,full
" set wildchar=<Tab>
"
set wildignore+=*.o,*.obj
set wildignore+=*.pyc,*.pyo
set wildignore+=*.gz,*.zip,*.bz2
set wildignore+=*.class,*.jar,*.war
set wildignore+=*.a,*.so,*.dylib,*.lib,*.dll

set magic
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase

set cindent
set autoindent
set smartindent

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set so=3
set wrap
set fo-=t
set fo+=lnmM
set textwidth=78
set linebreak
"set flp+=  " Default is enough, when 'n' mark is used in fo option

set report=0        " tell us when anything is changed via :...
set matchtime=5     " how long to blink matching brackets for
set shortmess=aOtTI " short message to avoid 'press a key' prompt

set showcmd
set cmdheight=2
set nolist
set listchars=tab:>-,trail:-,eol:$
set backspace=indent,eol,start

set enc=utf-8
set fenc=utf-8
set ffs=unix,dos,mac
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

syntax on

set cursorline
set nocursorcolumn
set colorcolumn=+20

if g:OS#gui
    set background=light
else
    set background=dark
endif

filetype plugin indent on

runtime! macros/matchit.vim

let g:html_dynamic_folds = 1
"runtime! syntax/2html.vim

""""""""""""""""""""""""""""""
" => Folding
"
""""""""""""""""""""""""""""""
set foldenable
set foldlevel=10
set foldmethod=syntax
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds

set fillchars=fold:\ ,vert:\|

function! g:FormatFoldText(lines, title)
    return a:title . ' ' . repeat('-', 84 - strlen(a:title)) . '[' . printf("%-2d", a:lines) . ' lines]'
endfunction

""""""""""""""""""""""""""""""
" => File and backup
"
""""""""""""""""""""""""""""""
set nowb
set nobackup
set noswapfile

""""""""""""""""""""""""""""""
" => GuiTabLabel
"
""""""""""""""""""""""""""""""
"
if exists("+guitablabel")
    function! GuiTabLabel()
        let label = ''
        let bufnrlist = tabpagebuflist(v:lnum)

        " 如果标签页里有修改过的缓冲区，加上 '+'
        for bufnr in bufnrlist
            if getbufvar(bufnr, "&modified")
                let label = ' +'
                break
            endif
        endfor

        " 附加缓冲区名
        return bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]).label
    endfunction

    set guitablabel=%{GuiTabLabel()}
endif

""""""""""""""""""""""""""""""
" => Keymap
"
""""""""""""""""""""""""""""""
let mapleader = ","

"
" Testing tab-behaviour in MacVim/Terminal
"
" nnoremap <special> <Tab>     :echo "Got Tab"<CR>
" nnoremap <special> <M-Tab>   :echo "Got Alt-Tab"<CR>
" nnoremap <special> <C-Tab>   :echo "Got Ctrl-Tab"<CR>
" nnoremap <special> <S-Tab>   :echo "Got Shift-Tab"<CR>
" nnoremap <special> <M-a>     :echo "Got Alt-a"<CR>
" nnoremap <special> <M-b>     :echo "Got Alt-b"<CR>

" Maps for switching window.
nnoremap <C-j>      <C-W>j
nnoremap <C-k>      <C-W>k
nnoremap <C-h>      <C-W>h
nnoremap <C-l>      <C-W>l

" Maps for switching buffers.
nnoremap <S-Right>  :bnext<cr>
nnoremap <S-Left>   :bprevious<cr>

" Move a line of text using SHIFT+[jk]
" Idea: http://vim.wiki.ifi.uio.no/Runarfu.vimrc
nnoremap <S-Up>      mz:m-2<cr>`z
nnoremap <S-Down>    mz:m+<cr>`z
vnoremap <S-Up>     :m'<-2<cr>`>my`<mzgv`yo`z
vnoremap <S-Down>   :m'>+<cr>`<my`>mzgv`yo`z

" Move cursor in insert mode
inoremap <A-h>      <Left>
inoremap <A-j>      <Down>
inoremap <A-k>      <Up>
inoremap <A-l>      <Right>

" indent with tab in normal and visual mode
" nmap     <Tab>       v>
" nmap     <S-Tab>     v<
" vmap     <Tab>      >gv
" vmap     <S-Tab>    <gv

nmap     <space>     :

nnoremap  /         /\v
nnoremap  ?         ?\v
vnoremap  /         /\v
vnoremap  ?         ?\v

nnoremap  j          gj
nnoremap  k          gk

nnoremap  -          zc
nnoremap  +          zo

" auto wrap selection in mode-v
vnoremap  '          s''<Esc>P<Right>
vnoremap  "          s""<Esc>P<Right>
vnoremap  `          s``<Esc>P<Right>

" yank from current line to the EOF
noremap  <silent> <leader>yy  "+y
" paste from clipboard
noremap  <silent> <leader>pp  "+p

nnoremap <silent> <leader>w   :w<cr>
nnoremap <silent> <leader>z    ZZ
nnoremap <silent> <leader>bd  :bd!<cr>
nnoremap <silent> <leader>qa  :qa!<cr>

nnoremap <silent> <leader>tl  :set list!<cr>
nnoremap <silent> <leader>th  :nohlsearch<cr>
nnoremap <silent> <leader>tc  :set cursorcolumn!<cr>

nnoremap <silent> <leader>W   :%s/\s\+$//<cr>:let @/=''<cr>
nnoremap <silent> <leader>S    V`]

" auto switch to sudo mode
command! W w !sudo tee % > /dev/null
" cnoreab  <silent>         W    w

" auto delete trailing space
" autocmd BufWritePre * :%s/\s\+$//<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dynamic bind <HOME> and <END> key
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" if caret/cursor not at the frist non-white-space character
"   move caret/cursor to there
" else
"   move to beginning
"
function! HomeBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "^\\s\\+", "", "")
    let x=len(s0)-len(s1)+1
    if col('.') == x-a:offset
        let x=1
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction

imap <silent> <Home> <Esc>:call HomeBind(1)<cr>i
nmap <silent> <Home> :call HomeBind(0)<cr>
vmap <silent> <Home> <Esc>:call HomeBind(1)<cr>

"
" if caret/cursor not at the end
"   move caret/cursor to there
" else
"   move to last non-white-space character.
"
function! EndBind(offset)
    let cursor=getpos('.')
    let s0=getline(line('.'))
    let s1=substitute(s0, "\\s*$", "", "")
    let x=len(s0)+a:offset
    if col('.') == x
        let x=len(s1)+a:offset
    endif
    call setpos('.', [cursor[0], cursor[1], x, cursor[3]])
endfunction

imap <silent> <End> <Esc>:call EndBind(0)<cr>a
nmap <silent> <End> :call EndBind(0)<cr>
vmap <silent> <End> :call EndBind(0)<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle column color
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
function! ToggleColumnColor()
    let col = virtcol('.')
    let cclist = split(&cc, ',')
    if count(cclist, string(col)) <= 0
        execute "set cc+=".col
    else
        execute "set cc-=".col
    endif
endfunction

map <silent> <F11> :call ToggleColumnColor()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在当前文件中快速查找光标下的单词, 并在 Location 显示
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>lv :lv /<C-R>=expand("<cword>")<CR>/ %<CR>:lw<CR><ESC>

""""""""""""""""""""""""""""""
" => Statusline
"
""""""""""""""""""""""""""""""
" Always use the statusline
set laststatus=2

function! g:has_plugin(name)
    let pat = 'plugin/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

if g:has_plugin('airline')
    let g:airline_inactive_collapse = 0
    "let g:airline_exclude_filetypes = ['help']

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_powerline_fonts = 1
    let g:airline_left_sep = '⮀'
    let g:airline_left_alt_sep = '⮁'
    let g:airline_right_sep = '⮂'
    let g:airline_right_alt_sep = '⮃'

    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'

    """ Unicode symbols """
    " let g:airline_symbols.linenr = '␊'
    " let g:airline_symbols.linenr = '␤'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.branch = '⎇'
    " let g:airline_symbols.paste = 'ρ'
    " let g:airline_symbols.paste = 'Þ'
    " let g:airline_symbols.paste = '∥'
    " let g:airline_symbols.whitespace = 'Ξ'

    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#whitespace#symbol = '@'
    let g:airline#extensions#whitespace#checks = ['indent', 'trailing']
    let g:airline#extensions#whitespace#show_message = 1
    let g:airline#extensions#whitespace#trailing_format = '%s!'
    let g:airline#extensions#whitespace#mixed_indent_format = '%s-'

    " let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['o', 'x', 'y', 'z', 'warning']]
    "
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create(['%t %m%w%q'])
    let g:airline_section_c = airline#section#create(["%{fnamemodify(getcwd(),':p:~:h')}"])
    " let g:airline_section_c = airline#section#create(["%{expand('%:p:~:h')}"])

    " let g:airline_section_x = airline#section#create(["0x%02B"])
    " let g:airline_section_y = airline#section#create(["%l:%L:%p%%, %c"])
    let g:airline_section_x = airline#section#create([""])
    let g:airline_section_y = airline#section#create(["%{strlen(&filetype)?&filetype:'none'}, %{&encoding}, %{&fileformat}"])
    let g:airline_section_z = airline#section#create(["%p%% ⭡ %l:%L, %c, 0x%02B"])
    "let g:airline_section_z = airline#section#create(["%{strftime('%m/%d/%Y\ %H:%M',getftime(expand('%')))}"])

    " let g:airline#extensions#tagbar#enabled = 0
    " let g:airline_exclude_filetypes = ['tagbar']

    " function! MyTagbarStatusline()
    "     let text = g:tagbar_sort ? 'n' : 'o'
    "     let filename = 'blank'
    "     if !empty(s:known_files.getCurrent())
    "         let filename = fnamemodify(s:known_files.getCurrent().fpath, ':t')
    "     endif
    "     return '-'.text.'-'.filename.'-'
    " endfunction

    " autocmd FileType tagbar setlocal statusline=%!MyTagbarStatusline()
else
    set statusline=
    set statusline+=\ %t\ %m%w%q
    set statusline+=\ [%{strlen(&filetype)?&filetype:'none'},%{&encoding},%{&fileformat}]
    set statusline+=\ [%l:%L:%p%%,%c,0x%02B]
    " set statusline+=\ \ %{synIDattr(synID(line('.'),col('.'),1),'name')}
    " set statusline+=\ \ %<@@%{expand('%:p:~:h')}
    set statusline+=\ \ %<@@%{fnamemodify(getcwd(),':p:~:h')}
    set statusline+=%=
    set statusline+=\ %{strftime('%m/%d/%Y\ %H:%M',getftime(expand('%')))} 
    set statusline+=\ 
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gundo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <F7>  :GundoToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_left = 1
let g:tagbar_sort = 1
let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0

noremap <silent> <F5>  :TagbarToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ColorScheme
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let g:solarized_bold = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256
let g:solarized_visibility = 'normal'

function! g:has_colors(name)
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

if g:has_colors('solarized')
    colorscheme solarized
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The default configuration defines the following mappings in normal,
" visual and operator-pending mode:
"
"     Mapping           | Details
"     ------------------|----------------------------------------------
"     <Leader>f{char}   | Find {char} to the right. See |f|.
"     <Leader>F{char}   | Find {char} to the left. See |F|.
"     <Leader>t{char}   | Till before the {char} to the right. See |t|.
"     <Leader>T{char}   | Till after the {char} to the left. See |T|.
"     <Leader>w         | Beginning of word forward. See |w|.
"     <Leader>W         | Beginning of WORD forward. See |W|.
"     <Leader>b         | Beginning of word backward. See |b|.
"     <Leader>B         | Beginning of WORD backward. See |B|.
"     <Leader>e         | End of word forward. See |e|.
"     <Leader>E         | End of WORD forward. See |E|.
"     <Leader>ge        | End of word backward. See |ge|.
"     <Leader>gE        | End of WORD backward. See |gE|.
"     <Leader>j         | Line downward. See |j|.
"     <Leader>k         | Line upward. See |k|.
"     <Leader>n         | Jump to latest "/" or "?" forward. See |n|.
"     <Leader>N         | Jump to latest "/" or "?" backward. See |N|.
"
" See |easymotion-leader-key| and |mapleader| for details about the leader key.
" See |easymotion-custom-mappings| for customizing the default mapping.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" expand_region.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map + <plug>(expand_region_expand)
" map _ <plug>(expand_region_shrink)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <Leader>be  - Opens BE.
" <Leader>bs  - Opens horizontally window BE.
" <Leader>bv  - Opens vertically window BE.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surround.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Old text                  Command     New text ~
"  "Hello *world!"           ds"         Hello world!
"  [123+4*56]/2              cs])        (123+456)/2
"  "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
"  if *x>3 {                 ysW(        if ( x>3 ) {
"  my $str = *whee!;         vlllls'     my $str = 'whee!';
"  "Hello *world!"           ds"         Hello world!
"  (123+4*56)/2              ds)         123+456/2
"  <div>Yo!*</div>           dst         Yo!
"  Hello w*orld!             ysiw)       Hello (world)!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDComment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"[count],cl    |NERDComAlignedComment|
"[count],cu    |NERDComUncommentLine|
"
let g:NERDCompactSexyComs = 0
let g:NERDSpaceDelims = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
noremap <silent> <F6>  :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Zencoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let g:user_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<C-Y>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax: javascript.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let g:javascript_enable_domhtmlcss = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax: python.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let python_highlight_all = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
autocmd FileType python syn keyword pythonDecorator True None False self
autocmd FileType python noremap <silent> <F7> :PyflakesUpdate<CR>:cw<CR>
autocmd FileType Makefile setlocal noexpandtab
autocmd FileType c    setlocal makeprg=gcc\ -Wall\ -o\ %<\ %
autocmd FileType cpp  setlocal makeprg=g++\ -Wall\ -o\ %<\ %
autocmd FileType java setlocal makeprg=javac\ -d\ .\ %

autocmd BufRead,BufNewFile *.txt  set filetype=txt
autocmd BufRead,BufNewFile *.log  set filetype=log
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.vm   set filetype=velocity
autocmd BufRead,BufNewFile *.js,*.javascript set filetype=javascript
autocmd BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 softtabstop=2

" When editing a file, always jump to the last known cursor position.
"
autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabular.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
nmap <Leader>a=     :Tabularize /=<CR>
vmap <Leader>a=     :Tabularize /=<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
nmap <Leader>a:     :Tabularize /:\zs<CR>
vmap <Leader>a:     :Tabularize /:\zs<CR>
nmap <Leader>a,     :Tabularize /,\zs<CR>
vmap <Leader>a,     :Tabularize /,\zs<CR>

inoremap <silent><Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(":Tabularize") && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetDirectories = ["snippets"]
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets        = "<c-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang_complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let g:clang_use_library = 1
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1
" let g:clang_sort_algo = 'alpha'

if g:OS#mac
    let g:clang_library_path = '/usr/local/llvm/lib'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"     智能补全                       CTRL-X CTRL-O
"     向上补全                       CTRL-X CTRL-P
"     向下补全                       CTRL-X CTRL-N
"
"       下拉菜单显示所有匹配的标签,
"       可以用 CTRL-P 和 CTRL-N 上下选择，
"       可以用 CTRL-E 停止补全并回到原来录入的文字
"       可以用 CTRL-Y 可以停止补全，并接受当前所选的项目
"
" vim中其它的补全方式包括：
"     整行补全                        CTRL-X CTRL-L
"     根据当前文件里关键字补全        CTRL-X CTRL-N
"     根据字典补全                    CTRL-X CTRL-K
"     根据同义词字典补全              CTRL-X CTRL-T
"     根据头文件内关键字补全          CTRL-X CTRL-I
"     根据标签补全                    CTRL-X CTRL-]
"     补全文件名                      CTRL-X CTRL-F
"     补全宏定义                      CTRL-X CTRL-D
"     补全vim命令                     CTRL-X CTRL-V
"     用户自定义补全方式              CTRL-X CTRL-U
"     拼写建议                        CTRL-X CTRL-S
"
" 直到使用其它的补全命令改变它；
" 如果把它设成2，意味着记住上次的补全方式，直到按ESC退出插入模式为止；
" 如果设为0，意味着不记录上次的补全方式。
"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_ignore_case = 0
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#enable_insert_char_pre = 0
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#cursor_hold_i_time = 300
let g:neocomplete#enable_refresh_always = 0

" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

set pumheight=15
set completeopt=menu,longest
"set completeopt=longest,menu,preview

function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

function! s:my_smart_tab()
    call UltiSnips_ExpandSnippetOrJump()

    if g:ulti_expand_or_jump_res > 0
        return ""
    elseif s:check_back_space()
        return "\<tab>"
    elseif pumvisible()
        return "\<c-n>"
    else
        return neocomplete#start_manual_complete()
    endif
endfunction

let g:UltiSnipsExpandTrigger       = "<c-\>"
let g:UltiSnipsJumpForwardTrigger  = "<c-\>"
inoremap <silent><Tab> <C-R>=<SID>my_smart_tab()<CR>
snoremap <silent><Tab> <Esc>:call UltiSnips_ExpandSnippetOrJump()<CR>

inoremap <expr><c-u>   neocomplete#start_manual_complete()
inoremap <expr><c-h>   neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><c-g>   neocomplete#undo_completion()
inoremap <expr><c-l>   neocomplete#complete_common_string()
inoremap <expr>j       pumvisible() ? "\<C-N>" : "j"
inoremap <expr>k       pumvisible() ? "\<C-P>" : "k"
inoremap <expr><BS>    neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><CR>    pumvisible() ? neocomplete#close_popup() : "\<CR>"
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
" inoremap <expr><Esc>   pumvisible() ? neocomplete#cancel_popup() : "\<Esc>"
" inoremap <expr><Up>    pumvisible() ? "\<C-P>" : "\<Up>"
" inoremap <expr><Down>  pumvisible() ? "\<C-N>" : "\<Down>"
" inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
" inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cpp setlocal omnifunc=ClangComplete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" let g:neocomplete#force_overwrite_completefunc = 0
" if !exists('g:neocomplete#force_omni_input_patterns')
"     let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" 在对C++文件进行补全时，
"
" ctags -R --c++-kinds=+plx --java-kinds=+l --fields=+aiKSz --extra=+q .<CR>
"
" 需要tag文件中包含C++的额外信息，
" 因此上面的ctags命令不同于以前我们所使用的，它专门为C++语言生成一些额外的信息,
" 上述选项的含义如下：
"
" --c++-kinds=+p  : 为C++文件增加函数原型的标签
" --fields=+iaS   : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
" --extra=+q      : 为标签增加类修饰符。注意，如果没有此选项，将不能对类成员补全
"
" <C-]> : 转到函数定义
"    gd : 转到局部变量
"    gD : 转到全局变量
"    gf : 打开头文件
"
"  ( | ) : 句子跳转
"  { | } : 反向或正向跳转到第一个空行 段落
" [{ | ]} : 反向或正向跳转到上一层代码块
" [# | ]# : 反向或正向跳转到宏定义处
" [( | ]) : 反向或正向跳转到未匹配的括号
" [[ | [] | ][ | ]]  : 反向或正向跳转到出现在首列的 { 或 }
" [m | [M | ]m | ]M  : 反向或正向跳转到方法的开始和结束处 (或上一个或下一个方法)
" [* | [/ | ]* | ]/  : 反向或正向跳转到注释的开始和结束处
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cscope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" 按照vim里cscope的参考手册
"
" cscope -Rbkq
"
" 这个命令会生成三个文件：cscope.out, cscope.in.out, cscope.po.out。其中
" cscope.out是基本的符号索引，后两个文件是使用”-q”选项生成的，可以加cscope
" 的索引速度。上面所用到的命令参数，含义如下：
"    -R: 在生成索引文件时，搜索子目录树中的代码
"    -b: 只生成索引文件，不进入cscope的界面
"    -k: 在生成索引文件时，不搜索/usr/include目录
"    -q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
"
" 接下来，就可以在vim里读代码了。不过在使用过程中，发现无法找到C++的类、函数定
" 义、调用关系。仔细阅读了cscope的手册后发现，原来cscope在产生索引文件时，只搜
" 索类型为C, lex和yacc的文件(后缀名为.c, .h, .l, .y)，C++的文件根本没有生成索
" 引。
" 不过按照手册上的说明，cscope支持c++和Java语言的文件。于是按照cscope手册
" 上提供的方法，先产生一个文件列表，然后让cscope为这个列表中的每个文件都生成索
" 引。为了方便使用，编写了下面的脚本来更新cscope和ctags的索引文件：
"
" #!/bin/sh
"
" find . -name '*.h' -o -name '*.c' -o name '*.cpp' -o -name '*.java' > cscope.files
" cscope -bkq -i cscope.files
"
" 这个脚本，首先使用find命令，查找当前目录及子目录中所有后缀名为”.h”, “.c”
" 和”.cc”的文件，并把查找结果重定向到文cscope.files中。然cscope根据
" cscope.files中的所有文件，生成符号索引文件。
"
" cscope 的常用选项：
"    -R: 在生成索引文件时，搜索子目录树中的代码
"    -b: 只生成索引文件，不进入cscope的界面
"    -q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
"    -k: 在生成索引文件时，不搜索/usr/include目录
"    -i: 如果保存文件列表的文件名不是cscope.files时，
"          需要加此选项告诉cscope到哪儿去找源文件列表
"    -Idir: 在-I选项指出的目录中查找头文件
"    -u: 扫描所有文件，重新生成交叉索引文件
"    -C: 在搜索时忽略大小写
"    -Ppath: 在以相对路径表示的文件前加上的path，这样，
"              你不用切换到你数据库文件所在的目录也可以使用它了。
"
" cscope find 选项
"    s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
"    g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
"    d: 查找本函数调用的函数
"    c: 查找调用本函数的函数
"    t: 查找指定的字符串
"    e: 查找egrep模式，相当于egrep功能，但查找速度快多了
"    f: 查找并打开文件，类似vim的find功能
"    i: 查找包含本文件的文件
"
if has("cscope")
    set cst
    set csto=1
    set csverb
    set cspc=0
    "set cscopequickfix=s-,g-,c-,d-,i-,t-,e-

    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle maximun window
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
if g:OS#gui
    let s:lines = str2nr(&lines)
    let s:columns = str2nr(&columns)

    function! ToggleMaximumWindow()
        if s:lines != &lines
            let &lines = s:lines
            let &columns = s:columns
        else
            set lines=999
            set columns=999
        endif
    endfunction

    command! -nargs=0 ToggleMaximunWindow :call ToggleMaximumWindow()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open native explorer
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
function! FileExplorer(...)
    if a:0 == 0
        let p = g:OS#win ? expand("%:p") : expand("%:p:h")
    else
        let p = a:1
    endif

    if g:OS#win && exists("+shellslash") && &shellslash
        let p = substitute(p, "/", "\\", "g")
    endif

    if executable("chcp")
        let code_page = 'cp' . matchstr(system("chcp"), "\\d\\+")
    else
        let code_page = 'cp936'
    endif

    if g:OS#win && (&enc!=code_page)
        let p = iconv(p, &enc, code_page)
    endif

    if g:OS#win
        exec ":silent !start explorer /select, " . p
    else
        exec ':silent !open "' . p . '"'
    endif

    redraw!
endfunction

command! -nargs=? -complete=dir OpenFileExplorer :call FileExplorer(<args>)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HiFold
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
function! HiFold(...)
    if a:0 == 0
        let tab2space = repeat(nr2char(32), &ts)
        let g:HiStr = '\t\|'.tab2space
    else
        let g:HiStr = a:1
    endif

    let g:hiLen=strlen(substitute(g:HiStr, ".", "x", "g"))

    setlocal fillchars="fold:"
    setlocal foldmethod=expr
    setlocal foldexpr=HiFoldExpr(v:lnum)
    setlocal foldtext=HiFoldText()
endfunction

function! HiGetIndent(line)
    let b:c = 1
    while 1
        let shead = '^\(' . g:HiStr . '\)\{' . string(b:c) . '}'
        if a:line !~ shead
            break
        endif
        let b:c += 1
    endwhile

    return (b:c)
endfunction

function! HiFoldExpr(lnum)
    if getline(a:lnum) !~ '\S'
        return "="
    endif

    let b:p = HiGetIndent(getline(prevnonblank(a:lnum)))
    let b:n = HiGetIndent(getline(nextnonblank(a:lnum+1)))
    if b:n == b:p
        return "="
    elseif b:n > b:p
        return ">" . b:p
    else
        return "<" . b:n
    endif
endfunction

function! HiFoldText()
    let b:count = v:foldend - v:foldstart + 1
    let b:title = getline(v:foldstart)
    return g:FormatFoldText(b:count, b:title)
endfunction

command! -nargs=? HiFold call HiFold(<args>)

