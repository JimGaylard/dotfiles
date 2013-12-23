


" Basics {
  set nocompatible        " Must be first line

  "correct setup for vundle
  filetype on
  filetype off
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()

" }

source ~/.vimrc.bundles
source ~/.vimrc.bundles.local

" General {

  let mapleader = ','

  set background=dark         " Assume a dark background
  if !has('gui')
      "set term=$TERM          " Make arrow and other keys work
  endif
  filetype plugin indent on   " Automatically detect file types.
  syntax on                   " Syntax highlighting
  set mouse=a                 " Automatically enable mouse usage
  set mousehide               " Hide the mouse cursor while typing
  scriptencoding utf-8

  if has ('x') && has ('gui') " On Linux use + register for copy-paste
      set clipboard=unnamedplus
  else           " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
  endif

  "set autowrite                       " Automatically write a file when leaving a modified buffer
  set shortmess+=filmnrxoOtTI          " Abbrev. of messages (avoids 'hit enter')
  set history=1000                    " Store a ton of history (default is 20)
  set spell                           " Spell checking on
  set hidden                          " Allow buffer switching without saving
" }

" Vim UI {

  let g:solarized_termtrans=1
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
  color solarized                 " Load a colorscheme
  let g:solarized_termcolors=256

  set cursorline                  " Highlight current line
  set noshowmode

  highlight clear SignColumn      " SignColumn should match background for
                                  " things like vim-gitgutter
  highlight clear LineNr          " Current line number row will have same background color in relative mode.
                                  " Things like vim-gitgutter will match LineNr highlight
  highlight clear CursorLineNr   " Remove highlight color from current line number

  set textwidth=80
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
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

    set t_Co=256
    let g:airline_powerline_fonts=1
    "let g:airline_theme='powerlineish'       " airline uses use the powerline theme
  endif

  set backspace=indent,eol,start  " Backspace for dummies
  set linespace=0                 " No extra spaces between rows
  set nu                          " Line numbers on
  set showmatch                   " Show matching brackets/parenthesis
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set wildmenu                    " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set list                        " Higlights whitespace etc.
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }


" Formatting {

  set nowrap                      " Wrap long lines
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=2 tabstop=2 softtabstop=2
  set expandtab                   " Tabs are spaces, not tabs
  set matchpairs+=<:>             " Match, to be used with %
  set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
  " Remove trailing whitespaces and ^M chars
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
  autocmd FileType go autocmd BufWritePre <buffer> Fmt

  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" }

" Key (re)Mappings {
    inoremap jk <Esc>

    nmap <leader>v :tabedit $MYVIMRC<CR>
    nmap <leader>map :TBrowseOutput map<CR>

    nmap <leader>b Orequire 'pry'; binding.pry<Esc>

    nnoremap <leader>p :set invpaste<CR>
    nmap <leader>w mp:%s/\s\+$/<CR>'p

    nnoremap <leader>n :NumbersToggle<CR>

    nmap ,cf :let @*=expand("%")<CR>
    nmap ,cp :let @*=expand("%:p")<CR>

    nmap ,gl :Git pull --rebase

    nmap ,t :!ctags -R<CR>
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
    nmap <silent> <leader>/ :let @/ = ""<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    "" Fix home and end keybindings for screen, particularly on mac
    "" - for some reason this fixes the arrow keys too. huh.
    "map [F $
    "imap [F $
    "map [H g0
    "imap [H g0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

" }

" Plugins {

    " Misc {
    " }

    " Ctags {
      set tags=./tags;/,~/.vimtags
    " }

    " AutoCloseTag {
      " Make it so AutoCloseTag works for xml and xhtml files as well
      au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
      nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    "gist-vim {
      let g:github_user = "JimGaylard"
      let g:gist_post_private = 1
    "}

    " NerdTree {
      map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
      map <leader>e :NERDTreeFind<CR>

      let NERDTreeShowLineNumbers=0
      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
      let NERDTreeChDirMode=0
      let NERDTreeQuitOnOpen=1
      let NERDTreeMouseMode=2
      let NERDTreeShowHidden=1
      let NERDTreeKeepTreeInNewTab=1
    " }

    " Numbers.vim {
      let g:numbers_exclude = ['nerdtree']
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
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }

    " ctrlp {
        let g:ctrlp_working_path_mode = 'ra'
        nnoremap <silent> <D-t> :CtrlP<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    "}

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
        nnoremap <silent> <leader>gg :GitGutterToggle<CR>
    "}

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " indent_guides {
      let g:indent_guides_auto_colors = 1
      let g:indent_guides_start_level = 2
      let g:indent_guides_guide_size = 1
      let g:indent_guides_enable_on_vim_startup = 1
  " }

    nmap <leader>d :VimuxCloseRunner<CR>

  " Vroom Config {
    let g:vroom_use_vimux = 1
    let g:vroom_cucumber_path = "cucumber"
    let g:vroom_rspec_command = 'rspec '

    let g:vimuxOrientation = "v"
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

