"---------------------------------------------------------------------------------
"TABLE OF CONTENTS
"
"   #Bootstrap ......................... Startup
"   #Look .............................. Look & Feel
"   #Control ........................... Mouse, windowing, search, etc
"   #State ............................. Undo, swap, views
"   #Mappings .......................... Keyboard an other mappings
"   #Syntax ............................ Syntax highlighting and checking options
"   #Finish ............................ Final steps (.vimrc.local, etc)
"
"---------------------------------------------------------------------------------


" ---------------------------------------------------------------------------------
" #Bootstrap
" ---------------------------------------------------------------------------------
set nocompatible
set encoding=utf-8

" load plugins from vundle
source ~/.vim/plugins.vim


" ---------------------------------------------------------------------------------
" #Look
" ---------------------------------------------------------------------------------
" Color Scheme
set number
let g:solarized_termcolors=256
set background=dark
color solarized
hi clear SignColumn

"Formatting
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set matchpairs+=<:>             " match, to be used with %
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set backspace=indent,eol,start

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Misc
set laststatus=2
set hlsearch                    " Hilight search results
set showmatch                   " Show search results as I type
set title                       " I don't really know that this is doing anything
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to

" Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

"Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '•', '-']
let g:airline_section_x = airline#section#create_right(['filetype'])
let g:airline_theme='powerlineish'

"Syntastic Options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Signify Options
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_add               = '+'
let g:signify_sign_change            = '•'
let g:signify_sign_delete            = '-'

" ---------------------------------------------------------------------------------
" #Control
" ---------------------------------------------------------------------------------
set mouse=a "Use the Mouse
if !has("nvim")
    "set clipboard=exclude:.* "Kill unnamed yank mapping to clipboard
    set ttymouse=xterm2 "Needed to drag splits in tmux
endif
let mapleader=' ' "Use the space as the leader key
set ttyfast

"Editor...
set virtualedit=onemore "Allow for cursor beyond last character
set splitbelow
set splitright
set winheight=10
set winminheight=3
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.

"Search
set incsearch "Show search results as you type
set ignorecase
set smartcase


" ---------------------------------------------------------------------------------
" #State
" ---------------------------------------------------------------------------------
"Persistent undos
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo
    set undoreload=10000
endif
set history=1000

" Backups
set backup
set backupdir=~/.vim/backup

" Persistent views
set viewdir=~/.vim/views
au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)

" Session directory
set directory=~/.vim/swap

" ---------------------------------------------------------------------------------
" #Mappings
" ---------------------------------------------------------------------------------
"Easier escapes to keep us on home-row
imap jj <esc>j
imap kk <esc>k
imap hh <esc>h

"Terminal mode version (nvim)
if has("nvim")
    tmap jj <C-\><C-n>j
    tmap kk <C-\><C-n>k
    tmap hh <C-\><C-n>h
endif

"Easier moving/resizing in windows
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>l <C-W>l
map <leader>h <C-W>h

map <silent> <C-J> :res +3<cr>
map <silent> <C-k> :res -3<cr>
map <silent> <C-l> <C-W>8>
map <silent> <C-h> <C-W>8<

"Tab Navigation
map <silent><leader>K :tabnext<cr>
map <silent><leader>J :tabprevious<cr>
map <silent><leader>T :tabnew<cr>
"The following two lines conflict with moving to top and bottom of the screen
"If you prefer that functionality, comment them out.
map <S-H> gT
map <S-L> gt
map <silent><S-T>T :tabnew<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Break line under cursor (opposite of 'J' key to join lines)
map K i<CR><Esc>

"Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <leader>/ :silent noh<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

"//TODO Learn this to memory
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier horizontal scrolling
map zl zL
map zh zH


" ---------------------------------------------------------------------------------
" #Syntax
" ---------------------------------------------------------------------------------
"Syntastic Options
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_javascript_checkers = ['eslint']

"JSX Options
let g:jsx_ext_required = 0 " Allow JSX in normal JS files


" ---------------------------------------------------------------------------------
" #Finish
" ---------------------------------------------------------------------------------
" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
