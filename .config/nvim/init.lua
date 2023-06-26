vim.loader.enable()

local set = vim.opt

set.textwidth = 130
set.numberwidth = 1
set.mouse = 'a'
set.number = true
set.clipboard = 'unnamedplus'
set.shortmess = "I"
set.showcmd = true
set.ruler = true
set.backspace = 'indent,eol,start'
set.encoding = 'utf-8'
set.showmatch = true
set.laststatus = 2
set.cmdheight = 1
set.ignorecase = true
set.smartcase = true
set.showmode = false
set.wrap = false
set.cursorline = true
set.hidden = true
set.splitbelow = true
set.scrolloff = 2
set.swapfile = false
set.termguicolors = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true
set.smartindent = true
set.cindent = true
set.smarttab = true
set.updatetime = 250
set.signcolumn = 'yes:1'
set.title = true
set.ttyfast = true
set.lazyredraw = true
set.syntax = 'on'
set.foldmethod = 'expr'
set.foldexpr = 'nvim_treesitter#foldexpr()'
set.foldenable = false

set.completeopt = 'noinsert,menuone,noselect'
set.inccommand = 'split'
set.background = 'dark'

vim.o.wildignore = '*~,*.o,*.a,*/*.min.*,*/*.jpg,*/*.jpeg,*/*.gif,*/*.png,*/*.pdf,*/dist,*/docs,*/node_modules/,*/tmp,*/target/debug,*/target/CACHED*,*/.git,.DS_Store'

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

vim.g.CommandTPreferredImplementation = 'lua'
vim.g.CommandTScanDotDirectories = 1


vim.cmd([[
  filetype plugin indent on
  syntax on
  colorscheme embark
  " colorscheme kanagawa
  " colorscheme spaceduck

  highlight Normal ctermbg=NONE guibg=NONE
  autocmd BufNewFile,BufRead .aliases* set syntax=bash
  autocmd BufNewFile,BufRead *CSS.html set filetype=css
  autocmd BufNewFile,BufRead *.blade.php set syntax=blade

  autocmd TermOpen * startinsert
  " autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=50 })
  autocmd FileType html,css,svelte,jsx,tsx,vue,php,blade,php.css.html EmmetInstall
]])


-- Escape insert
map('i', 'kj', '<C-c>', opts)
-- map('v', 'kj', '<C-c>', opts)
map('c', 'kj', '<C-c>', opts)
map('t', 'kj', '<C-\\><C-n>', opts)
map('n', '<cr>', ':noh<cr>/kj', { silent = true })
map('n', '<Esc>', '<Esc>:noh<cr>/kj', { silent = true })
map('n', '<leader>y', 'ggVGy<C-o>', opts)

-- Disable arrow keys & scroll
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)
map('n', '<ScrollWheelUp>', '<C-y>', opts)
map('n', '<ScrollWheelDown>', '<C-e>', opts)

-- Move between buffers
map('n', '<C-a>', ':bprev<CR>', opts)
map('n', '<C-d>', ':bnext<CR>', opts)
map('n', 'Å', ':bprev<CR>', opts)
map('n', 'Î', ':bnext<CR>', opts)

-- Move between splits
map('n', '<leader>k', ':wincmd k<CR>', opts)
map('n', '<leader>j', ':wincmd j<CR>', opts)
map('n', '<leader>h', ':wincmd h<CR>', opts)
map('n', '<leader>l', ':wincmd l<CR>', opts)

-- Close buffer
function close_buffer()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  if buftype == 'terminal' then
    vim.cmd('bd!')
  else
    vim.cmd('bd')
  end
end
map('n', '<leader>w', ':lua close_buffer()<CR>', opts)

-- Comment toggle
map('n', '<C-/>', ':CommentToggle<CR>', opts)
map('v', '<C-/>', ':CommentToggle<CR>', opts)
map('n', '<C-_>', ':CommentToggle<CR>', opts)
map('v', '<C-_>', ':CommentToggle<CR>', opts)
map('n', '÷', ':CommentToggle<CR>', opts)
map('v', '÷', ':CommentToggle<CR>', opts)

-- Tab to go matching pair
map('', '<tab>', '%', opts)

