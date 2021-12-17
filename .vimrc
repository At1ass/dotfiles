set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set clipboard+=unnamedplus


set nocompatible              " be iMproved, required
set noswapfile
set showcmd
set backspace=indent,eol,start
set pastetoggle=<F2>

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
" plugin from http://vim-scripts.org/vim/scripts.html
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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
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
xmap <C-c> :norm i//<CR>
xmap <C-x> :norm xx<CR>
map <Leader> <Plug>(easymotion-prefix)
set background=dark
colorscheme gruvbox
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
"let g:ycm_clangd_binary_path = "/usr/bin/clangd-10"
"let g:ycm_use_clangd = 1
"let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'
"let g:ycm_min_num_of_chars_for_completion = 99
"let g:ycm_auto_trigger = 1 
"let g:ycm_semantic_triggers = {'c': ['']}

let g:preview_markdown_auto_update = 1

"let g:clang_format#command = 'clang-format'
let g:clang_format#auto_format = 1
"let g:clang_format#style_options = {
"	}

let g:clang_format#detect_style_file = 1

let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': ['tmux', 'load-buffer', '-'],
      \      '*': ['tmux', 'load-buffer', '-'],
      \    },
      \   'paste': {
      \      '+': ['tmux', 'save-buffer', '-'],
      \      '*': ['tmux', 'save-buffer', '-'],
      \   },
      \   'cache_enabled': 1,
      \ }


"nmap <F8> :TagbarToggle<CR>

autocmd VimEnter *.c,*.h,*.cpp TagbarToggle

let g:tagbar_compact = 1
let g:tagbar_sort = 0

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
	"autocmd VimEnter * :Vexplore
	nmap <F8> :Vexplore<CR> 
augroup END

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ?  "\<C-n>" :
	  \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

noremap <C-a> :Files<CR>

" Default fzf layout
" - Popup window (center of the screen)
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Popup window (center of the current window)
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" - Popup window (anchored to the bottom of the current window)
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10new' }
