" Martin H. Bielecki
" martinhb[at]ifi.uio...

"version 7.3 "vim version

" ** PLUGINS **
" *************
" - NERDtree        -File browser
" - taglist         -Tag browser
" - codepad         -paste to codepad.org (:CPPaste to Paste. :CPRun to paste and run)
" - MATRIX MODE     -Speaks for itself (very bugged)
" - SearchComplete  -TAB completion when searching for text
" - Tasklist        -Shows TODO
" - Snipmate        -Snippets
" - Conqueterm      -Run terminal in vim
" - TagBar          -Tag browser (replaces taglist)
" - Closetag        -Easy closing of HTML/XML tags
" - Surround        -Manage surroundings
" - Matchit         -Easy tag matching
" - And many more...

" ** SETTINGS **
" **************
filetype plugin indent on       " use file specific plugins and indents
let g:swank_log=1
" Leader keybinds
let mapleader="," "Set to comma instead of the default \
noremap <Leader>f :FufFileWithCurrentBufferDir<CR>
noremap <Leader>F :FufFileWithFullCwd<CR>
noremap <Leader>r :RainbowParenthesesToggleAll<CR>


noremap <Leader>y I<Esc>v$hy
noremap <Leader>d I<Esc>v$hd

" Rebind split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


set autoindent                  "autoindent new lines  
set autoread                    "automatically re-read when file is changed
set backspace=indent,eol,start  "smart backspacing
"set backupdir=~/.vim/backup     "directory for backups
set cindent                     "auto-indent things in braces, loops, conditions etc
"set colorcolumn=91
set cursorline
"set directory=~/.vim/tmp        "directory for swap-files
set expandtab                   "convert tabs to spaces. Use CTRL-V<TAB> to enter a real tab
set history=50                  "remember 50 commands
set linespace=0                 "no extra space between lines
set incsearch                   "search while typing
set ignorecase                  "case insensitive
set laststatus=2                "if == 2, use status bar
set list                        "show chars indicated by listchars
set listchars=tab:>·,trail:·   " show tabs and trailing whitespace
set mouse=a                     "enable mouse
set matchtime=2                 "show matchin braces in tenths of a second
set wrap                        "wrap long lines
set nocompatible                "VIM is VI Improved for a reason
set noerrorbells                "no sounds
set novisualbell                "no blink on error
set nocopyindent                "follow previous indent level
set number                      "turn on linenumbering
set ruler                       "status bar / line info
set smartindent                 "auto-indent things in braces
set smartcase                   "dont ignore case when the search term specificaly contains some uppercase characters
set shiftwidth=4                "number of spaces per indent level 
set softtabstop=4               "insert 4 spaces when tab is pressed
set statusline=%#Time#%{strftime(\"\%a\ \%d\ \%b\ \%H:\%M\ \ \",localtime())}\ %#Filepath#[\%F]%#Filetype#\ %y%#Flags#\ %M\ \ %r\ %h\ %w\ %=%L\ lines\ \ \ %#Percentage#[%p%%]%#Positions#\ %6l,%4c%V\ \ \ 
set tabstop=8                   "an actual tab is 8 spaces.
set textwidth=89               "generate newline at col 90
set hlsearch                    "search highlighting
set vb
set wildignore=.dll,.o,.obj,    " do not list these file extensions
              \.bak,.exe,.pyc,.jpg,.gif,.png,.wmv,.pdf,.avi,.mpg,
              \.divx,.so,.a,.class
set wildmenu
syntax on                       "set syntax higlighting on

" Color my vim pliz
let &t_Co=256

"Arrow key shortcuts
nnoremap <silent> <Left>    :tabprevious<CR>
nnoremap <silent> <Right>   :tabnext<CR>
imap <up> <nop>
nnoremap <silent> <Up>      :TagbarToggle<CR>
nnoremap <silent> <down>    :NERDTreeToggle<CR>
nnoremap <silent> <S-down>  :FufFile<CR>

