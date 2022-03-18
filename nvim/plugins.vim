" Core
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'romgrk/nvim-treesitter-context' " show function context as you scroll
Plug 'andymass/vim-matchup'           " extended % key matching

" LSP
Plug 'neovim/nvim-lspconfig'             " out of the box LSP configs for common langs
Plug 'ray-x/lsp_signature.nvim'          " floating signature 'as you type'


" GUI enhancements
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'chriskempson/base16-vim'
Plug 'liuchengxu/vista.vim'

" General code improvement
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" C/C++ Related
Plug 'derekwyatt/vim-fswitch'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'plasticboy/vim-markdown'
Plug 'solarnz/thrift.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'
Plug 'galooshi/vim-import-js' " Auto Import

" Source Control
Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-rhubarb' " Github

" Ruby
Plug 'keith/rspec.vim'                    " better RSpec syntax highlighting
Plug 'jgdavey/vim-blockle'                " toggle block styles with ,b
Plug 'tpope/vim-rake'                     " allow for alternate files
Plug 'vim-ruby/vim-ruby'                  " indentation, etc
Plug 'joker1007/vim-ruby-heredoc-syntax'  " fenced syntax colors in heredocs
Plug 'ecomba/vim-ruby-refactoring'        " extract vars, methods, etc
