" Plugins
    if !filereadable($HOME . '/.vim/autoload/plug.vim') && confirm("Clone vim-plug?","Y\nn") == 1
        exec '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
    call plug#begin('~/.vim/plugged')

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'skielbasa/vim-material-monokai'
    Plug 'tpope/vim-unimpaired'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-fugitive'

    call plug#end()
    map <C-n> :NERDTreeToggle<CR>

" General Vim settings
    set background=dark
    if (has("termguicolors"))
        set termguicolors
    endif
    color material-monokai
    "hi Normal guibg=NONE ctermbg=NONE
    syntax on
    let mapleader=","
    set autoindent
    set smartindent
    set path=**
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set shiftround
    set expandtab
    set dir=/tmp/
    set relativenumber 
    set number
    set hidden
    set nocompatible
    set nobackup
    set nowritebackup
    set noswapfile
    set nowrap
    autocmd Filetype html setlocal sw=2 expandtab
    autocmd Filetype javascript setlocal sw=4 expandtab

    set hlsearch
    nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
    " nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
    " nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>

    nnoremap n nzzzv
    nnoremap N Nzzzv

    nnoremap H 0
    nnoremap L $
    nnoremap J G
    nnoremap K gg

    map <tab> %

    set backspace=indent,eol,start

    nnoremap <Space> za
    nnoremap <leader>z zMzvzz

    nnoremap vv 0v$

    set listchars=tab:\|\ 
    nnoremap <leader><tab> :set list!<cr>
    set pastetoggle=<F2>
    set mouse=a
    set incsearch

" Language Specific
    " Tabs
    so ~/dotfiles/vim/sleuth.vim

    " Typescript
    autocmd BufNewFile,BufRead *.ts set syntax=javascript
    autocmd BufNewFile,BufRead *.tsx set syntax=javascript

    " Markup
    inoremap <leader>< <esc>I<<esc>A><esc>yypa/<esc>O<tab>

" File and Window Management 
    inoremap <leader>w <Esc>:w<CR>
    nnoremap <leader>w :w<CR>

    inoremap <leader>q <ESC>:q<CR>
    nnoremap <leader>q :q<CR>

    inoremap <leader>x <ESC>:x<CR>
    nnoremap <leader>x :x<CR>

    nnoremap <leader>e :Ex<CR>
    nnoremap <leader>t :tabnew<CR>:Ex<CR>
    nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
    nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>

" Return to the same line you left off at
    augroup line_return
    au!
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
    \ endif
    augroup END

" Auto load
	" Triger `autoread` when files changes on disk
	" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
	" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
	set autoread 
	" Notification after file change
	" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
	autocmd FileChangedShellPost *
	  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

filetype plugin indent on

" vim-go 
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_build_constraints = 1
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go set number fo+=croq tw=100
    autocmd Filetype go set makeprg=go\ build\ .

    if exists('+termguicolors') && ($TERM == "st-256color" || $TERM == "tmux-256color")
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif
