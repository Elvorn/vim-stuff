" Martin H. Bielecki
" martinhb[at]ifi.uio...

"version 7.3 "vim version

" ** PLUGINS **
" *************

" - NERDtree        -File browser
" - taglist         -Tag browser
" - codepad         -paste to codepad.org (:CPPaste to Paste. :CPRun to paste and run)
" - MATRIX MODE     -Speaks for itself
" - SearchComplete  -TAB completion when searching for text
" - Tasklist        -Shows TODO
" - Snipmate        -Snippets
" - Conqueterm      -Run terminal in vim

" ** SETTINGS **
" **************

"filetype plugin indent on       " use file specific plugins and indents

set autoindent                  "autoindent new lines  
set autoread                    "automatically re-read when file is changed
set backspace=indent,eol,start  "smart backspacing
"set backupdir=~/.vim/backup     "directory for backups
set cindent                     "auto-indent things in braces, loops, conditions etc
set colorcolumn=91
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
set textwidth=119               "generate newline at col 80
set hlsearch                    "search highlighting
set vb
set wildignore=.dll,.o,.obj,    " do not list these file extensions
              \.bak,.exe,.pyc,.jpg,.gif,.png,.wmv,.pdf,.avi,.mpg,
              \.divx,.so,.a
set wildmenu
syntax on                       "set syntax higlighting on

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"Arrow key shortcuts
nnoremap <silent> <Left>    :tabprevious<CR>
nnoremap <silent> <Right>   :tabnext<CR>
nnoremap <silent> <Up>      :TlistToggle<CR> 
nnoremap <silent> <down>    :NERDTreeToggle<CR>

" disable arrow keys (for movement)
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>


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

" Fold/unfold JavaDoc
nmap \j :g/\/\*\*/ foldo<CR>:nohls<CR>
nmap \J :g/\/\*\*/ foldc<CR>:nohls<CR>

" Make space in normal mode go down a screenfull
nnoremap <space> <C-f>
nnoremap <S-space> <C-b>

" ** FILETYPE SPECIFIC **
" ***********************

filetype on
filetype indent on
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window=1

"Java specific
"autocmd FileType    java        abbr sopl System.out.println("
"autocmd FileType    java        imap sopl sopl<ESC>a
"autocmd Filetype    java        abbr psvm public static void main(String[] args) {
"autocmd FileType    java        imap psvm psvm

au BufNewFile,BufRead *.less   set filetype=less syntax=css

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

"RDF Notation 3 Syntax
augroup filetypedetect
au BufNewFile,BufRead *.n3  setfiletype n3
au BufNewFile,BufRead *.ttl  setfiletype n3
augroup END


" Comment lines with -. Uncomment with Shift -
autocmd FileType    python,ruby,asm,ttl     map - :s/^/#/<CR>:nohlsearch<CR>
autocmd FileType    c,cpp,java,php,scala  map - :s/^/\/\//<CR>:nohlsearch<CR>
map _ :s/^\/\/\\|^--\\^> \\|^[*#"%!;]//<CR>:nohls<CR>


" F8  - comment this line with JavaDoc comments
autocmd FileType c,cpp,java map <F8>  :s:^\s*:&\/\*\* :<CR>:s:$: \*\/:<CR>:nohls<CR>
" F9 - uncomment FOLLOWING pair/block of C-style comments (and JavaDoc)
autocmd FileType c,cpp,java map <F9> :/\/\*/,/\*\//s:\/\*\*\= \=\\|\*\/\\|^\s*\*::g<CR>:nohls<CR>

"HTML specific
" F8  - comment this line with HTML comments
autocmd FileType html map <F8> :s:^\s*:&<!-- :<CR>:s:$: -->:<CR>:nohls<CR>
" F9 - uncomment FOLLOWING pair/block of HTML comments
autocmd FileType html map <F9> :/<!--/,/-->/s:<!-- \=\\| \=-->::g<CR>:nohls<CR>

 " For quick Java compiling in VIM when too lazy to switch to terminal
autocmd FileType    java            map <F6> :w<CR>:!echo -- Compiling %; javac %<CR>
autocmd FileType    java            map <F7> <S-F7><CR>
autocmd FileType    java            map <S-F7> :!echo -- Running %<; java %<

" For simple compiling autocmd FileType    c               map <F6> :w<CR>:!echo -- Compiling %; gcc -o %< %<CR>
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

" ** GUIOPTIONS **
" ****************
colorscheme molokai

if has ("gui_running")
	set guioptions-=T 		"removes toolbar in gvim
	colorscheme tango2		"midnight colorscheme
	set autochdir                   "cd to dir of current file
	"syntax off			"let the colorscheme handle the syntax
        set guioptions-=R "scrollbars
        set guioptions-=r
        set guioptions-=L
        set guioptions-=B
	set guioptions+=c
	set guioptions+=a
        set guifont=Monaco:h11
        set fuoptions=maxhorz,maxvert
	
endif


" type :set go+=T to display toolbar
map <F3> :Matrix<CR>
" can i has terminal
map <F4> :ConqueTermVSplit bash<CR>
let g:ConqueTerm_TERM = 'xterm-256color'
"let g:ConqueTerm_Color = 2

