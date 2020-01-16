" Rust auto-pair fixes
let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

set textwidth=80
set colorcolumn=80

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=80
  autocmd WinLeave * set colorcolumn=0
augroup END
