

let g:NeatStatusLine_color_normal   = 'guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2'
" White on Red
let g:NeatStatusLine_color_insert   = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=darkyellow'
" Yellow on Blue
let g:NeatStatusLine_color_replace  = 'guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=yellow ctermbg=blue'
" White on Purple
let g:NeatStatusLine_color_visual   = 'guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53'
" White on Black
let g:NeatStatusLine_color_position = 'guifg=#ffffff guibg=#000000 ctermfg=15 ctermbg=0'
" White on Pink
let g:NeatStatusLine_color_modified = 'guifg=#ffffff guibg=#ff00ff ctermfg=darkyellow ctermbg=19'
" Pink on Black
let g:NeatStatusLine_color_line     = 'guifg=#ff00ff guibg=#000000 gui=bold ctermfg=black ctermbg=red'
" Black on Cyan
let g:NeatStatusLine_color_filetype = 'guifg=#000000 guibg=#00ffff gui=bold ctermfg=0 ctermbg=51'

let g:NeatStatusLine_separator = '|'

let g:previousMode=''
function! Mode()
  let b:mode = mode()
  if (bufnr('%') == g:bufNum && g:previousMode != b:mode)
    if     b:mode ==# "n"  | let b:color=g:NeatStatusLine_color_normal  | let b:buffer_mode="N"
    elseif b:mode ==# "i"  | let b:color=g:NeatStatusLine_color_insert  | let b:buffer_mode="I"
    elseif b:mode ==# "R"  | let b:color=g:NeatStatusLine_color_replace | let b:buffer_mode="R"
    elseif b:mode ==# "v"  | let b:color=g:NeatStatusLine_color_visual  | let b:buffer_mode="V"
    elseif b:mode ==# "V"  | let b:color=g:NeatStatusLine_color_visual  | let b:buffer_mode="VL"
    elseif b:mode ==# "" | let b:color=g:NeatStatusLine_color_visual  | let b:buffer_mode="VB"
    else                   | let b:buffer_mode=b:mode
    endif
    redraw
    exec 'highlight! StatusLine '.b:color
  endif
  return b:buffer_mode
endfunc

hi! StatusLine     ctermfg=7       ctermbg=18
hi! StatusLineNC   ctermfg=8       ctermbg=235
" Error
hi! User2          ctermfg=255     ctermbg=160
" Warning
hi! User3          ctermfg=154     ctermbg=18
hi! User4          ctermfg=18      ctermbg=34
" Read Mode
hi! User5          ctermfg=154     ctermbg=18
hi! User6          ctermfg=45      ctermbg=18

"statusline setup
set statusline=
"set statusline+=\ %{Mode()}
set statusline+=%4*%{&paste?'\ \ PASTE\ ':''}
set statusline+=%*
set statusline+=\ %-0.30f

"modified flag
set statusline+=%5*%{&modified?'+':''}
set statusline+=%*
set statusline+=\ %(❪%0.25{GetGitStatus()}❫%)

set statusline+=%=      "left/right separator

"display a warning if fileformat isnt unix
set statusline+=%2*
set statusline+=%([%R%H%{&ff!='unix'?','.&ff:''}%{(&fenc!='utf-8'&&&fenc!='')?','.&fenc:''}]%)

set statusline+=%3*
set statusline+=%([%{NeoMakeErrorCount()}%{StatuslineLongLineWarning()}%{StatuslineTabWarning()}%{StatuslineTrailingSpaceWarning()}]%)

set statusline+=%6*
set statusline+=%y  "filetype
set statusline+=%([%3v]%)  "cursor column

set laststatus=2

if has('title')
  set titlestring=%t%(\ [%R%M]%)
endif
set showmode

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
