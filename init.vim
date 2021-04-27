if empty(glob('~/.config/nvim/autoload/plug.vim'))
	echo 'Downloading junegunn/vim-plug to manage plugins...'
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! execute '!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim'
endif
source ~/.config/nvim/_machine_specific.vim

let &t_ut=''
set autochdir
set autoindent
set cursorline
set ignorecase
set inccommand=split
set list
set listchars=tab:\|\ ,trail:▫
set noexpandtab
set number
set relativenumber
set scrolloff=5
set shiftwidth=4
set shortmess+=c
set showcmd
set signcolumn=yes
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set updatetime=100
set wildmenu
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

let mapleader=' '
noremap <Leader>' :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
noremap <Leader><Leader> <Esc>/<++><CR>:nohlsearch<CR>c4l
noremap <Leader>h <C-W>h
noremap <Leader>j <C-W>j
noremap <Leader>k <C-W>k
noremap <Leader>l <C-W>l
noremap mj :m+<CR>
noremap mk :m-2<CR>
noremap s <Nop>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sk :set nosplitbelow<CR>:split<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
noremap te :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
noremap tq :tabclose<CR>
vnoremap Y "+y

call plug#begin('~/.config/nvim/plugged')
Plug 'https://hub.fastgit.org/ajmwagar/vim-deus'
Plug 'https://hub.fastgit.org/airblade/vim-gitgutter'
Plug 'https://hub.fastgit.org/dhruvasagar/vim-table-mode', {'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug']}
Plug 'https://hub.fastgit.org/fatih/vim-go', {'for': ['go', 'vim-plug']}
Plug 'https://hub.fastgit.org/iamcco/markdown-preview.nvim', {'do': 'cd app && npm install'}
Plug 'https://hub.fastgit.org/itchyny/lightline.vim'
Plug 'https://hub.fastgit.org/junegunn/fzf.vim'
Plug 'https://hub.fastgit.org/mbbill/undotree'
Plug 'https://hub.fastgit.org/neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" === vim-deus
colorscheme deus
hi Normal ctermfg=none ctermbg=none

" === vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_modified_removed = '▒'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nnoremap <Leader>g- :GitGutterPrevHunk<CR>
nnoremap <Leader>g= :GitGutterNextHunk<CR>
nnoremap <Leader>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>

" === vim-table-mode
noremap <Leader>tm :TableModeToggle<CR>

" === vim-go
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_doc_popup_window = 1
let g:go_echo_go_info = 0
let g:go_fmt_command = 'goimports'
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0

" === markdown-preview.nvim
nmap <Leader>mp <Plug>MarkdownPreview

" === lightline.vim
let g:lightline = {
	\ 'colorscheme': 'seoul256',
	\ 'active': {
	\     'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'charvaluehex']]
	\ },
	\ 'component': {
	\     'charvaluehex': '0x%B'
	\ },
	\ }
let g:lightline.component = {
	\ 'close': '%999X ✗ ',
	\ }

" === fzf.vim
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND='ag -f --hidden --ignore .git -g ""'
map <Leader>f :Files<CR>
map <Leader>a :Ag<CR>

" === undotree
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_DiffpanelHeight = 8
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 24
let g:undotree_WindowLayout = 2
function g:Undotree_CustomMap()
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
endfunc

" === coc.nvim
let g:coc_global_extensions = [
	\ 'coc-diagnostic',
	\ 'coc-explorer',
	\ 'coc-json',
	\ 'coc-phpls',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ ]
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-N>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <C-O> coc#refresh()
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-Y>" : "\<C-G>u\<CR>"
nmap <silent> <Leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>= <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nmap <Leader>rf <Plug>(coc-refactor)
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>e :CocCommand explorer<CR>

nnoremap ff :call PHPFMT()<CR>
function! PHPFMT()
	if &filetype == 'php'
		silent! execute '!php-cs-fixer fix % --config=/Users/4lkaid/Documents/php_cs/.php_cs'
	endif
endfunction

execute 'nohlsearch'

if has_machine_specific_file == 0
	execute 'e ~/.config/nvim/_machine_specific.vim'
endif
