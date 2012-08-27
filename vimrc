"File ~/.vimrc
" Global settings for all files

set nocompatible
filetype plugin indent on   " Automatically detect file types
syntax on                   " syntax highlightinet 
set cursorline              " hightight current line
hi cursorline guibg=#333333     " highlight bg color of current line
hi CursorColumn guibg=#333333   " highlight cursor
set shortmess+=I

set backspace=indent,eol,start  " backspace for dummys
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high 
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
" set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
" set gdefault                    " the /g flag on :s substitutions by default
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set nrformats=
colorscheme desert
set colorcolumn=80

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=2                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set softtabstop=2               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with % 
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" accept mouse movement
set mouse=a

" allows Vim to manage multiple buffers properly
set hidden

" change <Leader> from '\' to ','
let mapleader=','

" increasae history from 20 to 1000
set history=1000


" give title to open page
set title

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


" run ~/.vim/autoload/pathogen.vim
call pathogen#infect()

highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white 
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black 
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black 
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black

" Key remapping
inoremap jk <Esc>
" key mapping to change behvaviour of omni-completion
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

let g:ruby_debugger_default_script = 'script/rails s'
let g:ruby_debugger_debug_mode = 1

" Having issues with arrow keys in insert mode
" http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell
:set term=cons25
