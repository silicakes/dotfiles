call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'chrisbra/csv.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" One day..
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" TODO: Figure out if I have any plugins that currently rely on ctags
Plug 'ludovicchabant/vim-gutentags'

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
call plug#end()

filetype plugin indent on
syntax enable

nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
nnoremap <silent><leader>2 :tabe ~/.vimrc<CR>
nnoremap <leader>3 :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
nnoremap <leader>4 :Buffers<CR> 

" Fasmer saving and exiting
nnoremap <silent><leader>w :w!<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
inoremap jk <ESC>

" Redo with U instead of Ctrl+R
noremap U <C-R>
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-r> :Rg<Cr>
nnoremap <C-j> :terminal<Cr>
nnoremap <silent> <expr> <C-b> "\:CocCommand explorer<CR>"

" toggle relative number
nnoremap <leader>rn :set relativenumber!<cr>

"====CoC Config===="

" GoTo code navigation.
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

set number
set noswapfile
set relativenumber
set hlsearch
set incsearch
set guitablabel=%t
set laststatus=2
set autochdir

set re=0

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
set cmdheight=2

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

set clipboard=unnamed

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let NERDTreeShowHidden=1
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

