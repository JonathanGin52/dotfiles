let g:currentmode={
  \ 'n'  : 'N ',
  \ 'no' : 'N·Operator Pending ',
  \ 'v'  : 'V ',
  \ 'V'  : 'V·Line ',
  \ "\<C-v>" : 'V·Block ',
  \ 's'  : 'Select ',
  \ 'S'  : 'S·Line ',
  \ "\<C-s>"  : 'S·Block ',
  \ 'i'  : 'I ',
  \ 'R'  : 'R ',
  \ 'Rv' : 'V·Replace ',
  \ 'c'  : 'Command ',
  \ 'cv' : 'Vim Ex ',
  \ 'ce' : 'Ex ',
  \ 'r'  : 'Prompt ',
  \ 'rm' : 'More ',
  \ 'r?' : 'Confirm ',
  \ '!'  : 'Shell ',
  \ 't'  : 'Terminal '
\}

set laststatus=2                                           " Show statusline
set statusline=%*\ %{toupper(g:currentmode[mode()])}       " Current mode
"set statusline+=%8*\ [%n]                                 " Buffer number
set statusline+=%*\ %{GitInfo()}                           " Git Branch name
set statusline+=%*\ %<%f                                   " File path
set statusline+=%{&readonly?'\ \ ':'\ \ '}                " Read-only flag
set statusline+=%{&modified?'\ ✎':''}                      " Modified flag
set statusline+=%=                                         " Split between left and right side items
set statusline+=%{gutentags#statusline()}\                 " ctags generation progress
set statusline+=%*\ %y                                     " FileType
"set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\  " Encoding & Fileformat
set statusline+=%4l,%-4v                                   " Row of cursor, column of curson
set statusline+=%3p%%\ \                                   " Percentage through the file

function! GitInfo()
  let git=fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
  endif
endfunction
