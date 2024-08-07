set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set clipboard+=unnamedplus
set nu

set nocompatible              " be iMproved, required
set noswapfile
set showcmd
set backspace=indent,eol,start
set pastetoggle=<F2>

packadd termdebug

syntax on

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'preservim/vimux'
Plugin 'sigidagi/vim-cmake-project'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'cdelledonne/vim-cmake'
Plugin 'unkiwii/vim-nerdtree-sync'
Plugin 'lifepillar/pgsql.vim.git'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'https://github.com/morhetz/gruvbox.git'
Plugin 'https://github.com/skanehira/preview-markdown.vim.git'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion.git'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'neoclide/coc.nvim'
" Plugin 'ycm-core/YouCompleteMe'
" Plugin 'rdnetto/YCM-Generator'
Plugin 'https://github.com/rhysd/vim-clang-format.git'
Plugin 'https://github.com/preservim/tagbar.git'
Plugin 'puremourning/vimspector'

" Plugin for SQL
Plugin 'https://github.com/tpope/vim-dadbod'
Plugin 'https://github.com/kristijanhusak/vim-dadbod-completion'
Plugin 'https://github.com/kristijanhusak/vim-dadbod-ui'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:python3_host_prog = '/usr/bin/python3'
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>sr <cmd>VimspectorReset<CR>
nmap <leader><CR> <Plug>VimspectorBalloonEval<CR>
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:nerdtree_sync_cursorline = 1
tnoremap <Esc> <C-\><C-n>

map <Leader> <Plug>(easymotion-prefix)
set background=dark
colorscheme gruvbox
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

let g:preview_markdown_auto_update = 1

"let g:clang_format#command = 'clang-format'
"let g:clang_format#auto_format = 1
"let g:clang_format#style_options = {
"	}

"let g:clang_format#detect_style_file = 1
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': ['xclip', '-quiet', '-i', '-selection', 'clipboard'],
      \      '*': ['xclip', '-quiet', '-i', '-selection', 'primary'],
      \    },
      \   'paste': {
      \      '+': ['xclip', '-o', '-selection', 'clipboard'],
      \      '*': ['xclip', '-o', '-selection', 'primary'],
      \   },
      \   'cache_enabled': 1,
      \ }

nmap <Tab>a :Ag<CR>
nmap <F8> :TagbarToggle<CR>
autocmd VimEnter *.c,*.h,*.cpp TagbarToggle
"autocmd BufNew,BufRead,BufEnter *.c,*.h,*.cpp TagbarToggle
let g:tagbar_compact = 1
let g:tagbar_sort = 0

let g:termdebug_wide = 1

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
vmap <C-k> :ClangFormat<CR>
autocmd FileType c ClangFormatAutoEnable


let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
	nmap <F8> :Vexplore<CR> 
augroup END

" use <tab> for trigger completion and navigate to the next complete item
function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ?  "\<C-n>" :
	  \ Check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

noremap <C-a> :Files<CR>

let g:fzf_layout = { 'down': '40%' }
map <C-f> :Ag<CR>
