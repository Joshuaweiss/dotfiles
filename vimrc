filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""
"""" Vundle
""""""""""""""""""""""""""""""""""""""""

set nowrap

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""
""" Improve Vim Capabilities
"""""""""""""""""""""""""""""""""""""""""""""""

Plugin 'chrisbra/unicode.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-vinegar'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-unimpaired'
Plugin 'rking/ag.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-jdaddy.git'
"Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'

""" Add language support
Plugin 'jparise/vim-graphql'
Plugin 'rust-lang/rust.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'isRuslan/vim-es6'
Plugin 'plasticboy/vim-markdown'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'briancollins/vim-jst'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'tikhomirov/vim-glsl'

""" Programming Tools
Plugin 'scrooloose/syntastic'
Plugin 'ap/vim-css-color'
Plugin 'editorconfig/editorconfig-vim'

""" Airline and Themes
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'drewtempelmeyer/palenight.vim'
" Plugin 'morhetz/gruvbox'
" Plugin 'xero/sourcerer.vim'
Plugin 'shinchu/lightline-gruvbox.vim'
" Plugin 'chriskempson/base16-vim'

call vundle#end()

""""""""""""""""""""""""""""""""""""""""
" Basic Config
""""""""""""""""""""""""""""""""""""""""

""" vim-json
let g:vim_json_syntax_conceal = 0

""" vim-javascript
let g:javascript_plugin_jsdoc = 1

""" editorconfig options
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = 'fill'
let g:EditorConfig_preserve_formatoptions = 1

""" using unamed clipboard to match macOS
set clipboard=unnamed

set backspace=2 " make backspace work like most other apps

set wildignore+=.DS_Store

set termguicolors
set number
syntax on

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

""" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_html_checkers = []
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_scss_checkers=[]

""" Indentation Guides
au FileType * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2a364f
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#283247

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

""" toggle syntastic errors
map <Leader>serr :SyntasticToggleMode<CR>
map <Leader>sp :split<CR>
map <Leader>vs :vsplit<CR>

""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""

function! Notes()
  cd ~/google_drive/notes
  call RangeChooser()
endfunction
map <Leader>nts :call Notes()<CR>
