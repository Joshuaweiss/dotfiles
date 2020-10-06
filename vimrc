"""""""""""""""""""""""""""""""""""""""""
"""" Vim Plug
""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""
""" Improve Vim Capabilities
"""""""""""""""""""""""""""""""""""""""""""""""

Plug 'chrisbra/unicode.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'rking/ag.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

""" Add language support
Plug 'jparise/vim-graphql'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'isRuslan/vim-es6'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'xavierchow/vim-sequence-diagram'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'hashivim/vim-terraform'

""" Programming Tools
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'janko/vim-test'

""" Airline and Themes
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'drewtempelmeyer/palenight.vim'

""" Navigation should override any other macros
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""""""""""""""""""""""""""""""""""""""""
" Basic Config
""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.tsx  set filetype=typescript

""" vim-json
let g:vim_json_syntax_conceal = 0

""" vim-markdown
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'javascript=js', 'mermaid=sequence']
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

""" editorconfig options
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = 'fill'
let g:EditorConfig_preserve_formatoptions = 1

""" ale
let g:ale_completion_enabled = 1

""" using unamed clipboard to match macOS
set clipboard=unnamed

set backspace=2 " make backspace work like most other apps

set wildignore+=\.DS_Store

set termguicolors
set number
syntax on

let g:ale_fixers = {
    \  'javascript': ['eslint'],
    \  'typescript': ['eslint', 'tslint'],
    \  'json': ['fixjson'],
    \  'python': ['trim_whitespace', 'remove_trailing_lines']
    \ }
    let g:ale_lint_on_save = 1
    let g:ale_fix_on_save = 1
    let g:ale_python_flake8_executable = 'pipenv'
    let g:ale_linters = {
    \  'javascript': ['eslint', 'flow'],
    \  'typescript': ['eslint', 'tslint', 'tsserver'],
    \  'python': ['flake8'],
    \  'json': ['fixjson']
    \ }

set background=dark
" colorscheme gruvbox
colorscheme palenight
let g:palenight_terminal_italics=1

""" Make background clear for terminal emulator background images
hi Normal ctermbg=none
highlight ColorColumn ctermbg=235 guibg=#333333
hi Normal guibg=NONE ctermbg=NONE

filetype indent off

""" Always show statusline
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""

let g:ranger_replace_netrw = 1

""" Indentation Guides
au FileType * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2a364f
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#283247

set nowrap
autocmd FileType md set wrap

set foldlevelstart=20
setlocal foldmethod=syntax

"""ctrlp should cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"""ctrlp should use ag to search
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""
map <Leader>sp :split<CR>
map <Leader>vs :vsplit<CR>
map <Leader>gtd :ALEGoToDefinition<CR>
map <Leader>gtds :ALEGoToDefinitionInSplit<CR>
map <Leader>gtdv :ALEGoToDefinitionInVSplit<CR>
map <Leader>fref :ALEFindReferences<CR>
map <Leader>hov :ALEHover<CR>
map <Leader>doc :ALEDocumentation<CR>
map <Leader>rename :ALERename<CR>
map <Leader>fix :ALEFixSuggest<CR>
map <leader>aj :ALENext<CR>
map <leader>ak :ALEPrevious<CR>
map <leader>alet :ALEToggle<CR>
map <leader>tn :TestNearest<CR>
map <leader>tf :TestFile<CR>
map <leader>ts :TestSuite<CR>
nmap - :Ranger<CR>

tnoremap <silent><C-j> <C-\><C-N>:TmuxNavigateDown<CR>i
tnoremap <silent><C-k> <C-\><C-N>:TmuxNavigateUp<CR>i
tnoremap <silent><C-h> <C-\><C-N>:TmuxNavigateLeft<CR>i
tnoremap <silent><C-l> <C-\><C-N>:TmuxNavigateRight<CR>i

""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""

function! Notes()
  cd ~/google_drive/notes
  call RangeChooser()
endfunction
map <Leader>nts :call Notes()<CR>
