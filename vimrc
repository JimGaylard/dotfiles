" Basics {

  "correct setup for vim-plug
    call plug#begin('~/.config/nvim/plugged')
      source ~/.config/nvim/vimrc.bundles
    call plug#end()
" }



" General {

  set inccommand=nosplit
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

  let g:python_host_prog = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
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
  autocmd FileType yaml setl indentkeys-=<:>

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
  autocmd FileType c,cpp,java,go,php,javascript,ruby,haskell,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

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
    au FileType go nmap <Leader>gr :GoRename 
    au FileType go nmap <Leader>gm :GoMetaLinter<CR>

" }

" Plugins {
    " Ag {
      nnoremap <leader>ag :Ag 
    " }

    " Ctags {
      set tags=tags,./tags;/,~/.vimtags
    " }

    " deoplete {
      let g:deoplete#enable_at_startup = 1
    " }

    " Fireplace {
        nnoremap <leader>e :Eval<CR>
    "}

    " Ghc-Mod {
      nnoremap <leader>ht :GhcModType<CR>
      nnoremap <leader>htc :GhcModTypeClear<CR>
    " }

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
    " ListToggle {
      " Toggle loclist
        let g:lt_location_list_toggle_map = '<TAB><TAB>'
    " }

    " Neomake {
      " This setting will open the |loclist| or |quickfix| list (depending on whether
      " it is operating on a file) when adding entries. A value of 2 will preserve the
      " cursor position when the |loclist| or |quickfix| window is opened. Defaults to 0.
      autocmd! BufWritePost * Neomake
    " }

    " RainbowParentheses {

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
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Denite {
      nnoremap <C-p> :Denite -buffer-name=file_rec -direction=dynamictop -highlight_matched_char=false file_rec<cr>
      nnoremap <Leader>b :Denite -buffer-name=buffers -direction=dynamictop -highlight_matched_char=false buffer<cr>

      " Change mappings.
      call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
      call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)

      " Change matchers.
      call denite#custom#source(
      \ 'file_rec', 'matchers', ['matcher_cpsm'])
        " or 'matcher_fuzzy' with 'matcher_project_files'

      " Change sorters.
      call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])
        " or try 'sorter_rank'

      " Add custom menus
      let s:menus = {}

      " Ag command on grep source
      call denite#custom#var('grep', 'command', ['ag'])
      call denite#custom#var('grep', 'default_opts',
          \ ['-i', '--vimgrep'])
      call denite#custom#var('grep', 'recursive_opts', [])
      call denite#custom#var('grep', 'pattern_opt', [])
      call denite#custom#var('grep', 'separator', ['--'])
      call denite#custom#var('grep', 'final_opts', [])

      " Change ignore_globs
      call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [ '.git/', '.ropeproject/', '__pycache__/',
            \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
            \   '.stack-work/'])

        " Unite {
          " call unite#filters#matcher_default#use(['matcher_fuzzy'])
          " call unite#filters#sorter_default#use(['sorter_rank'])
          " call unite#custom#source('file_rec/git', 'ignore_pattern', 'vendor')
          " nnoremap <C-p> :Unite -start-insert -no-split file_rec/git<cr>
          " "nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffers buffer<cr>
          " nnoremap <leader>b :Unite buffer -no-split<cr>
          " let g:unite_source_grep_command = 'ag'
          " let g:unite_source_grep_default_opts =
          "       \ '--vimgrep --line-numbers --nocolor --nogroup --hidden --ignore ' .
          "       \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
          " let g:unite_source_grep_recursive_opt = ''
        " }

    " }

    " { vim-go
      " Use goimports instead of goformat
      let g:go_auto_type_info = 1
      let g:go_autodetect_gopath = 1
      let g:go_fmt_command = "goimports"
      let g:go_fmt_fail_silently = 1
      let g:go_highlight_build_constraints = 1
      let g:go_highlight_extra_types = 1
      let g:go_highlight_functions = 1
      let g:go_highlight_interfaces = 1
      let g:go_highlight_methods = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_structs = 1
      let g:go_list_type = "quickfix"

    " }

    " vim-markdown {
      let g:vim_markdown_folding_disabled = 1
    " }

    " vimux {
      nnoremap <leader>r :VimuxRunLastCommand<CR>
      nnoremap <leader>s :VimuxRunCommand ''<left>
      nnoremap <leader>z :VimuxZoomRunner<CR>
      nnoremap <Leader>x :VimuxInterruptRunner<CR>
      nnoremap ˚ :VimuxScrollUpInspect<CR>
      nnoremap ∆ :VimuxScrollDownInspect<CR>
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

