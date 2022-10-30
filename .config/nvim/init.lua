require('impatient')

local set = vim.opt

set.shiftwidth = 2
set.numberwidth = 1
set.mouse = 'a'
set.number = true
set.clipboard = 'unnamedplus'
set.shortmess = "I"
set.showcmd = true
set.ruler = true
set.encoding = 'utf-8'
set.showmatch = true
set.laststatus = 2
set.cmdheight = 2
set.ignorecase = true
set.smartcase = true
set.showmode = false
set.wrap = false
set.cursorline = true
set.hidden = true
set.splitbelow = true
set.scrolloff = 4
set.swapfile = false
set.tabstop = 4
set.termguicolors = true
set.expandtab = true
set.autoindent = true
set.cindent = true
set.smarttab = true
set.updatetime = 250
set.signcolumn = 'yes:1'
set.title = true
-- set.syntaxenable = true

set.completeopt = 'noinsert,menuone,noselect'
set.inccommand = 'split'
set.background = 'dark'

vim.o.wildignore = '*~,*.o,*.a,*/*.min.*,*/*.jpg,*/*.png,*/dist,*/docs,*/node_modules/,*/tmp,*/target/debug,*/target/CACHED*,*/.git,.DS_Store'


local map = vim.api.nvim_set_keymap
local kmap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.emmet_html5 = 1
vim.g.html_indent_script1 = 'inc'
vim.g.html_indent_style1 = 'inc'
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_leader_key = ','
vim.g.user_emmet_splitjointag_key = ',s'
vim.g.user_emmet_removetag_key = ',r'

vim.g.user_emmet_settings = {
  indent_blockement = 1,
  php = {
    extends = 'html',
    filters = 'html,c',
  },
  css = {
    filters = 'hc',
  },
  javascript = {
    snippets = {
      fn = 'function ${cursor}() {\n\t\n}',
    },
  },
}

-- Autoclose tags
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx,*.php'
vim.g.closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx,*.php'
vim.g.closetag_filetypes = 'html,xhtml,jsx,js,tsx,php'
vim.g.closetag_xhtml_filetypes = 'html,xhtml,jsx,js,tsx,php'

vim.cmd([[
  filetype plugin indent on
  syntax on
  " colorscheme embark
  colorscheme kanagawa
  " colorscheme catppuccin

  autocmd BufNewFile,BufRead .aliases* set syntax=bash
  autocmd BufNewFile,BufRead *CSS.html set filetype=css
  autocmd BufNewFile,BufRead *.blade.php set syntax=blade

  autocmd TermOpen * startinsert
  " autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=50})
  autocmd FileType html,css,svelte,jsx,tsx,vue,php,blade,php.css.html EmmetInstall
]])


-- Escape insert
map('i', 'kj', '<C-c>', opts)
-- map('v', 'kj', '<C-c>', opts)
map('c', 'kj', '<C-c>', opts)
map('t', 'kj', '<C-\\><C-n>', opts)
map('n', '<cr>', ':noh<cr>', { silent = true })

-- Disable arrow keys & scroll
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)
map('n', '<ScrollWheelUp>', '<Nop>', opts)
map('n', '<ScrollWheelDown>', '<Nop>', opts)

-- Move between buffers
map('n', '<C-a>', ':bprev<CR>', opts)
map('n', '<C-d>', ':bnext<CR>', opts)

-- Move between splits
map('n', '<leader>k', ':wincmd k<CR>', opts)
map('n', '<leader>j', ':wincmd j<CR>', opts)
map('n', '<leader>h', ':wincmd h<CR>', opts)
map('n', '<leader>l', ':wincmd l<CR>', opts)

-- Close buffer
-- map('n', '<leader>w', ':call CloseBuffer()<CR>', opts)

-- Comment toggle
map('n', '<C-X>', ':CommentToggle<CR>', opts)
map('v', '<C-X>', ':CommentToggle<CR>', opts)
map('n', '<C-_>', ':CommentToggle<CR>', opts)
map('v', '<C-_>', ':CommentToggle<CR>', opts)

-- Tab to go matching pair
map('', '<tab>', '%', opts)

-- Rename a symbol without no language server
map('n', '<leader>R', '#Ncgn', opts)

-- Mejor n
map('', '<n>', 'nzz', opts)
map('', '<N>', 'Nzz', opts)

