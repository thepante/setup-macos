set sw=2
set mouse=a
set number
set numberwidth=1
set clipboard=unnamedplus
set shortmess=I
set showcmd
set ruler
set encoding=utf-8
set showmatch
set laststatus=2
set cmdheight=2
set ignorecase
set smartcase
set noshowmode
set nowrap
set cursorline
set hidden
set splitbelow
set scrolloff=2
set noswapfile
set tabstop=4
set expandtab
set updatetime=300
" set redrawtime=300
set signcolumn=yes
set nocompatible
" syntax enable
syntax sync fromstart
lang en_US.UTF-8

" escape insert mode
inoremap kj <Esc>
cnoremap kj <C-c>
tnoremap kj <C-\><C-n>

" Set leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" Rename a symbol
nmap <leader>r <Plug>(coc-rename)
nmap <leader>R #Ncgn

" Disable arrow keys & scroll
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <ScrollWheelUp> <Nop>
noremap <ScrollWheelDown> <Nop>

" Clear highlight using enter
noremap <CR> :noh<CR>:echo ''<CR>

" Move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Move between buffers
nnoremap <C-a> :bprev<CR>
nnoremap <C-d> :bnext<CR>

" Move between splits
nmap <leader>k :wincmd k<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>h :wincmd h<CR>
nmap <leader>l :wincmd l<CR>

" Resize splits
noremap \ :vertical resize +5<CR>
noremap \| :vertical resize -5<CR>
noremap <leader><BS> :resize -5<CR>
noremap <BS> :resize +5<CR>

" Close buffer
nnoremap <leader>w :call CloseBuffer()<CR>
" nnoremap <C-w> :b#<bar>bd#<CR>
" nnoremap <leader>w :b#<bar>bd#<CR>
" nnoremap <leader>w :bd<CR>
" nnoremap <leader>w :bp<bar>sp<bar>bn<bar>bd<CR>
" tnoremap <leader>w :bd!<CR>

" Comment toggle
nnoremap <C-N> :Commentary<CR>
vnoremap <C-N> :Commentary<CR>
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" Delete around block / delete including comments on top of it
nmap dao va{Vd
nmap dab va{o{oVd

" Tab to go matching pair
map <Tab> %

" Coc Rest-client request
noremap <Leader><CR> :CocCommand rest-client.request<CR>

" Terminal
nnoremap <leader>t :call ToggleTerminal()<CR>

" Explore files
command! -bang -nargs=* Rg call fzf#vim#grep("rg --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
map <C-Q> :NvimTreeToggle<CR>
map <C-e> :FZF ~/<CR>
map <C-T> :exe ":FZF " . expand("%:h")<CR>
map <C-p> :ProjectFiles<CR>
map <C-s> :Telescope buffers theme=dropdown<CR>
" map <C-P> :Telescope find_files<CR>
map <C-o> :CocList symbols<CR>
map <C-l> :BLines<CR>
map <C-Y> :Rg<CR>

" Files navigation with Harpoon
" map <leader>p :lua require("harpoon.ui").toggle_quick_menu()<CR>
map <leader>p :Telescope harpoon marks theme=dropdown<CR>
map <leader>m :lua require("harpoon.mark").add_file()<CR>
map <leader>a :lua require("harpoon.ui").nav_prev()<CR>
map <leader>d :lua require("harpoon.ui").nav_next()<CR>

" Git commands
nnoremap <leader>gs :!git fetch && git status<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gf :Git diff %<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

nnoremap <leader>b :Gitsigns prev_hunk<CR>zz
nnoremap <leader>n :Gitsigns next_hunk<CR>zz
nnoremap <leader>sh :Gitsigns stage_hunk<CR>
nnoremap <leader>su :Gitsigns undo_stage_hunk<CR>
nnoremap <leader>sp :Gitsigns preview_hunk<CR>

" Paste remplace inside string - without yank
nnoremap cv vi"pgvy
nnoremap ccv vi'pgvy

" FZF window & preview
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Highlight'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Highlight'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'query':   ['fg', 'Highlight'],
  \ 'prompt':  ['fg', 'Comment'],
  \ 'pointer': ['fg', 'Highlight'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ }
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--margin=0'

" Coc extensions
let g:coc_default_semantic_highlight_groups = 1
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-phpls',
  \ 'coc-blade',
  \ 'coc-pairs',
  \ ]
  " \ 'coc-vetur',
  " \ 'coc-pyright',
  " \ 'coc-restclient'

let g:user_emmet_install_global = 0
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

call plug#begin('~/.local/share/nvim/plugged')
  " Plugs requeriments
  Plug 'nvim-lua/plenary.nvim'

  " Interface
  " Plug 'rktjmp/lush.nvim'
  Plug 'ap/vim-buftabline'
  Plug 'itchyny/lightline.vim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Tools
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'suy/vim-context-commentstring'

  " Files & code navigation
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'ThePrimeagen/harpoon'
  Plug 'ggandor/lightspeed.nvim'

  " Code helpers & refactoring
  Plug 'mattn/emmet-vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'tpope/vim-surround'
  Plug 'alvan/vim-closetag'

  " Syntax highlight & text objects
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'michaeljsmith/vim-indent-object'
  " Plug 'yuezk/vim-js'

  " Themes
  Plug 'Shatur/neovim-ayu'
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
  Plug 'cocopon/iceberg.vim'
  Plug 'mcchrish/zenbones.nvim'

  " Sessions
  Plug 'rmagatti/auto-session'
call plug#end()

set termguicolors
set background=dark
" colorscheme ayu
" colorscheme zenwritten
" colorscheme tokyobones
" colorscheme neobones
colorscheme rosebones "3
" colorscheme iceberg "2
" colorscheme embark "1

" " Light theme este? si este: sacar el render de spaces (punto)
" let g:aquarium_style="light"
" colorscheme aquarium

" set background=light
" colorscheme PaperColor
" colorscheme github_light "2
" colorscheme inspired-github "1
" colorscheme zenwritten
" " colorscheme zenbones

let g:zenbones = #{ solid_line_nr: v:true, darken_comments: 45 }
let g:zenbones_compat = 0

let g:nvim_tree_git_hl = 1
" let g:nvim_tree_highlight_opened_files = 1

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'files': 0,
    \ 'folders': 1,
    \ 'folder_arrows': 1,
    \ }

" highlight NvimTreeFolderIcon guibg=blue
let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "",
    \   'staged': "﫠",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "",
    \   'deleted': "x",
    \   'ignored': ""
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "+",
    \   'symlink_open': "-",
    \   }
    \ }


