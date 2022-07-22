set nu
set relativenumber

syntax on
set mouse =a
set cursorline
set wildmenu
set hlsearch
set incsearch
set ts=2
let mapleader="\<space>"

inoremap <leader>w <Esc>:w<cr>
nnoremap <leader>w <Esc>:w<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

noremap <leader>q :q!<CR>

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" set find path
"set path=.,/home/qcraft/qcraft.3rd/**,/home/qcraft/qcraft.3rd/onboard/planner/decision/**,/home/qcraft/qcraft.3rd/onboard/planner/scene/**
"set path=.,/home/qcraft/qcraft.3rd/**

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'connorholyday/vim-snazzy'
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'zivyangll/git-blame.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
"Plug 'bling/vim-bufferline'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'grailbio/bazel-compilation-database'
call plug#end()

call glaive#Install()

" ==========
" ==========      coc.nvim
" ==========

let g:coc_global_extensions = ['coc-json','coc-vimlsp']
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <LEADER>h :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ==========
" ==========      connorholyday/vim-snazzy
" ==========

colorscheme snazzy

" ==========
" ==========      qcraft
" ==========

" goto cc file
nmap <leader>rc :e %:r:s?_test??:s?$?.cc?
" goto test file
nmap <leader>rt :e %:r:s?_test??:s?$?_test\.cc?
" goto header file
nmap <leader>rh :e %:r:s?_test??:s?$?.h?
" goto the build file.
nmap <leader>rb :e %:p:h:s?$?/BUILD?
" goto the proto file.
nmap <leader>rp :e %:r:s?_test??:s?$?.proto?

" ==========
" ==========      zivyangll/git-blame.vim
" ==========

" nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" ==========
" ==========      vim-codefmt
" ==========

Glaive codefmt plugin[mappings]
"Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
Glaive codefmt clang_format_style="Google"
augroup autoformat_settings
  autocmd FileType BUILD,bzl AutoFormatBuffer buildifier
  autocmd FileType cc,c,cpp,cu,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  "autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer black
  "autocmd FileType sh AutoFormatBuffer shfmt
  " autocmd FileType python AutoFormatBuffer autopep8
augroup END
