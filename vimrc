" Basics {

  "correct setup for bundle
  filetype on
  filetype off
  set rtp+=~/.config/nvim/bundle/neobundle.vim

  " Use git protocol.
  let g:neobundle#types#git#default_protocol = 'ssh'

  call neobundle#begin(expand('~/.config/nvim/bundle/'))

  "YouCompleteMe is slow to update
  let g:neobundle#install_process_timeout = 1800

  NeoBundleFetch 'Shougo/neobundle.vim'
  " Use neobundle standard recipes.
  NeoBundle 'Shougo/neobundle-vim-recipes', {'force' : 1}

  source ~/.config/nvim/vimrc.bundles
  call neobundle#end()

  filetype plugin indent on   " Automatically detect file types.

  NeoBundleCheck
" }



" General {

  set noswapfile
  set exrc " use project vimrc

  let mapleader = ','

  set background=dark         " Assume a dark background
  if !has('gui')
      "set term=$TERM          " Make arrow and other keys work
  endif
  syntax on                   " Syntax highlighting
  scriptencoding utf-8

  set ttimeoutlen=10

  "if has ('x') && has ('gui') " On Linux use + register for copy-paste
  "    set clipboard=unnamedplus
  "else           " On mac and Windows, use * register for copy-paste
  "    set clipboard=unnamed
  "endif

  "set autowrite                       " Automatically write a file when leaving a modified buffer
  set shortmess+=filmnrxoOtTI          " Abbrev. of messages (avoids 'hit enter')
  set history=1000                    " Store a ton of history (default is 20)
  set nospell                           " Spell checking on
  set hidden                          " Allow buffer switching without saving
  set lazyredraw                      " Don't show macros while they're happening
  set linebreak                       " Wrap but don't insert EOL
" }

" Vim UI {

  color xoria256                 " Load a colorscheme

  set noshowmode

  highlight clear SignColumn      " SignColumn should match background for
                                  " things like vim-gitgutter
  highlight clear LineNr          " Current line number row will have same background color in relative mode.
                                  " Things like vim-gitgutter will match LineNr highlight
  highlight clear CursorLineNr   " Remove highlight color from current line number

  set colorcolumn=80
  set colorcolumn=+1

  if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
  endif

  if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    "set statusline= %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
    set statusline=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ %<%.55F\                     " Filename
    set statusline+=%w%h%m%r%q                 " Options
    set statusline+=%=%y\ %(%l,%c%V%)\ %p%%  " Right aligned file nav info

    set t_Co=256
  endif

  set backspace=indent,eol,start  " Backspace for dummies
  set linespace=0                 " No extra spaces between rows
  set showmatch                   " Show matching brackets/parenthesis
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set wildmenu                    " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set list                        " Higlights whitespace etc.
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

  autocmd Filetype go setlocal listchars=tab:\ \ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
  " Add .cabal (haskell) to PATH
  let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" }


" Formatting {

  set nowrap                      " Wrap long lines
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=2 tabstop=2 softtabstop=2
  set expandtab                   " Tabs are spaces, not tabs
  set matchpairs+=<:>             " Match, to be used with %
  set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
  " Remove trailing whitespaces and newline chars
  autocmd FileType c,cpp,java,go,php,javascript,ruby,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

  autocmd BufRead,BufNewFile *.log set filetype=log
  autocmd BufRead,BufNewFile */log/* set filetype=log
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

  " Use goimports instead of goformat
  let g:go_fmt_command = "goimports"

" }

" Key (re)Mappings {
    nnoremap <leader>v :tabedit $MYVIMRC<CR>
    nnoremap <leader>map :TBrowseOutput map<CR>

    nnoremap / /\v

    nnoremap <leader>w mp:%s/\s\+$/<CR>'p

    nnoremap <leader>n :NumbersToggle<CR>

    nnoremap ,cf :let @*=expand("%")<CR>
    nnoremap ,cp :let @*=expand("%:p")<CR>

    nnoremap ,t :!ctags -R .<CR>
    "autocmd BufWritePost *.rb,*.js silent! !/usr/local/bin/ctags -R 2> /dev/null &

    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map <S-H> gT
    map <S-L> gt

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Stupid shift key fixes
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>

    cmap Tabe tabe

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Toggle search highlighting
    nnoremap <silent> <leader>/ :let @/ = ""<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " vim-go maps
    au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" }

" Plugins {

    " Ctags {
      set tags=tags,./tags;/,~/.vimtags
    " }

    " Fireplace {
        nnoremap <leader>e :Eval<CR>
    "}

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gvdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit -v<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
    "}

    "gist-vim {
      let g:github_user = "JimGaylard"
      let g:gist_post_private = 1
    "}

    " indent_guides {
      let g:indent_guides_auto_colors = 1
      let g:indent_guides_start_level = 2
      let g:indent_guides_guide_size = 1
      let g:indent_guides_enable_on_vim_startup = 0
    " }

    " JSON {
        nnoremap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " RainbowParentheses {

      au VimEnter * RainbowParenthesesToggle
      au Syntax * RainbowParenthesesLoadRound
      au Syntax * RainbowParenthesesLoadSquare
      au Syntax * RainbowParenthesesLoadBraces
    " }

    " Tabularize {
      nmap <Leader>a& :Tabularize /&<CR>
      vmap <Leader>a& :Tabularize /&<CR>
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
      nmap <Leader>a, :Tabularize /,\zs<CR>
      vmap <Leader>a, :Tabularize /,\zs<CR>
      nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
      vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Unite {
      call unite#filters#matcher_default#use(['matcher_fuzzy'])
      call unite#filters#sorter_default#use(['sorter_rank'])
      nnoremap <C-p> :Unite file_rec/neovim:! -start-insert -no-split<cr>
      let g:unite_source_history_yank_enable = 1
      nnoremap <Leader>" :Unite history/yank<cr>
      nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffers buffer<cr>
      " Search
      let g:unite_source_grep_command = 'ag -p .agignore'
      let g:unite_source_grep_default_opts =
            \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
            \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
      let g:unite_source_grep_recursive_opt = ''
      nnoremap <Leader>ag :Unite grep:.<cr>
      "nnoremap <Leader>t :Unite tag -start-insert -auto-preview<cr>
      nnoremap <Leader>l :Unite line -start-insert<cr>
    " }

    " { vim-go
      let g:go_fmt_fail_silently = 1
      let g:go_highlight_functions = 1
      let g:go_highlight_methods = 1
      let g:go_highlight_structs = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_build_constraints = 1
    " }

    " vimux {
      nnoremap <leader>r :VimuxRunLastCommand<CR>
      nnoremap <leader>s :VimuxRunCommand ''<left>
      nnoremap <leader>z :VimuxZoomRunner<CR>
    " }

    " vim-surround {
      nmap <leader>' ys$'
      nmap <leader>" ys$"
      nmap <leader>) ys$)
      nmap <leader>} ys$}
    " }

    " YouCompleteMe {
      let g:ycm_add_preview_to_completeopt = 1
    " }

" }

" Functions {

  " Strip whitespace {
  function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endfunction
  " }

" }

" Added this line because of issues with crontab -e
" has to do with the way vim treats backup files
set backupskip=/tmp/*,/private/tmp/*
set secure " don't run autocmd from untrusted project vimrc