let g:lightline = {
    \ 'colorscheme': 'rosebones',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'gitstatus', 'readonly' ],
    \             [ 'filename', 'modified' ]
    \           ],
    \   'right': [ [ 'cwd' ], [], [ 'lineinfo', 'fileformat', 'filetype' ] ],
    \ },
    \ 'inactive': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'gitstatus', 'readonly' ],
    \             [ 'filename', 'modified' ]
    \           ],
    \   'right': [ [ 'cwd' ], [], [ 'lineinfo', 'fileformat', 'filetype' ] ],
    \ },
    \ 'component': {
    \   'filename': '%<%{expand("%")}',
    \   'lineinfo': '%3l:%-2v',
    \   'cwd': '%{fnamemodify(getcwd(), ":t")}',
    \   'gitstatus': '%{get(b:,"gitsigns_status","")}',
    \   'gitbranch': '(%{get(b:,"gitsigns_head","")})',
    \ },
    \ 'subseparator': {
    \   'left': '',
    \   'right': '⋅',
    \ },
  \ }

lua <<EOF
require('gitsigns').setup()
require('telescope').setup { defaults = { preview = false, file_ignore_patterns = { '.git' } }, pickers = { find_files = { hidden = true } } }
require('telescope').load_extension('harpoon')

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require('indent_blankline').setup {
  show_trailing_blankline_indent = false,
  show_end_of_line = false,
}

require('nvim-tree').setup {
  -- update_cwd = 0,
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.DS_Store' },
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

require('auto-session').setup {
  log_level = 'error',
  auto_session_suppress_dirs = {'~/', '~/Projects'},
  -- post_restore_cmds = { "e" },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "vim", "javascript", "typescript", "php", "html", "json" },
  -- highlight = { enable = true },
  sync_install = true,
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF

" --- Vim-Closetag
" File extensions where the plugin is enabled
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx,*.php'
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx,*.php'
let g:closetag_filetypes = 'html,xhtml,jsx,js,tsx,php'
let g:closetag_xhtml_filetypes = 'html,xhtml,jsx,js,tsx,php'
let g:closetag_emptyTags_caseSensitive = 1

" Disables auto-close if not in a 'valid' region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

let g:closetag_shortcut = '>'

" Emmet
imap ,, <C-y>,

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" " Trigger emmet with tab or enter - TODO (combinar esto con el anterior)
" function! s:zen_html_tab()
"   return "\,,"
" endfunction
" " autocmd FileType html imap <buffer><expr><tab> <sid>zen_html_tab()
" autocmd FileType html imap <buffer><expr><CR> <sid>zen_html_tab()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-implementation)

" K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

augroup mygroun
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd FileType * setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" VSCode Neovim undo & redo
if exists('g:vscode')
  nnoremap <silent> u :<C-u>call VSCodeNotify('undo')<CR>
  nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>
endif

function! CloseBuffer()
  if getbufvar(bufnr('%'), '&buftype', 'not found') == 'terminal'
    execute 'bd!'
  else
    execute 'bd'
  endif
endfunction

function! ToggleTerminal()
  let bufType = getbufvar(bufnr('%'), '&buftype', 'not found')
  if bufType == 'terminal'
    execute 'bd!'
  else
    execute 'split term://zsh'
    execute 'resize 20'
    execute 'set nonu'
    execute 'set nornu'
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!
    startinsert!
  endif
endfunction

let g:smoothie_enabled = 0
function! ToggleSmoothie()
  if g:smoothie_enabled
    let g:smoothie_enabled = 0
  else
    let g:smoothie_enabled = 1
  endif
endfunction

command! Duplicate execute 'saveas' expand('%:r')."-copy_".localtime().'.'.expand('%:e')
command! Finder :!open %:h

autocmd BufNewFile,BufRead .aliases* set syntax=bash
autocmd BufNewFile,BufRead *CSS.html set filetype=css
autocmd BufNewFile,BufRead *.blade.php set syntax=blade

autocmd FileType html,css,jsx,tsx,vue,php,blade,php.css.html EmmetInstall
" autocmd FileType html,blade,php,css,less,scss setlocal iskeyword+=-.
autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=100})
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd TermOpen * startinsert

autocmd VimEnter * :RestoreSession<CR>
autocmd VimLeave * :SaveSession<CR>

