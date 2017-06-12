filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""
"""" Vundle
""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" This is needed for the indentation guides to work
setlocal shiftwidth=4 tabstop=4 expandtab

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""
""" Improve Vim Capabilities
"""""""""""""""""""""""""""""""""""""""""""""""

" indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" make vim file browser nice
Plugin 'tpope/vim-vinegar'

Plugin 'jparise/vim-graphql'

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

Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'

Plugin 'vim-scripts/ZoomWin'

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
Plugin 'posva/vim-vue'
Plugin 'gcorne/vim-sass-lint'

""" Library and Framework shortcuts
Plugin 'tpope/vim-rails'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'tpope/vim-haml'
Plugin 'thoughtbot/vim-rspec'

""" Programming Tools
Plugin 'scrooloose/syntastic'
Plugin 'ap/vim-css-color'
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
set guifont=Fira\ Mono\ for\ Powerline:h13

autocmd FileType * setlocal shiftwidth=2 tabstop=2 expandtab

""" dont syntax highlight past character limit
set synmaxcol=200

""" Always show statusline
set laststatus=2

"""Dispatch
au FileType ruby let b:dispatch = 'ruby %'
au FileType rust let b:dispatch = 'cargo run .'

autocmd BufRead,BufNewFile *.csv set filetype=csv
au FileType csv setlocal noeol


""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""

""" Syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_typescript_tsc_fname = ''
let g:syntastic_html_checkers = []
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_sass_checkers=["sasslint"]
let g:syntastic_scss_checkers=["sasslint"]


""" Indentation Guides
au FileType * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=233
hi IndentGuidesEven ctermbg=234

set foldlevelstart=20
setlocal foldmethod=syntax

""" Airline
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""ctrlp should cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"""ctrlp should use ag to search
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Automatically detect file types.
" filetype plugin indent on



""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

map <Leader>rs :!cargo run<CR>

""" run rspec
let g:rspec_command = "Dispatch bundle exec rspec {spec}"
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
  let g:rspec_command = "Dispatch rspec {spec}" endfunction function! Rb()
  !ruby %:p
endfunction

function! NewColorstepPrev()
  call ColorstepPrev()
  hi Normal ctermbg=none
endfunction

" Compatible with ranger 1.4.2 through 1.7.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

function! Notes()
  cd ~/Dropbox/Notes
  call RangeChooser()
endfunction
map <Leader>nts :call Notes()<CR>

function! UnicodeEscapeString(str)
  let oldenc = &encoding
  set encoding=utf-8
  let escaped = substitute(a:str, '[^[:alnum:][:blank:][:cntrl:][:graph:]]', '\=printf("\\u%04x", char2nr(submatch(0)))', 'g')
  let &encoding = oldenc
  return escaped
endfunction

function! UnicodeEscape() range
  let oldreg = @x
  execute 'normal gv"xy'
  let @x = UnicodeEscapeString(@x)
  execute 'normal gv"xp'
  let @x = oldreg
endfunction

function! UnicodeUnescapeString(str)
  let oldenc = &encoding
  set encoding=utf-8
  let escaped = substitute(a:str, '\\u\([0-9a-fA-F]\{4\}\)', '\=nr2char("0x" . submatch(1))', 'g')
  let &encoding = oldenc
  return escaped
endfunction

function! UnicodeUnescape() range
  let oldreg = @x
  execute 'normal gv"xy'
  let @x = UnicodeUnescapeString(@x)
  execute 'normal gv"xp'
  let @x = oldreg
endfunction

command! -range UnicodeEscape :<line1>,<line2>call UnicodeEscape()
command! -range UnicodeUnescape :<line1>,<line2>call UnicodeUnescape()
