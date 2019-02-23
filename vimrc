"""""""""""""""""""""""""""""""""""""""""
"""" Vim Dein
""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include dein and initialize
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#add('autozimu/LanguageClient-neovim', {
        \ 'rev': 'next',
        \ 'build': 'bash install.sh',
        \ })

    """""""""""""""""""""""""""""""""""""""""""""""
    """ Improve Vim Capabilities
    """""""""""""""""""""""""""""""""""""""""""""""
    call dein#add('chrisbra/unicode.vim')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('tpope/vim-vinegar')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('tpope/vim-unimpaired')
    call dein#add('rking/ag.vim')
    call dein#add('tpope/vim-endwise.git')
    call dein#add('tpope/vim-jdaddy.git')
    call dein#add('tpope/vim-fugitive')
    call dein#add('kien/ctrlp.vim')
    call dein#add('tpope/vim-eunuch')
    call dein#add('tpope/vim-dispatch')
    call dein#add('tpope/vim-surround')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('tpope/vim-abolish')

    """ Add language support
    call dein#add('jparise/vim-graphql')
    call dein#add('rust-lang/rust.vim')
    call dein#add('leafgarland/typescript-vim')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('isRuslan/vim-es6')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('posva/vim-vue')
    call dein#add('pangloss/vim-javascript')
    call dein#add('briancollins/vim-jst')
    call dein#add('mxw/vim-jsx')
    call dein#add('elzr/vim-json')
    call dein#add('tikhomirov/vim-glsl')

    """ Programming Tools
    call dein#add('scrooloose/syntastic')
    call dein#add('ap/vim-css-color')
    call dein#add('editorconfig/editorconfig-vim')

    """ Airline and Themes
    call dein#add('itchyny/lightline.vim')
    call dein#add('edkolev/tmuxline.vim')
    call dein#add('drewtempelmeyer/palenight.vim')
    " Plugin 'morhetz/gruvbox'
    " Plugin 'xero/sourcerer.vim'
    " Plugin 'shinchu/lightline-gruvbox.vim'
    " Plugin 'chriskempson/base16-vim'

    call dein#end()
    call dein#save_state()
endif

set nowrap

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
