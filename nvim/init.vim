set nocompatible              " be iMproved, required
filetype off                  " required

" function to source a file if it exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

let g:ale_disable_lsp = 1
" set the runtime path to include Vundle and initialize
call plug#begin()
source ~/.config/nvim/plugins.vim
call SourceIfExists('~/.config/nvim/layers/private/packages.vim')
call plug#end()            " required

let mapleader = "\<Space>"

" deal with colors
if !has('gui_running')
  set t_Co=256
endif

" Load theme from file if any
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" ========================================
" #  EDITOR SETTINGS
" ========================================
filetype plugin indent on " required
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2 " Keeps 2 lines visible around the cursor
set noshowmode
"set nofoldenable " Don't fold anything
set foldlevelstart=999
set foldcolumn=2
set foldmethod=syntax
set nowrap
let g:sneak#s_next = 1
set title " Update terminal title
set number
set relativenumber
set numberwidth=5
set backspace=indent,eol,start
set showbreak=… " show ellipsis at breaking
set linebreak
set visualbell
set colorcolumn=80 " A colored column at 80 chars
set showcmd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set laststatus=2 " Show Vim Status Line All The Time
set mouse=a
set ruler
set lazyredraw
set showmatch " Show the matching bracket briefly when we close
set shortmess+=c " don't give |ins-completion-menu| messages.
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Make a visual difference between active pane and the others
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
:hi CursorLine cterm=NONE guibg=darkred

" Vista for file structure navigation

nmap <F5> :Vista!!<CR> 
let g:vista#renderer#enable_icon = 1

" Show the nearest method/function
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" User karabiner to fix C-i and Tab problem
nnoremap <F6> <C-i>

"Split more natural direction
set splitright
set splitbelow

" Better j, k, Move by line
nnoremap j gj
nnoremap k gk

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" map leader + s to save
nmap <leader>w :w<cr>

" Folding
nnoremap <tab> za

" Disable Arrow Keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>

" Toggle between the last two buffers
nnoremap <leader><leader> <c-^>
noremap <Right> <NOP>

" Search
set incsearch " Incremental search
set ignorecase smartcase " Disables ignorecase if the search term has capital
" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Better indentation in Visual Mode
vnoremap < <gv
vnoremap > >gv

" Disable Ex Mode
noremap Q <NOP>


" Let's save undo info!
if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload

" My Style
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" NERDTree Shortcuts
map <C-n> :NERDTreeToggle<cr>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <C-m> :NERDTreeFind<CR> " Highlight currently open buffer in NERDTree

" Formatting
noremap <C-F> :Neoformat<CR>
" <leader>s for Rg search
noremap <leader>f :Rg
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.5, 'highlight': 'Comment' } }

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always -- '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)



function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
  " return 'fd --type file --follow' 
endfunction

" command! -bang -nargs=? -complete=dir Files
"       \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
"       \                               'options': '--tiebreak=index'}, <bang>0)


let g:fzf_preview_cmd = g:plug_home . "/fzf.vim/bin/preview.sh {}"
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
      \                               'options': ['--tiebreak=index', '--preview', g:fzf_preview_cmd ]
      \                                }, <bang>0)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100
" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
set updatetime=300

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby
autocmd Filetype markdown setlocal spell tw=72 colorcolumn=73

" Git commit message
autocmd Filetype gitcommit                         setlocal spell tw=72 colorcolumn=73


" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" cctags
" cctags auto updating
" function! DelTagOfFile(file)
"   let fullpath = a:file
"   let cwd = getcwd()
"   let tagfilename = cwd . "/tags"
"   let f = substitute(fullpath, cwd . "/", "", "")
"   let f = escape(f, './')
"   let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
"   let resp = system(cmd)
" endfunction

" function! UpdateTags()
"   let f = expand("%:p")
"   let cwd = getcwd()
"   let tagfilename = cwd . "/tags"
"   let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
"   call DelTagOfFile(f)
"   let resp = system(cmd)
" endfunction
" 
" autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e

" C++ Moving between headers and Cpp files
" Read: Open file
nmap <silent> <Leader>of :FSHere<cr>
" Read Open Left (split)
nmap <silent> <Leader>oh :FSSplitLeft<cr>

" Read Open Right (split)
nmap <silent> <Leader>ol :FSSplitRight<cr>

" Read Open Above (split)
nmap <silent> <Leader>ok :FSSplitAbove<cr>

" Read Open Below (split)
nmap <silent> <Leader>oj :FSSplitBelow<cr>

" Same mappings but without splitting
nmap <silent> <Leader>oH :FSLeft<cr>
nmap <silent> <Leader>oL :FSRight<cr>
nmap <silent> <Leader>oK :FSAbove<cr>
nmap <silent> <Leader>oJ :FSBelow<cr>

" Lightline configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {
      \         'n' : 'N',
      \         'i' : 'I',
      \         'R' : 'R',
      \         'v' : 'V',
      \         'V' : 'VL',
      \         "\<C-v>": 'VB',
      \         'c' : 'C',
      \         's' : 'S',
      \         'S' : 'SL',
      \         "\<C-s>": 'SB',
      \         't': 'T',
      \         },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'relativepath', 'modified', 'method' ] ],
      \   'right': [ [ 'gitbranch' ],
      \              [ 'percent' ],
      \              [ 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction',
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" FB Configuring
if filereadable(expand("~/.config/fb/coc-settings.json"))
  echo "Loading Facebook Configuration"
  let g:coc_config_home = expand("~/.config/fb")

  autocmd BufRead *.cinc set filetype=python
  autocmd BufRead *.cconf set filetype=python
  autocmd BufRead *.mcconf set filetype=python
  autocmd BufRead TARGETS set filetype=python
  
  if filereadable(expand("~/fbcode/third-party-buck/platform009/build/python/3.8/bin/python3"))
    let g:python3_host_prog =  "/home/asoli/fbcode/third-party-buck/platform009/build/python/3.8/bin/python3"
  endif
endif



if !exists("g:ale_linters")
    let g:ale_linters = {}
endif

" Layered Config
call SourceIfExists('~/.config/nvim/layers/private/vimrc.vim')