"" disable arrow keys (for movement)
""map <up> <nop>
""map <down> <nop>
""map <left> <nop>
""map <right> <nop>
"
""imap <down> <nop>
""imap <left> <nop>
""imap <right> <nop>
"
"
" Use Command-TAB (on mac OS X) to complete words
" Usual completion is on <C-n> and <C-p> but more trouble to press all the time
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction

:inoremap <A-Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" ** FOLDING **
" *************

set foldmethod=syntax "folding is based on the indentation
set foldlevel=10 "Dont let anything be folded when VIM is started
set foldnestmax=10
set nofoldenable
"Folding commands: zo - open fold. zR - open all folds. zc - close fold. zM - close all folds.

" ** MAPPINGS **
" **************

"Map escape key to a quick double tap on the j-key
imap jj <Esc>

" \s - substitute on this line
" \S - substitute all with confirmation
nmap \s :s///g<Left><Left><Left>
nmap \S :%s///gc<Left><Left><Left><Left>

" \h - nohls (remove search higlights)
" \H - hls (set search higlights)
nmap \h :nohls<Enter>
nmap \H :set hls<Enter>

" inserts a closing bracket after an opening bracket and puts the cursor in the middle of them
inoremap {<CR> {<CR>}<Esc>O

" Matching characters
""inoremap " ""<Esc>hi

" Fold/unfold JavaDoc
nmap \j :g/\/\*\*/ foldo<CR>:nohls<CR>
nmap \J :g/\/\*\*/ foldc<CR>:nohls<CR>

" Make space in normal mode go down a screenfull
nnoremap <space> <C-f>
nnoremap <S-space> <C-b>
inoremap <silent> <C-space> <C-x><C-o>

" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" double "quote" a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word (LAGS WTF)
"nnoremap wq :silent! normal mpeld bhd `ph<CR>

" ** FILETYPE SPECIFIC **
" ***********************

filetype on
filetype indent on
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window=1

"Java specific
au Filetype java setlocal omnifunc=javacomplete#Complete completefunc=javacomplete#CompleteParamsInfo

"Less specific
au BufNewFile,BufRead *.less   set filetype=less syntax=less

"Make files
autocmd FileType    make        set softtabstop=0 noexpandtab shiftwidth=8 "Makefiles need real tabs

"Python specific - OmniCompletion
autocmd FileType    python      set omnifunc=pythoncomplete#Complete foldmethod=indent

"Maude syntax
au BufNewFile,BufRead *.maude   set filetype=maude
autocmd FileType    maude       set syntax=maude
" Maude comment
autocmd FileType    maude       map - :s/^/\***<CR>:nohlsearch<CR>
"sparql syntax
autocmd FileType    rq       set syntax=sparql

"LaTeX
au BufNewFile,BufRead *.tex     set filetype=tex

"RDF Notation 3 Syntax
augroup filetypedetect
au BufNewFile,BufRead *.n3  setfiletype n3
au BufNewFile,BufRead *.ttl  setfiletype n3
augroup END

" Comment lines with -. Uncomment with Shift -
autocmd FileType    python,ruby,asm,ttl     map - :s/^/#/<CR>:nohlsearch<CR>
autocmd FileType    c,cpp,java,php,scala  map - :s/^/\/\//<CR>:nohlsearch<CR>
autocmd FileType    tex,emerald        map - :s/^/%/<CR>:nohlsearch<CR>
map _ :s/^\/\/\\|^--\\^> \\|^[*#"%!;]//<CR>:nohls<CR>


" F8  - comment this line with JavaDoc comments
autocmd FileType c,cpp,java map <F8>  :s:^\s*:&\/\*\* :<CR>:s:$: \*\/:<CR>:nohls<CR>
" F9 - uncomment FOLLOWING pair/block of C-style comments (and JavaDoc)
autocmd FileType c,cpp,java map <F9> :/\/\*/,/\*\//s:\/\*\*\= \=\\|\*\/\\|^\s*\*::g<CR>:nohls<CR>

"HTML/XML specific
" F8  - comment this line with HTML comments
autocmd FileType html map <F8> :s:^\s*:&<!-- :<CR>:s:$: -->:<CR>:nohls<CR>
" F9 - uncomment FOLLOWING pair/block of HTML comments
autocmd FileType html map <F9> :/<!--/,/-->/s:<!-- \=\\| \=-->::g<CR>:nohls<CR>
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/plugin/closetag.vim

 " For quick Java compiling in VIM when too lazy to switch to terminal
autocmd FileType    java            map <F6> :w<CR>:!echo -- Compiling %; javac %<CR>
autocmd FileType    java            map <F7> <S-F7><CR>
autocmd FileType    java            map <S-F7> :!echo -- Running %<; java %<

autocmd FileType    tex             map <F6> :w<CR>:!echo -- Compiling %; pdflatex %<CR>
" For simple compiling

autocmd FileType    c               map <F6> :w<CR>:!echo -- Compiling %; gcc -o %< %<CR>
autocmd FileType    cpp             map <F6> :w<CR>:!echo -- Compiling %; g++ -o %< %<CR>
autocmd FileType    c,cpp           map <F7> <S-F7><CR>
autocmd FileType    c,cpp           map <S-F7> :!echo -- Running %<; ./%<
autocmd FileType    python          map <F7> <S-F7><CR>
autocmd FileType    python          map <S-F7> :!echo -- Running %; python %
autocmd FileType    lisp            map <F6> :w <CR>:!echo -- Running CLISP %<; clisp %< <CR>

" Scala
autocmd FileType    scala           map <F6> :w<CR>:!echo -- Compiling %; scalac %<CR>
autocmd FileType    scala           map <F7> <S-F7><CR>
autocmd FileType    scala           map <S-F7> :!echo -- Running %<; scala %<

" Maude
autocmd FileType maude              map <F6> :w <CR>:!echo -- Running maude %<; maude %< <CR>

"Scala syntax
au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim

"Emerald syntax
au BufRead,BufNewFile *.m set filetype=emerald

" Racket
au BufRead,BufNewFile *.rkt,*.rktl  set filetype=racket
"au! Syntax racket source ~/.vim/syntax/racket.vim

" Let Slimv load on common lisp only (dont get it to work with anything else than common lisp)
let g:slimv_disable_scheme = 1
let g:slimv_disable_clojure = 1

" ** GUIOPTIONS **
" ****************
colorscheme lucius

if has ("gui_running")
        set guioptions-=T               "removes toolbar in gvim
        colorscheme lucius              "lucius colorscheme
        set autochdir                   "cd to dir of current file
        "syntax off                     "let the colorscheme handle the syntax
        set listchars=tab:>·,trail:·    "show tabs and trailing whitespace
        set guioptions-=R               "scrollbars
        set guioptions-=r
        set guioptions-=L
        set guioptions-=B
        set guioptions+=c
        set guioptions+=a
        set guifont=Monaco:h11
        set fuoptions=maxhorz,maxvert
endif

" Quickly edit/reload the vimrc file
nmap <silent> <Leader>ev :tabnew $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>

" type :set go+=T to display toolbar
map <F3> :Matrix<CR>
" can i has terminal
map <F4> :ConqueTermVSplit bash<CR>
let g:ConqueTerm_TERM = 'xterm-256color'
"let g:ConqueTerm_Color = 2

"Scala tagbar
let g:tagbar_type_scala = {
     \ 'ctagstype' : 'scala',
     \ 'kinds'     : [
        \ 'p:packages:1' ,
        \ 'V:values' ,
        \ 'v:variables' ,
        \ 'T:types' ,
        \ 't:traits' ,
        \ 'o:objects' ,
        \ 'a:aclasses' ,
        \ 'c:classes' ,
        \ 'r:cclasses' ,
        \ 'm:methods'
     \ ],
     \ 'sro'     : '.',
     \ 'kind2scope':{
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
     \ },
     \ 'scope2kind':{
        \ 'type'           : 'T',
        \ 'trait'          : 't',
        \ 'object'         : 'o',
        \ 'abstract class' : 'a',
        \ 'class'          : 'c',
        \ 'case class'     : 'r'
     \ },
     \ 'deffile' : expand('<sfile>:h') . '/.vim/ctags-scala'
 \ }

" Rainbow Parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
