set mouse=a
set number
set numberwidth=1
set clipboard=unnamedplus
set shortmess=I
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set laststatus=2
set cmdheight=2
set ignorecase
set noshowmode
set nowrap
set cursorline
set hidden
set splitbelow
set scrolloff=2
set noswapfile
" set undodir=~/.vim/undodir
" set undofile
set tabstop=4
set expandtab
set updatetime=300
set signcolumn=yes
" set iskeyword+="-"
syntax enable
lang en_US.UTF-8

" escape insert mode
inoremap kj <esc>
cnoremap kj <C-c>

" Set leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" Rename a symbol
nmap <leader>r <Plug>(coc-rename)

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>
noremap <Left> :bprev<CR>
noremap <Right> :bnext<CR>

" Insert empty line
" nmap <C-k> O<Esc>j
" nmap <C-j> o<Esc>k

" Insert spaces before/after cursor
nmap <C-h> i<space><Right><Esc>
nmap <C-l> a<space><Left><Esc>

" Undo changes since last save
nmap U :edit!<CR>

" Clear search using enter
noremap <CR> :noh<CR>

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

" Close buffer
" nnoremap <C-w> :b#<bar>bd#<CR>
nnoremap <leader>w :b#<bar>bd#<CR>
" nnoremap <leader>w :bp<bar>sp<bar>bn<bar>bd<CR>

" Comment toggle
" nnoremap <S-N> :Commentary<CR>
" vnoremap <S-N> :Commentary<CR>
nnoremap <C-N> :Commentary<CR>
vnoremap <C-N> :Commentary<CR>
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" " Sneak
" nmap f <Plug>Sneak_s
" nmap F <Plug>Sneak_S
" xmap f <Plug>Sneak_s
" xmap F <Plug>Sneak_S

" Delete around block
nmap dao va{Vd

" Delete around block, including comments on top of it
nmap dab va{o{oVd

" Tab to go matching pair
map <Tab> %

" Explore files
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
map <C-Q> :NvimTreeToggle<CR>
map <C-e> :FZF ~/<CR>
map <C-T> :exe ":FZF " . expand("%:h")<CR>
map <C-p> :ProjectFiles<CR>
map <C-o> :CocList symbols<CR>
map <C-l> :BLines<CR>
map <C-Y> :Rg<CR>

" set rtp+=/usr/local/opt/FZF


" Paste remplace inside string - without yank
nnoremap cv vi"pgvy
nnoremap ccv vi'pgvy

"imap <S-,> <
"imap <S-.> >

" FZF window & preview
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--margin=0,5'

" Coc extensions
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-phpls',
  \ 'coc-blade',
  \ 'coc-vetur',
  \ 'coc-pairs',
  \ 'coc-pyright',
  \ 'coc-restclient'
  \ ]

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

set nocompatible

call plug#begin('~/.local/share/nvim/plugged')
  " Interface
  Plug 'mhinz/vim-signify'
  Plug 'ap/vim-buftabline'
  Plug 'ojroques/nvim-hardline'
  Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Tools
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'suy/vim-context-commentstring'

  " Sessions
  Plug 'rmagatti/auto-session'

  " Files navigation
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'kyazdani42/nvim-tree.lua'
  " Plug 'antoinemadec/coc-fzf'
  " Plug 'gfanto/fzf-lsp.nvim'

  " Code navigation
  " Plug 'justinmk/vim-sneak'
  Plug 'ggandor/lightspeed.nvim'

  " Code helpers
  Plug 'tpope/vim-surround'
  Plug 'alvan/vim-closetag'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'

  " Syntax highlight & text objects
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " Themes
  Plug 'Shatur/neovim-ayu'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'mvpopuk/inspired-github.vim'
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }

  Plug 'NLKNguyen/papercolor-theme'
  Plug 'cocopon/iceberg.vim'
  Plug 'rhysd/vim-color-spring-night'
  Plug 'frenzyexists/aquarium-vim', { 'branch': 'develop' }

  Plug 'mcchrish/zenbones.nvim'
call plug#end()

set termguicolors
set background=dark
" colorscheme ayu
" colorscheme iceberg "3
" colorscheme gruvbox8_hard "2
colorscheme embark "1

" " Light theme este?
" let g:aquarium_style="light"
" colorscheme aquarium

let g:zenbones = #{ solid_line_nr: v:true, darken_comments: 45 }
let g:zenbones_compat = 1

" set background=light
" colorscheme PaperColor
" colorscheme github_light "2
" colorscheme inspired-github "1
" colorscheme zenwritten
" colorscheme zenbones

" let g:signify_sign_add = '▊'
" let g:signify_sign_change = '▊'
" let g:signify_sign_add = '│'
" let g:signify_sign_change = '│'


" let g:nvim_tree_respect_buf_cwd = 1
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

lua <<EOF
-- local mini_indentscope = require('mini.indentscope')
-- mini_indentscope.setup({ draw = { animation = mini_indentscope.gen_animation('none') } })

-- require('mini.indentscope').setup {}
require('mini.trailspace').setup {}
-- require('mini.surround').setup {}

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("space: ")
-- vim.opt.listchars:append("eol:↴")

require('indent_blankline').setup {
  show_trailing_blankline_indent = false,
  show_end_of_line = false,
}

require('nvim-tree').setup {
  -- update_cwd = 0,
  filters = {
    custom = { '.git', 'node_modules' },
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
  },
}

require('hardline').setup {
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100}, -- custom @ /parts/git.lua
    '%<',
    {class = 'low', item = require('hardline.parts.filename').get_item},
    '%>',
    {class = 'med', item = '%='},
    {class = 'high', item = vim.bo.fileformat},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'low', item = require('hardline.parts.line').get_item}, -- custom @ /parts/line.lua
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
    {class = 'med', item = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")},
  }
}

require('auto-session').setup {
  log_level = 'error',
  auto_session_suppress_dirs = {'~/', '~/Projects'},
  post_restore_cmds = { "noh" },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "php", "html", "json" },
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

" Emmet (,, same as to set , as leader)
imap ,, <C-y>,
" let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css,jsx,tsx,vue,php,blade,php.css.html EmmetInstall

" PENDIENTE:
" au FileType html imap <buffer><expr><tab> <sid>zen_html_tab()

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-implementation)
nmap <silent> gi <Plug>(coc-references)

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroun
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd FileType * setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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

" VSCode Neovim undo & redo
if exists('g:vscode')
  nnoremap <silent> u :<C-u>call VSCodeNotify('undo')<CR>
  nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>
endif

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
augroup END

" Auto close if last real buffer (no NvimTree)
" autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

map <Up> <nop>
map <Down> <Nop>
noremap <ScrollWheelUp> <nop>
noremap <S-ScrollWheelUp> <nop>
noremap <C-ScrollWheelUp> <nop>
noremap <ScrollWheelDown> <nop>
noremap <S-ScrollWheelDown> <nop>
noremap <C-ScrollWheelDown> <nop>
noremap <ScrollWheelLeft> <nop>
noremap <S-ScrollWheelLeft> <nop>
noremap <C-ScrollWheelLeft> <nop>
noremap <ScrollWheelRight> <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>


autocmd BufNewFile,BufRead .aliases set syntax=bash

" autocmd VimEnter * silent! cd %:p:h
autocmd VimEnter * :RestoreSession<CR>
autocmd VimLeave * :SaveSession<CR>