-- Files navigation with Harpoon
-- map <leader>p :lua require("harpoon.ui").toggle_quick_menu()<CR>
map('', '<leader>p', ':Telescope harpoon marks theme=dropdown<CR>', opts)
map('', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>', opts)
map('', '<leader>a', ':lua require("harpoon.ui").add_prev()<CR>', opts)
map('', '<leader>d', ':lua require("harpoon.ui").add_next()<CR>', opts)

-- Move lines
map('n', '<C-j>', ':m .+1<CR>==', opts)
map('n', '<C-k>', ':m .-2<CR>==', opts)
map('i', '<C-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<C-k>', '<Esc>:m .-2<CR>==gi', opts)
map('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)

-- File navigation
map('', '<C-p>', ':CommandTRipgrep<CR>', opts)
map('', '<C-l>', ':CommandTBuffer<CR>', opts)


-- Paste/replace inside string - without yank
map('n', 'cvs', 'vi"pgvy', opts)
map('n', 'cvv', "vi'pgvy", opts)


-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'
  use 'lewis6991/impatient.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Snippets ! TODO revisar esto, cuál estoy usando? lol
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Formatting
  use 'gpanders/editorconfig.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Language server
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Code tools & refactoring
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 'kylechui/nvim-surround', tag = '*' }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'AndrewRadev/splitjoin.vim'
  use 'terrortylor/nvim-comment'
  use 'windwp/nvim-autopairs'
  use 'alvan/vim-closetag'
  use 'mattn/emmet-vim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- File navigation
  use 'nvim-telescope/telescope.nvim'
  use { 'wincent/command-t', run = 'cd lua/wincent/commandt/lib && make' }
  use 'ggandor/leap.nvim'

  -- Status line
  use 'beauwilliams/statusline.lua'

  -- Themes
  use { 'embark-theme/vim', as = 'embark' }
  use 'rebelot/kanagawa.nvim'

  -- use {
  --     "catppuccin/nvim",
  --     as = "catppuccin",
  --     config = function()
  --         vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
  --         require("catppuccin").setup()
  --         vim.api.nvim_command "colorscheme catppuccin"
  --     end
  -- }

  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
end)


require('nvim-surround').setup()
require('leap').set_default_keymaps()

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" }
})

-- require('stautslines').setup()

require('gitsigns').setup({
  signs = {
    delete    = {hl = 'DiffDelete', text = '_', show_count=true},
    topdelete = {hl = 'DiffDelete', text = '‾', show_count=true},
  },
  count_chars = {
    [1] = '1',
    [2] = '2',
    [3] = '3',
    [4] = '4',
    [5] = '5',
    [6] = '6',
    [7] = '7',
    [8] = '8',
    [9] = '9',
    ['+'] = '+',
  }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { "vim", "javascript", "typescript", "php", "html", "json" },
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
  context_commentstring = {
    enable = true
  },
})

require('nvim_comment').setup({
  comment_empty = false,
  comment_empty_trim_whitespace = false,
  hook = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'css',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'php',
    'python',
    'regex',
    'rust',
    'scss',
    'sql',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = false },
  autotag = {
    enable = true,
    filetypes = {
      'html',
      'javascript',
      'javascriptreact',
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
      'xml',
    },
  },
})

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'fugitive' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'vsnip' },
    { name = 'buffer', keyword_length = 4 },
  }),
  -- experimental = {
  --   views = {
  --     entries = '',
  --   },
  -- },
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  }),
})

-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = { { name = 'buffer' } },
-- })

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSP Config Mappings
kmap('n', '<leader>e', vim.diagnostic.open_float, opts)
kmap('n', '[d', vim.diagnostic.goto_prev, opts)
kmap('n', ']d', vim.diagnostic.goto_next, opts)
kmap('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  kmap('n', 'gr', vim.lsp.buf.references, bufopts)
  kmap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  kmap('n', 'gd', vim.lsp.buf.definition, bufopts)
  kmap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  kmap('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  kmap('n', 'gh', vim.lsp.buf.hover, bufopts)
  kmap('n', 'K', vim.lsp.buf.hover, bufopts)
  kmap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  kmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  kmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  kmap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  kmap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  kmap('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  kmap('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  kmap('v', '<leader>f', ':lua vim.lsp.buf.range_formatting()<CR>', bufopts)

  kmap('n', '<leader>dk', vim.diagnostic.goto_prev, bufopts)
  kmap('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
  kmap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', bufopts)
  kmap('n', '<C-o>', '<cmd>Telescope lsp_document_symbols<CR>', bufopts)
  kmap('n', '\\', '<cmd>Telescope current_buffer_fuzzy_find<CR>', bufopts)
end

require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  filetype = { 'html', 'php', 'blade', 'svelte' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
  on_attach = on_attach,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
          vim.api.nvim_input('<space>')
        end
        cmp.confirm()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
})




vim.g.CommandTPreferredImplementation = 'lua'
vim.g.CommandTAlwaysShowDotFiles = 1
vim.g.CommandTScanDotDirectories = 1

require('wincent.commandt').setup({
  -- position = 'bottom',
  scanners = {
    git = {
      untracked = false,
    }
  }
})


-- Smart line delete
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })


vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
vim.api.nvim_create_autocmd("CursorHold", {
  callback = vim.lsp.buf.document_highlight,
  buffer = bufnr,
  group = "lsp_document_highlight",
  desc = "Document Highlight",
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = vim.lsp.buf.clear_references,
  buffer = bufnr,
  group = "lsp_document_highlight",
  desc = "Clear All the References",
})


