filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""
"""" Vundle
""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" This is needed for the indentation guides to work
setlocal shiftwidth=2 tabstop=2 expandtab

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""
""" Improve Vim Capabilities
"""""""""""""""""""""""""""""""""""""""""""""""

" indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" make vim file browser nice
Plugin 'tpope/vim-vinegar'

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-unimpaired'

" Ag search
Plugin 'rking/ag.vim'


Plugin 'godlygeek/tabular'

"vim-endwise"
Plugin 'tpope/vim-endwise.git'

"Plugin 'tpope/vim-sleuth'

Plugin 'tpope/vim-fugitive'

Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-eunuch'
Plugin 'JarrodCTaylor/vim-shell-executor'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'

Plugin 'takac/vim-spotifysearch'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'

""" Add language support
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'derekwyatt/vim-scala'
Plugin 'mxw/vim-jsx'
Plugin 'mtscout6/vim-cjsx'
Plugin 'isRuslan/vim-es6'
Plugin 'plasticboy/vim-markdown'

""" Library and Framework shortcuts
Plugin 'tpope/vim-rails'
Plugin 'Keithbsmiley/rspec.vim' 
Plugin 'tpope/vim-haml'
Plugin 'thoughtbot/vim-rspec'

""" Programming Tools
Plugin 'scrooloose/syntastic'
Plugin 'ap/vim-css-color'
Plugin 'valloric/youcompleteme'
Plugin 'rizzatti/dash.vim'

""" Airline and Themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'qualiabyte/vim-colorstepper'
Bundle 'altercation/vim-colors-solarized'

""" Other
"""""""""""""""""""""""""""""""""""""""

" syntax issue #203
Plugin 'jimenezrick/vimerl'

call vundle#end()

""""""""""""""""""""""""""""""""""""""""
" Basic Config
""""""""""""""""""""""""""""""""""""""""

""using unamed clipboard to match macOS
set clipboard=unnamed

"""highlight evil tab characters
highlight EvilTabCharacter ctermbg=red guibg=red
autocmd ColorScheme * highlight EvilTabCharacter ctermbg=red guibg=red
match EvilTabCharacter /\t/

set backspace=2 " make backspace work like most other apps

"set wildignore+=doc            " should not break helptags
"set wildignore+=.git           " should not break clone
"set wildignore+=.git/*         " should not break clone
"set wildignore+=*/.git/*
"set wildignore+=*/node_modules/*
"set wildignore+=*/tmp/*
"set wildignore+=*/public/*
"set wildignore+=public/*
set wildignore+=.DS_Store

set number
syntax on

color znake 
"BlackSea  "smyck

""" Make background clear for terminal emulator background image
hi Normal ctermbg=none

"""Custom ruby
au FileType ruby hi String gui=italic
au FileType ruby hi Define gui=bold
au FileType ruby hi Identifier gui=bold
au FileType ruby hi Constant gui=bold
au FileType ruby hi Function gui=bold
au FileType ruby hi Type gui=bold

"""Set for MacVim
set guifont=InputMono:h13

setlocal shiftwidth=2 tabstop=2 expandtab

""" dont syntax highlight past character limit
set synmaxcol=200

""" Always show statusline
set laststatus=2

"""Dispatch
au FileType ruby let b:dispatch = 'ruby %'
au FileType rust let b:dispatch = 'cargo run .'



""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""

""" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_typescript_tsc_fname = ''
let g:syntastic_html_checkers = []

""" Indentation Guides
au FileType * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=grey
hi IndentGuidesEven ctermbg=darkgrey


""" Airline
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""ctrlp ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules)$',
  \ 'file': '\v\.(DS_Store)$'
  \ }

"""ctrlp should cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"""ctrlp should use ag to search
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Automatically detect file types.
filetype plugin indent on



""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

map <Leader>rs :!cargo run<CR>

""" run rspec
let g:rspec_command = "Dispatch rspec {spec}"
map <Leader>nsp :call RunNearestSpec()<CR>
map <Leader>lsp :call RunLastSpec()<CR>
map <Leader>fsp :call RunCurrentSpecFile()<CR>

""" turn on or off byebug in rspec
map <Leader>bbon :call ByebugOn()<CR>
map <Leader>bbof :call ByebugOff()<CR>

""" remove trailing white space
map <Leader>rtws :%s/\s\+$//<CR>

""" toggle syntastic errors
map <Leader>serr :SyntasticToggleMode<CR>

map <Leader>nrhs :%s/:\(\w*\)\s*=>\s*/\1: /gc<CR>

nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

"nmap <F6> <Plug>NewColorstepPrev
"nmap <F7> <Plug>ColorstepNext

""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""

" Qdo runs a command on every file in a quick list
" http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim#comment8286582_5686810
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
command! -nargs=1 -complete=command -bang Qdo exe 'args '.QuickfixFilenames() | argdo<bang> <args>
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

""" run shell command and open results in new buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

function! ByebugOn()
  let g:rspec_command = "Dispatch BYEBUG=true rspec {spec}"
endfunction

function! ByebugOff()
  let g:rspec_command = "Dispatch rspec {spec}"
endfunction

function! Rb()
  !ruby %:p
endfunction

function! NewColorstepPrev()
  call ColorstepPrev()
  hi Normal ctermbg=none
endfunction