-- Rename a symbol without no language server
map('n', '<leader>R', '#Ncgn', opts)

-- Better n and zz
map('n', 'zz', 'zz6<C-e>', opts)
map('', 'n', 'nzz', opts)
map('', 'N', 'Nzz', opts)

-- Files navigation with Harpoon
-- map <leader>p :lua require("harpoon.ui").toggle_quick_menu()<CR>
--
-- map('', '<leader>p', ':Telescope harpoon marks theme=dropdown<CR>', opts)
-- map('', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>', opts)
-- map('', '<leader>a', ':lua require("harpoon.ui").add_prev()<CR>', opts)
-- map('', '<leader>d', ':lua require("harpoon.ui").add_next()<CR>', opts)

-- Move lines
map('n', '<C-j>', ':m .+1<CR>==', opts)
map('n', '<C-k>', ':m .-2<CR>==', opts)
map('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)

map('n', '<Down>', ':m .+1<CR>==', opts)
map('n', '<Up>', ':m .-2<CR>==', opts)
map('v', '<Down>', ":m '>+1<CR>gv=gv", opts)
map('v', '<Up>', ":m '<-2<CR>gv=gv", opts)

-- File navigation
-- map('', '<C-p>', ':CommandTRipgrep<CR>', opts)
map('', '<C-p>', ':Telescope find_files<CR>', opts)
map('', 'Ò', ':CommandTBuffer<CR>', opts)
kmap('n', '<C-Semicolon>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', bufopts)
kmap('n', '<M-f>', '<cmd>Telescope live_grep<CR>', bufopts)
-- kmap('n', 'Ø', '<cmd>Telescope lsp_document_symbols<CR>', bufopts)
-- kmap('n', 'Ø', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<CR>", bufopts)
kmap('n', 'Ø', '<cmd>Telescope lsp_document_symbols<CR>', bufopts)

-- Paste/replace inside string - without yank
map('n', 'cvs', 'vi"pgvy', opts)
map('n', 'cvv', "vi'pgvy", opts)

-- Git commands
map('n', '<leader>gs', ':!git fetch && git status<CR>', opts)
map('n', '<leader>gp', ':Git pull<CR>', opts)
map('n', '<leader>gf', ':Git diff %<CR>', opts)
map('n', '<leader>gd', ':Gdiffsplit<CR>', opts)

map('n', '<leader>p', ':Gitsigns prev_hunk<CR>zz', opts)
map('n', '<leader>n', ':Gitsigns next_hunk<CR>zz', opts)
map('n', '<leader>sh', ':Gitsigns stage_hunk<CR>', opts)
map('v', '<leader>sh', ':Gitsigns stage_hunk<CR>', opts)
map('n', '<leader>su', ':Gitsigns undo_stage_hunk<CR>', opts)
map('n', '<leader>sp', ':Gitsigns preview_hunk<CR>', opts)

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'
  use 'nvim-lua/plenary.nvim'

  -- Completion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }

  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'

  -- Snippets ! TODO revisar esto, cuál estoy usando? lol
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'onsails/lspkind.nvim'

  -- Formatting
  use 'gpanders/editorconfig.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Syntax highlight
  use 'sheerun/vim-polyglot'
  use 'RRethy/vim-illuminate'

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

  use 'kana/vim-textobj-user'
  use 'Julian/vim-textobj-variable-segment'
  
  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim'

  -- File navigation
  use 'nvim-telescope/telescope.nvim'
  use { 'wincent/command-t', run = 'cd lua/wincent/commandt/lib && make' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'ggandor/leap.nvim'

  -- Status line
  use 'beauwilliams/statusline.lua'

  -- Themes
  use { 'embark-theme/vim', as = 'embark' }
  use 'rebelot/kanagawa.nvim'
  use 'pineapplegiant/spaceduck'

  use { 'echasnovski/mini.nvim', branch = 'stable' }

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
  auto_install = true,
  sync_install = true,
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

local lspkind = require('lspkind')
local luasnip = require("luasnip")
local cmp = require('cmp')

cmp.setup({
  -- completion = {
  --   completeopt = "menu,menuone,noinsert,noselect",
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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
    { name = 'luasnip', priority = 10, keyword_length = 2 },
    { name = 'nvim_lsp', priority = 9 },
    -- { name = 'null_ls', priority = 8 },
    -- { name = 'nvim_lsp_signature_help' },
    { name = 'fugitive' },
    { name = 'path', keyword_length = 2 },
  }, {
    { name = 'buffer', keyword_length = 2 },
  }),
  experimental = {
    ghost_text = false,
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            menu = { omni = "omni" },
        })(entry, vim_item)

        local strings = vim.split(kind.kind, "%s", { trimempty = true })

        local source = ({
            nvim_lsp = 'LSP',
            nvim_lua = 'Nvim Lua',
            cmp_git = 'Git',
            luasnip = 'Snippet',
            fugitive = 'Fugitive',
            buffer = 'Buffer',
        })[entry.source.name]

        kind.kind = " "..(strings[1] or "")
        kind.menu = source and " ["..(source).."]" or ""

        vim_item.dup = 0
        return kind
    end,
    -- format = function(entry, vim_item)
    --   vim_item.menu = ({
    --     nvim_lsp = '[LSP]',
    --     luasnip = '[Snippet]',
    --     nvim_lua = '[Nvim Lua]',
    --     fugitive = '[Fugitive]',
    --     buffer = '[Buffer]',
    --   })[entry.source.name]
    --   return vim_item
    -- end
  },
  performance = {
    max_view_entries = 14,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered({ winhighlight = "" }),
  },
  mapping = {
    ["<C-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({
            behavior = cmp.SelectBehavior.Select
          })
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

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline', keyword_length = 2 },
    { name = 'path' },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
    { name = 'git' },
  }, {
    { name = 'buffer' },
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
  -- kmap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  kmap('n', 'gi', '<cmd>Telescope lsp_references theme=cursor<CR>', bufopts)
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
  -- kmap('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  kmap('v', '<leader>f', ':lua vim.lsp.buf.range_formatting()<CR>', bufopts)

  kmap('n', '<leader>dk', vim.diagnostic.goto_prev, bufopts)
  kmap('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
  kmap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', bufopts)
  kmap('n', 'Ø', '<cmd>Telescope lsp_document_symbols<CR>', bufopts)
  kmap('n', '<S-B>', '<cmd>Telescope current_buffer_fuzzy_find<CR>', bufopts)
  kmap('n', '<S-F>', '<cmd>Telescope live_grep<CR>', bufopts)
end

require'lspconfig'.lua_ls.setup{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.intelephense.setup{
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
  on_attach = on_attach,
}

require('wincent.commandt').setup({
    always_show_dot_files = true,
    scanners = {
      git = {
        untracked = false,
      }
    }
})


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Smart line delete
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })

vim.api.nvim_create_augroup("lsp_document_highlight", {
  clear = true
})

vim.api.nvim_clear_autocmds {
  buffer = bufnr,
  group = "lsp_document_highlight"
}

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


local modes = {
  ["n"] = "N",
  ["no"] = "N",
  ["v"] = "V",
  ["V"] = "VL",
  [""] = "VB",
  ["s"] = "S",
  ["S"] = "SL",
  [""] = "SB",
  ["i"] = "I",
  ["ic"] = "I",
  ["R"] = "R",
  ["Rv"] = "VR",
  ["c"] = "C",
  ["cv"] = "VE",
  ["ce"] = "EX",
  ["r"] = "P",
  ["rm"] = "M",
  ["r?"] = "CO",
  ["!"] = "SH",
  ["t"] = "T",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format("%s", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal# ",
    filepath(),
    filename(),
    "%#Normal#",
    lsp(),
    "%=%#StatusLineExtra#",
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)



local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
     " ",
     added,
     changed,
     removed,
     " ",
     "%#GitSignsAdd# ",
     git_info.head,
     " %#Normal#",
  }
end

-- Move between splits
map('n', '<leader>k', ':wincmd k<CR>', opts)
map('n', '<leader>j', ':wincmd j<CR>', opts)
map('n', '<leader>h', ':wincmd h<CR>', opts)
map('n', '<leader>l', ':wincmd l<CR>', opts)

