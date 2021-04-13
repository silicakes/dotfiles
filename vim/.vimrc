
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call plug#begin('~/.vim/plugged')
" This is the LSP interface for various syntaxes and languages
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

" A plugin that helps wrap and unwrap text with anything from <Tags/> to ''
Plug 'tpope/vim-surround'

" This plugin helps manage git in a visual way, try running :Gblame 
Plug 'tpope/vim-fugitive'

" This, along with a patched font, adds filetype/folder icons to the file tree
Plug 'ryanoasis/vim-devicons'

" accepts a list of lines and allows interactive search on it, 
" I use it for finding files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax highlight for JS
Plug 'pangloss/vim-javascript'    " JavaScript support

" Syntax highlight for JSX
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax

" syntax highlight forn graphql
Plug 'jparise/vim-graphql'        " GraphQL syntax

" A visualizer for CSV files
Plug 'chrisbra/csv.vim'

" The colorscheme for vim
Plug 'morhetz/gruvbox'

" The status line at the bottom
Plug 'vim-airline/vim-airline'

" Multi-cursor selector, similar to sublime/vscode try CTRL+n
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" One day..
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" TODO: Figure out if I have any plugins that currently rely on ctags
Plug 'ludovicchabant/vim-gutentags'

" syntax hjighlight for styled components/emotion
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Provides aliases for commenting selected blocks of text, try \cc or \cu
Plug 'preservim/nerdcommenter'

" Adds a closing pair of parenthesis/quotation marks etc.. 
" and places the cursor in the middle
Plug 'jiangmiao/auto-pairs'

" Colorizes #bada55 strings, locally, i have it patched to work with some edge
" cases, there's a PR pending for that
Plug 'ap/vim-css-color'

" Momentarily highlights yanked text
Plug 'machakann/vim-highlightedyank'
call plug#end()


filetype plugin indent on
syntax enable

nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
nnoremap <silent><leader>2 :tabe ~/.vimrc<CR>
nnoremap <leader>3 :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
nnoremap <leader>4 :Buffers<CR> 

" Faster saving and exiting
nnoremap <silent><leader>w :w!<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" remapping esc to 'jk' in order to type faster
inoremap jk <ESC>

" Redo with U instead of Ctrl+R
noremap U <C-R>

" CTRL-p will trigger fzf of files that are staged in the repo
nnoremap <C-p> :GFiles<Cr>

" CTRL-r will trigger Rg (ripgrep) inside the CWD
nnoremap <C-r> :Rg<Cr>

" Ctrl-j opens a terminal session inside the current buffers directory
nnoremap <C-j> :terminal<Cr>

" Ctrl-b Opens the file explorer, marking the current file in the buffer
nnoremap <silent> <expr> <C-b> "\:CocCommand explorer<CR>"

" \rn toggles between relative and absolute numbers
nnoremap <leader>rn :set relativenumber!<cr>


"====CoC Config===="

" GoTo code navigation. the commands are self explanatory
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac <Plug>(coc-codeaction)

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"==== End of CoC Config ===="

" number and relativenumber set the hybrid mode where the cursor displays the
" current line, but the rest is relative
set number
set relativenumber
set noswapfile
set hlsearch
set incsearch
set guitablabel=%t
set laststatus=2
set autochdir

"set re=0
set backspace=indent,eol,start

" Indentation
set autoindent
set cindent
set smartindent

" Tab Options
set shiftwidth=2
set tabstop=2
set softtabstop=2 " Number of spaces a tab counts when editing
set expandtab
set modifiable
set wildignore+=*node_modules/**

" Enable folding
set foldmethod=syntax
set foldlevel=99


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" sets clipboard to OS (Mac only, for other platforms use 'unnamedplus')
set clipboard=unnamed

" Italics support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Highlight duration of vim-highlighted-yank
let g:highlightedyank_highlight_duration = 25

" CoC extensions
let g:coc_global_extensions = ['coc-explorer', 'coc-tsserver', 'coc-json']

if(isdirectory('./node_modules'))
  let nm = './node_modules'
  " Add CoC Prettier if prettier is installed
  if isdirectory(nm.'/prettier')
    let g:coc_global_extensions += ['coc-prettier']
  endif

  " Add CoC ESLint if ESLint is installed
  if isdirectory(nm.'/eslint')
   let g:coc_global_extensions += ['coc-eslint']
  endif

  if(isdirectory(nm.'/styled-components'))
    let g:coc_global_extensions += ['coc-styled-components']
  endif
endif

" Important 
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Change cursors according to mode: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" sets up gruvbx
function! GruvboxTheme()
  let g:gruvbox_italic=1
  let g:gruvbox_bold=1
  let g:airline_theme='gruvbox'
  let $BAT_THEME='gruvbox'
  set bg=dark
  colorscheme gruvbox
endfunction

"set background=dark
call GruvboxTheme()

