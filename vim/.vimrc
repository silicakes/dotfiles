
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call plug#begin('~/.vim/plugged')
" This is the LSP interface for various syntaxes and languages
Plug 'neoclide/coc.nvim' , { 'branch' : 'release', 'do': { -> coc#util#install()  } }

" A plugin that helps wrap and unwrap text with anything from <Tags/> to ''
Plug 'tpope/vim-surround'

" Shows diff status in gutter line
Plug 'airblade/vim-gitgutter'

" This plugin helps manage git in a visual way, try running :Gblame 
Plug 'tpope/vim-fugitive'

" This, along with a patched font, adds filetype/folder icons to the file tree
Plug 'ryanoasis/vim-devicons'

" accepts a list of lines and allows interactive search on it, 
" I use it for finding files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" A visualizer for CSV files
Plug 'chrisbra/csv.vim'

" The colorscheme for vim
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'ghifarit53/tokyonight-vim'
" The status line at the bottom
Plug 'vim-airline/vim-airline'

" Multi-cursor selector, similar to sublime/vscode try CTRL+n
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" One day..
if(has("nvim")) 
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-treesitter/playground'
else
  " Syntax highlight for JS
  Plug 'pangloss/vim-javascript'    " JavaScript support
  
  " Syntax highlight for JSX
  Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
  
  " syntax highlight forn graphql
  Plug 'jparise/vim-graphql'        " GraphQL syntax
endif

" TODO: Figure out if I have any plugins that currently rely on ctags
"Plug 'ludovicchabant/vim-gutentags'

" syntax hjighlight for styled components/emotion
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Provides aliases for commenting selected blocks of text, try \cc or \cu
Plug 'preservim/nerdcommenter'


" Colorizes #bada55 strings, locally, i have it patched to work with some edge
" cases, there's a PR pending for that
Plug 'ap/vim-css-color'

" Momentarily highlights yanked text
Plug 'machakann/vim-highlightedyank'

" Log highlighting
Plug 'mtdl9/vim-log-highlighting'

call plug#end()


filetype plugin indent on
syntax enable

" Leader mappings, currentl eader is \
" \1 Runs Pluginstall, handy running after adding a new plugin
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" \2 Opens .vimrc ins a separate tab
nnoremap <silent><leader>2 :tabe ~/.vimrc<CR>

" \3 Opens a terminal session in the current files directory
nnoremap <leader>3 :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>

" \4 Opens a list of the recent buffers (depends on fzf) where the previous -
" buffer is preselected
nnoremap <leader>4 :Buffers<CR> 

" Faster saving and exiting
" \w
nnoremap <silent><leader>w :w!<CR>
" \q
nnoremap <silent><leader>q :q!<CR>
" \x
nnoremap <silent><leader>x :x<CR>

" Quickly insert an empty new line without entering insert mode
" \o
nnoremap <Leader>o o<Esc>
" \O
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

" Jump to the beginning of the line in insert mode
inoremap <C-a> <C-o>I

" Jump to the end of the line in insert mode
inoremap <C-e> <C-o>A

"====CoC Config===="
"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>

" GoTo code navigation. the commands are self explanatory
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac <Plug>(coc-codeaction)
noremap <silent><nowait> <space>d :call CocAction('jumpDefinition', v:false)<CR>

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
"set autochdir

"set re=0
set backspace=indent,eol,start

" case-insensitive search when phrase is all lower case, case sensitive when
" it's not
set smartcase

" when openning an already opened file, jump to that buffer instead of openning
" another one
set switchbuf=usetab

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
set wildignore+=*build/**
set wildignore+=*.min.js

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
"if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
"else
  set signcolumn=yes
"endif

" sets clipboard to OS (Mac only, for other platforms use 'unnamedplus')
set clipboard=unnamed

" Italics support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Highlight duration of vim-highlighted-yank
let g:highlightedyank_highlight_duration = 25


" CoC extensions

" coc-pairse Adds a closing pair of parenthesis/quotation marks etc.. 
" and places the cursor in the middle
let g:coc_global_extensions = ['coc-explorer', 'coc-tsserver', 'coc-json', 'coc-pairs']

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

if(has("nvim"))
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = false,
    },
    ensure_installed = {'javascript'}
}
EOF
endif

" Important 
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Change cursors according to mode: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:markdown_fenced_languages = [  'vim',  'help' ]

" sets up gruvbx
function! GruvboxTheme()
  let g:gruvbox_italic=1
  let g:gruvbox_bold=1
  let g:airline_theme='gruvbox'
  let $BAT_THEME='gruvbox'
  set bg=dark
  colorscheme gruvbox
endfunction

function! TokyoNightsTheme()
  let g:airline_theme = "tokyonight"
  let g:tokyonight_style = 'night' " available: night, storm
  let g:tokyonight_enable_italic = 1
  colorscheme tokyonight
endfunction
      
function! GruvboxMaterialTheme()
  let g:airline_theme = 'gruvbox_material'
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_palette='mix'
  colorscheme gruvbox-material
endfunction
"set background=dark
"call GruvboxTheme()
call GruvboxMaterialTheme()
"call TokyoNightsTheme()

