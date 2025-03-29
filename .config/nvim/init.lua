vim.loader.enable()

local api, fn, opt, g = vim.api, vim.fn, vim.opt, vim.g
local set = opt

local opts = { noremap = true, silent = true }
local map = api.nvim_set_keymap
local kmap = vim.keymap.set

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
set.splitright = true
set.scrolloff = 1
set.sidescrolloff = 20
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
set.redrawtime = 1500
set.synmaxcol = 240
set.syntax = 'on'
set.foldmethod = 'expr'
set.foldexpr = 'nvim_treesitter#foldexpr()'
set.foldenable = true
set.foldlevel = 99
set.iskeyword:remove({'$'})

set.completeopt = 'noinsert,menuone,noselect'
set.inccommand = 'split'
set.background = 'dark'

-- vim.o.wildignore = '*~,*.o,*.a,*/*.min.*,*/*.jpg,*/*.jpeg,*/*.gif,*/*.png,*/*.pdf,*/dist,*/docs,*/node_modules/,*/tmp,*/target/debug,*/target/CACHED*,*/.git,.DS_Store'
vim.o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,**/.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
*/vendor/**/debug/**
*/vendor/**.git**
*/vendor/**.(md|json|yml).*
]]

g.mapleader = ' '
g.maplocalleader = ','
g.emmet_html5 = 1
g.html_indent_script1 = 'inc'
g.html_indent_style1 = 'inc'
g.user_emmet_install_global = 0
g.user_emmet_leader_key = ','
g.user_emmet_splitjointag_key = ',s'
g.user_emmet_removetag_key = ',x'

g.user_emmet_settings = {
  indent_blockement = 1,
  php = {
    extends = 'html,css',
    filters = 'html,c',
  },
  blade = {
    extends = 'php',
  },
  css = {
    filters = 'hc',
  },
  html = {
    extends = 'css',
  },
  javascript = {
    snippets = {
      fn = 'function ${cursor}() {\n\t\n}',
    },
  },
}

-- Autoclose tags
g.closetag_emptyTags_caseSensitive = 1
g.closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx,*.vue,*.php'
g.closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx,*.vue,*.php'
g.closetag_filetypes = 'html,xhtml,jsx,js,tsx,vue,php'
g.closetag_xhtml_filetypes = 'html,xhtml,jsx,js,tsx,vue,php'

vim.cmd([[
  autocmd TermEnter term://*toggleterm#* tnoremap <silent>≤ <Cmd>exe v:count1 . "ToggleTerm"<CR>

  " By applying the mappings this way you can pass a count to your mapping to open a specific window.
  " For example: 2<C-t> will open terminal 2
  nnoremap <silent>≤ <Cmd>exe v:count1 . "ToggleTerm"<CR>

  command! Neo Neogit
  command! Notes Neorg index
]])

map('n', '<C-i>', '<Cmd-i>', { noremap = true })
map('n', '<C-i>', '<C-i>', { noremap = true })
map('n', '<C-s>', '<C-a>', opts)
map('n', '<Tab>', '%', opts)
map('v', '<Tab>', '%', opts)

-- Escape insert
-- map('i', 'kj', '<C-c>', opts)
-- map('v', 'kj', '<C-c>', opts)
map('c', 'kj', '<C-c>', opts)
map('t', 'kj', '<C-\\><C-n>', opts)
map('n', '<cr>', ':noh<cr>/kj', { silent = true })
map('n', 'gd', '<Plug>(neorg.esupports.hop.hop-link)', { silent = true })
map('n', '<Esc>', '<Esc>:noh<cr>/kj', { silent = true })
map('i', '<Esc>', '<C-c>:noh<cr>/kj', { silent = true })
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

-- Close buffer
function close_buffer()
  local buftype = api.nvim_buf_get_option(0, 'buftype')
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
map('n', '<Tab>', '%', opts)
map('v', '<Tab>', '%', opts)
map('o', '<Tab>', '%', opts)

-- Rename a symbol without language server
map('n', '<leader>R', '#Ncgn', opts)

-- Better indenting
map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)

-- Better n and zz
map('n', 'zz', 'zz6<C-e>', opts)
map('', 'n', 'nzz6<C-e>', opts)
map('', 'N', 'Nzz6<C-e>', opts)

map('i', '<C-n>', '', opts)
map('n', '<C-a>', '<C-a>', opts)
map('n', '<C-x>', '<C-x>', opts)

-- Files navigation with Harpoon
-- map <leader>p :lua require("harpoon.ui").toggle_quick_menu()<CR>, opts)

map('n', '<leader>e', ':Telescope harpoon marks theme=dropdown<CR>', opts)
map('n', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>', opts)
map('n', '<leader>u', ':lua require("harpoon.mark").remove_file()<CR>', opts)
map('n', '<leader>[', ':lua require("harpoon.ui").nav_prev()<CR>', opts)
map('n', '<leader>]', ':lua require("harpoon.ui").nav_next()<CR>', opts)

-- Move lines
-- map('n', '<C-j>', ':m .+1<CR>==', opts)
-- map('n', '<C-k>', ':m .-2<CR>==', opts)
-- map('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
-- map('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)

map('n', '<Down>', ':m .+1<CR>==', opts)
map('n', '<Up>', ':m .-2<CR>==', opts)
map('v', '<Down>', ":m '>+1<CR>gv=gv", opts)
map('v', '<Up>', ":m '<-2<CR>gv=gv", opts)

-- File navigation
map('n', '<C-p>', ':lua require("fzf-lua").files()<CR>', opts)
map('n', '∏', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', opts) -- cmd-shift-p
map('n', '<C-i>', ':Telescope find_files<CR>', opts)
map('', '<M-e>', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', opts)
map('n', '¬', ':lua require("fzf-lua").buffers()<CR>', opts) -- cmd-l
kmap('n', 'Ï', ':lua require("fzf-lua").live_grep()<CR>', opts) -- cmd-f
-- kmap('n', '<leader>b', '<cmd>Telescope current_buffer_fuzzy_find results_ts_highlight=false skip_empty_lines=true<CR>', opts)
-- kmap('n', '<leader>b', ':lua require("fzf-lua").lgrep_curbuf()<CR>', opts)
-- kmap('n', '<leader>b', ':lua require("fzf-lua").blines({ start = "cursor" })<CR>', opts)
kmap('n', '<leader><space>', ':lua require("fzf-lua").blines({ start = "cursor" })<CR>', opts)
kmap('n', 'ø', ':lua require("fzf-lua").lsp_document_symbols()<CR>', opts) -- cmd+o

-- Paste/replace inside string - without yank
map('n', 'cvs', 'vi"pgvy', opts)
map('n', 'cvv', "vi'pgvy", opts)

kmap('n', '<leader>ih', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.cmd('echo "Inlay hints: ' .. tostring(vim.lsp.inlay_hint.is_enabled()) .. '"')
end)

-- Git commands
kmap('n', '<leader>gc', ':lua require("fzf-lua").git_commits()<CR>', opts)
kmap('n', '<leader>gb', ':lua require("fzf-lua").git_branches()<CR>', opts)
kmap('n', '<leader>gs', ':lua require("fzf-lua").git_status()<CR>', opts)
-- map('n', '<leader>gs', ':!git fetch && git status -sb<CR>', opts)
map('n', '<leader>gp', ':Git pull<CR>', opts)
map('n', '<leader>gf', ':Git diff %<CR>', opts)
map('n', '<leader>gd', ':Gdiffsplit<CR>', opts)

map('n', '<leader>p', ':Gitsigns prev_hunk<CR>zz', opts)
map('n', '<leader>n', ':Gitsigns next_hunk<CR>zz', opts)
map('n', '<leader>sh', ':Gitsigns stage_hunk<CR>', opts)
map('v', '<leader>sh', ':Gitsigns stage_hunk<CR>', opts)
map('n', '<leader>su', ':Gitsigns undo_stage_hunk<CR>', opts)
map('n', '<leader>sp', ':Gitsigns preview_hunk<CR>', opts)
map('n', '<leader>.', ':Gitsigns blame_line<CR>', opts)
map('v', '<leader>.', ':Gitsigns blame_line<CR>', opts)

kmap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", opts)
kmap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
kmap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)

kmap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", opts)
kmap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)
kmap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
kmap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts)
kmap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
kmap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts)

kmap("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", opts)
kmap("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", opts)
kmap("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", opts)
kmap("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", opts)
kmap("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", opts)
kmap("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", opts)

kmap({'o', 'x'}, 'is', "<cmd>lua require('various-textobjs').subword(true)<CR>")
kmap({'o', 'x'}, 'as', "<cmd>lua require('various-textobjs').subword(false)<CR>")

api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd("silent! noh")
  end,
})

--[[
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  callback = function()
    -- GRADIENT STATUS COL
     local separator = " │  "
     vim.b.statuscolumn =
         '%s%=%#LineNr4#%{(v:relnum >= 4)?v:relnum.\"' .. separator .. '\":\"\"}' ..
         '%#LineNr3#%{(v:relnum == 3)?v:relnum.\"' .. separator .. '\":\"\"}' ..
         '%#LineNr2#%{(v:relnum == 2)?v:relnum.\"' .. separator .. '\":\"\"}' ..
         '%#LineNr1#%{(v:relnum == 1)?v:relnum.\"' .. separator .. '\":\"\"}' ..
         '%#LineNr0#%{(v:relnum == 0)?v:lnum.\"' .. separator .. '\":\"\"}'
  end,
})
]]--

--[[
vim.cmd [[
  highlight LineNr0 guifg=#ff0000
  highlight LineNr1 guifg=#ff5500
  highlight LineNr2 guifg=#ffaa00
  highlight LineNr3 guifg=#ffff00
  highlight LineNr4 guifg=#00ff00
]]
--[[
vim.o.statuscolumn = "%=%s%=%#LineNr#%{v:lnum} "
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "CursorMoved", "CursorMovedI" }, {
  pattern = { "*" },
  callback = function()
    -- GRADIENT STATUS COL
    local separator = " │  "
    vim.b.statuscolumn =
        '%s%=%#LineNr4#%{(math.abs(v:lnum - v:lnum) >= 4)?v:lnum.\"' .. separator .. '\":\"\"}' ..
        '%#LineNr3#%{(math.abs(v:lnum - v:lnum) == 3)?v:lnum.\"' .. separator .. '\":\"\"}' ..
        '%#LineNr2#%{(math.abs(v:lnum - v:lnum) == 2)?v:lnum.\"' .. separator .. '\":\"\"}' ..
        '%#LineNr1#%{(math.abs(v:lnum - v:lnum) == 1)?v:lnum.\"' .. separator .. '\":\"\"}' ..
        '%#LineNr0#%{(math.abs(v:lnum - v:lnum) == 0)?v:lnum.\"' .. separator .. '\":\"\"}'
  end,
})
]]--

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end
opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
--   -- 'dstein64/vim-startuptime',
--   -- 'ThePrimeagen/harpoon',

  {
    'nvim-lua/plenary.nvim',
    lazy = false,
    priority = 1000,
  },

  -- Completion
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    opts = {
      keymap = { preset = 'enter' },

      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰀫',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },

      completion = {
        documentation = { auto_show = false },
        menu = {
          border = "rounded",
          draw = {
            align_to = 'label',
            columns = {
              {"label", "label_description", gap = 1},
              {"kind_icon", "source_name", gap = 1},
            },
            components = {
              label = {
                width = { max = 30 },
              },
              source_name = {
                width = { min = 3, max = 3 },
                text = function(ctx) return ctx.source_name end,
                ellipsis = false,
              },
            },
          }
        }
      },

      cmdline = {
        enabled = true,
        keymap = { preset = 'cmdline' },
        sources = function()
          -- TODO: acá hacer que filter por el largo del input
          local type = vim.fn.getcmdtype()
          if type == '/' or type == '?' then return { 'buffer' } end
          if type == ':' or type == '@' then return { 'cmdline' } end
          return {}
        end,
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = {},
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
            draw = {
              columns = {
                {"label"},
                {"kind_icon"},
              },
            },
          },
          ghost_text = { enabled = true }
        }
      },

      sources = {
        min_keyword_length = 2,
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          'exact',
          'score',
          'sort_text',
        },
      },
      signature = { enabled = true, },
    },

    opts_extend = { "sources.default" }
  },

  {
    {
      'supermaven-inc/supermaven-nvim',
      config = function()
        require('supermaven-nvim').setup({
          log_level = 'off',
		  disable_filetypes = { 'log', 'txt' },
        })
      end,
    },
  },

  { 'lvimuser/lsp-inlayhints.nvim', branch = 'anticonceal' },

  -- Syntax highlight
  'sheerun/vim-polyglot',
  'RRethy/vim-illuminate',

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },

  -- Language server
  'nvimtools/none-ls.nvim',
  'williamboman/nvim-lsp-installer',
  'joechrisellis/lsp-format-modifications.nvim',
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { 'williamboman/mason.nvim', build = ':MasonUpdate' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
  },

  -- Code tools & refactoring
  'nvim-treesitter/nvim-treesitter',
  -- 'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'chrisgrieser/nvim-various-textobjs',
    opts = { keymaps = { useDefaults = true } },
  },
  {
    'Julian/vim-textobj-variable-segment',
    dependencies = { 'kana/vim-textobj-user' },
  },

  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig'
  },

  -- {
  --   'adalessa/laravel.nvim',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --     'tpope/vim-dotenv',
  --     'MunifTanjim/nui.nvim',
  --     -- 'nvimtools/none-ls.nvim',
  --   },
  --   cmd = { 'Artisan', 'Composer', 'Laravel' },
  --   keys = {
  --     { '<leader>la', ':Laravel artisan<cr>' },
  --     { '<leader>lr', ':Laravel routes<cr>' },
  --     { '<leader>lm', ':Laravel related<cr>' },
  --   },
  --   event = { 'VeryLazy' },
  --   ft = {'blade', 'php'},
  --   config = true,
  -- },

  {
    'rcarriga/nvim-notify',
    event = "VeryLazy",
    config = function()
      local notify = require('notify')
      notify.setup({
        background_colour = '#000000',
        render = 'wrapped-compact',
        timeout = 3000,
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        max_width = function() return math.floor(vim.o.columns * 0.75) end,
      })
      vim.notify = notify.notify
    end
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = "*",
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {
      -- configurations go here
    },
  },

  'windwp/nvim-ts-autotag',
  {
    'wuelnerdotexe/vim-astro',
    ft = {'astro'},
  },

  -- use {
  --   'Wansmer/treesj',
  --   requires = { 'nvim-treesitter' },
  --   config = function()
  --     require('treesj').setup()
  --   end,
  -- }

  -- {
  --   'abecodes/tabout.nvim',
  --   lazy = false,
  --   config = function()
  --     require('tabout').setup {
  --       tabkey = '<Tab>', -- an empty string to disable
  --       backwards_tabkey = '<S-Tab>',
  --       act_as_tab = true,
  --       act_as_shift_tab = false,
  --       default_tab = '<C-t>',
  --       default_shift_tab = '<C-d>',
  --       enable_backwards = true, -- well ...
  --       completion = true,
  --       tabouts = {
  --         {open = "'", close = "'"},
  --         {open = '"', close = '"'},
  --         {open = '`', close = '`'},
  --         {open = '(', close = ')'},
  --         {open = '[', close = ']'},
  --         {open = '{', close = '}'}
  --       },
  --       ignore_beginning = true,
  --       exclude = {}
  --     }
  --   end,
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'L3MON4D3/LuaSnip',
  --     'hrsh7th/nvim-cmp',
  --   },
  -- },

  {
    'kylechui/nvim-surround',
    version = '*',
    config = function ()
      require('nvim-surround').setup()
    end
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    lazy = false,
  },

  'AndrewRadev/splitjoin.vim',
  'terrortylor/nvim-comment',
  'windwp/nvim-autopairs',
  'alvan/vim-closetag',

  {
    'mattn/emmet-vim',
    ft = {'html', 'css', 'javascript', 'php', 'blade', 'vue'},
  },

  -- Git
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',
  'sindrets/diffview.nvim',

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      -- "ibhagwan/fzf-lua",
    },
    config = true,
    opts = {
      disable_hint = true,
      integrations = {
        diffview = true,
      },
    }
  },

  -- File navigation
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = ' arch -arm64 make',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
  },

  {
    'ibhagwan/fzf-lua',
    config = function()
      local fzf_lua = require('fzf-lua')
      fzf_lua.setup({
        defaults = {
          git_icons = false,
          file_icons = false,
          color_icons = false,
        },
        winopts = {
          height = 0.3,
          width = 0.7,
          border = 'single',
          preview = {
            hidden = 'hidden',
          },
        },
        rg_opts = {
          ['--files'] = true,
          ['--hidden'] = true,
          ['--color'] = 'never',
          ['--sort'] = 'modified',
          ['--with-filename'] = true,
        },
        -- buffers = {
        --   sort_lastused = true,
        --   ignore_current_buffer = true,
        --   find_command = { 'rg', '--files', '--sortr=modified '},
        -- },
        keymap = {
          builtin = {
            -- Normal mode mappings
            ['n'] = {
              ['kj'] = function() fzf_lua.actions.close() end,
            },
            -- Insert mode mappings
            ['i'] = {
              ['¬'] = 'down',
              ['<C-p>'] = 'toggle-preview',
              ['<C-n>'] = 'toggle-preview',
              ['<M-e>'] = { '<cmd>FzfLua file_browser<CR>', mode = 'i' },
              ['kj'] = function() fzf_lua.actions.close() end,
            },
          },
        },
      })
    end
  },

  -- {
  --   'roobert/search-replace.nvim',
  --   config = function()
  --     require('search-replace').setup({
  --       -- optionally override defaults
  --       default_replace_single_buffer_options = 'gcI',
  --       default_replace_multi_buffer_options = 'egcI',
  --     })
  --   end,
  -- },

  {
    'ricardoramirezr/blade-nav.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp', -- if using nvim-cmp
    },
    ft = {'blade', 'php'}
  },

  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
      })
    end
  },

  -- use 'unblevable/quick-scope'

  -- Themes

  -- {
  --   'embark-theme/vim',
  --   name = 'embark',
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme embark") end
  -- },

  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme catppuccin") end
  -- },

  -- {
  --   'felipeagc/fleet-theme-nvim',
  --   name = 'fleet',
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme fleet") end
  -- },

  -- { -- me gustó
  --   'comfysage/aurora',
  --   name = 'aurora',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme aurora") end
  -- },

  -- -- estaba usando este en casa:
  -- { -- me gustó // colores oscuros, aveces dificulta la lectura
  --   'comfysage/aki',
  --   name = 'aki',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme aki") end
  -- },

  -- { -- me gustó // me gusta pero mucho azulado, medio rareli
  --   'oahlen/iceberg.nvim',
  --   name = 'iceberg',
  --   lazy = false,
  --   priority = 1000,
  --   config = buf_options,
  -- },

  -- { -- me gustó
  --   'humbertocarmona/kanagawa-mod.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme kanagawa") end
  -- },

  -- { -- ta bueno pero faltaría ajustar algunos colores y más compatibilidad con lenguajes
  --   'rafi/awesome-vim-colorschemes',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme sunbather") end
  -- },

  -- { -- me gustó mucho!!!! // le falta algunos colores? y problemas al ver diff de git?
  --   'mellow-theme/mellow.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme mellow") end
  -- },

  -- { -- me gustó maso
  --   'domeee/mosel.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   setup = function() vim.cmd("colorscheme mosel") end,
  -- },

  -- {
  --   "felipeagc/fleet-theme-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme fleet") end
  -- },

  -- -- este estaba usando en casa
  -- {
  --   'aktersnurra/no-clown-fiesta.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function() vim.cmd("colorscheme no-clown-fiesta") end
  -- },

  -- {
  --   'sainnhe/gruvbox-material',
  --   priority = 1000,
  --   config = buf_options,
  --   setup = function() vim.cmd("colorscheme gruvbox-material") end,
  -- },

  -- {
  --   'rose-pine/neovim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('rose-pine').setup({
  --       variant = 'moon',
  --       highlight_groups = {
  --         LineNr4 = { fg = '#3B4261' },
  --         LineNr3 = { fg = '#445464' },
  --         LineNr2 = { fg = '#5D8E97' },
  --         LineNr1 = { fg = '#7DAEB9' },
  --         LineNr0 = { fg = '#BDEEF9', bold = true },
  --         FloatBorder = { bg = '#232136' },
  --         Visual = { bg = '#4C4067', fg = '#dedede' },
  --         PmenuKind = { fg = '#c4a7e7' },
  --       }
  --     })
  --     vim.cmd("colorscheme rose-pine")
  --   end,
  -- },

  {
    'anAcc22/sakura.nvim',
    -- 'numToStr/Sakura.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/packages/neovim')
      vim.cmd([[colorscheme sakura]])
    end
  },

  -- use { 'folke/todo-comments.nvim', event = "BufReadPost" }

  -- use {
  --   "zbirenbaum/neodim",
  --   event = "LspAttach",
  --   branch = "v2",
  --   config = function ()
  --     require("neodim").setup({
  --       refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
  --       alpha = .75,
  --       blend_color = "#000000",
  --       hide = { underline = true, virtual_text = true, signs = true },
  --       priority = 100, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
  --       disable = {}, -- table of filetypes to disable neodim
  --     })
  --   end,
  -- }

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup()
    end
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = { enabled = false },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  'karb94/neoscroll.nvim',
  'beauwilliams/statusline.lua',

  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        user_default_options = {
          css = true,
        }
      })
    end
  },

  {
    'max397574/better-escape.nvim',
    opts = {
      mappings = {
        i = { k = { j = "<Esc>" }, },
        c = { k = { j = "<Esc>" }, },
        t = { k = { j = "<Esc>" }, },
        v = { j = { k = "k" }, },
        s = { k = { j = "<Esc>" }, },
      },
    }
  },

  { 'echasnovski/mini.nvim', branch = 'stable' },
  { 'utilyre/sentiment.nvim', version = '*' },
  -- {
  --   'vidocqh/auto-indent.nvim',
  --   opts = {
  --     indentexpr = function(lnum)
  --       return require("nvim-treesitter.indent").get_indent(lnum)
  --     end,
  --   },
  -- },
  {
    'glacambre/firenvim',
    lazy = not g.started_by_firenvim,
    build = function()
      fn['firenvim#install'](0)
    end
  },
  {
    'yutkat/confirm-quit.nvim',
    event = 'CmdlineEnter',
    opts = {
      quit_message = ' => Confirm',
    },
  },
  {
    'j-hui/fidget.nvim',
    -- version = 'legacy',
    -- event = 'LspAttach',
    config = function()
      require('fidget').setup({
        notification = {
          window = {
            winblend = 0,
          },
        },
        -- progress = {
        --   ignore_empty_message = false,
        -- },
      })
    end,
  },
  {
    'LunarVim/bigfile.nvim',
    ft = {'log', 'txt'}
  },

  'mollerhoj/telescope-recent-files.nvim',

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({})
    end,
    ft = {'markdown', 'md'}
  },

  {
    'ruifm/gitlinker.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitlinker').setup()
    end,
  },

  {
    'nvim-neorg/neorg',
    dependencies = { 'benlubas/neorg-interim-ls' },
    version = '*',
    config = function()
      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
		  -- ['core.export.markdown'] = {},
		  ['core.integrations.treesitter'] = {},
		  ['core.completion'] = {
            config = {
              engine = { module_name = "external.lsp-completion" }
            },
		  },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes',
              },
			  index = 'index.norg',
              default_workspace = 'notes',
            },
          },
          ["external.interim-ls"] = {
            config = {
              completion_provider = {
                enable = true,
                documentation = true,
              }
            },
          },
        },
      })
    end,
  },
})

vim.cmd([[
  filetype plugin indent on
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_dim_inactive_windows = '1'

  let g:VM_maps = {}
  let g:VM_maps["Exit"] = '<C-c>'
  let g:VM_maps['Find Under'] = '<C-d>'

  " highlights
  hi TreesitterContext guibg=#07090d guifg=#504944
  hi TreesitterContextBottom gui=underline guifg=#504944
  hi MiniIndentscopeSymbol guifg=#444444 "#24262A
  hi Normal ctermbg=NONE guibg=NONE
  " hi NormalFloat guibg=#1c2e42
  hi EndOfBuffer guibg=NONE ctermbg=NONE

  hi StatusLine guifg=#666666 guibg=NONE
  hi StatusLineAccent guifg=#504945 guibg=NONE
  hi StatuslineInsertAccent guifg=#666666 guibg=NONE

  hi BlinkCmpMenu guibg=#1A1724  guifg=#5A525A
  hi BlinkCmpMenuBorder guibg=#1A1724 guifg=#635053
  hi BlinkCmpMenuSelection guibg=#362e35
  hi BlinkCmpLabel guibg=#1A1724 guifg=#d5c2c5
  hi BlinkCmpLabelDetail guibg=#1A1724 guifg=#d5c2c5
  hi BlinkCmpLabelDescription guibg=#1A1724 guifg=#d5c2c5
  hi BlinkCmpKind guibg=#1a1724 guifg=#746E6F
  hi BlinkCmpSource guibg=#1a1724 guifg=#746E6F
  hi BlinkCmpScrollBarThumb guibg=#2D2B32

  autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
  autocmd BufNewFile,BufRead .aliases* set syn=bash
  autocmd BufNewFile,BufRead *CSS.html set ft=css
  autocmd BufNewFile,BufRead */src/**{components,pages}/*.js set ft=jsx
  autocmd BufNewFile,BufRead *.blade.php set ft=php
  " autocmd BufNewFile,BufRead *.blade.php set ft=blade
  autocmd BufNewFile,BufRead *.norg set ft=norg
  " autocmd BufNewFile,BufRead *.php set syn=php
  " autocmd BufNewFile,BufRead *.blade.php set syn=html

  autocmd TermOpen * startinsert
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=50 })
  autocmd FileType html,css,svelte,jsx,tsx,vue,php,blade,php.css.html EmmetInstall
]])

require('ufo').setup()
require('mason').setup()

local neoscroll = require('neoscroll')
local ns_keymap = {
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
  ["zt"]    = function() neoscroll.zt({ half_win_duration = 120 }) end;
  ["zz"]    = function() neoscroll.zz({ half_win_duration = 120 }) end;
  ["zb"]    = function() neoscroll.zb({ half_win_duration = 120 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(ns_keymap) do
  vim.keymap.set(modes, key, func)
end

require('mason-lspconfig').setup({
    automatic_installation = true,
})

require('telescope').setup({
  defaults = {
    -- layout_strategy = 'horizontal',
    preview = false,
    flip_lines = true,
    sorting_strategy = 'ascending',
    grep_hidden = true,
    results_title = '',
    previewer = false,
    layout_config = {
      prompt_position = 'top',
      height = 18,
      width = 100,
      preview_width = 50,
    },
    path_display = {
      truncate = 3,
    },
    mappings = {
      n = {
        ['k'] = false,
        ['j'] = false,
        ['kj'] = 'close',
        ['<C-p>'] = 'cycle_history_prev',
        ['<C-n>'] = 'cycle_history_next',
        ['<M-e>'] = { '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', type = 'command' },
      },
      i = {
        ['¬'] = 'move_selection_next',
        ['<C-p>'] = 'cycle_history_prev',
        ['<C-n>'] = 'cycle_history_next',
        ['<M-e>'] = { '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', type = 'command' },
      },
    },
    file_ignore_patterns = {
      "^node_modules/","^.git/",".git.*",'^vendor/.*%.[^p].*$','%.7z','%.JPEG','%.JPG','%.MOV','%.RAF','%.burp','%.bz2',
      '%.cache','%.class','%.dll','%.docx','%.dylib','%.epub','%.exe','%.flac','%.ico','%.ipynb','%.jar',
      '%.jpeg','%.jpg','%.lock','%.mkv','%.mov','%.mp4','%.otf','%.pdb','%.pdf','%.png','%.rar','%.sqlite3',
      '%.tar','%.tar.gz','%.ttf','%.webp','%.zip','.gradle/','.idea/','.settings/','.vale/','.vscode/',
      '__pycache__/*','build/','gradle/','node_modules/','smalljre_*/*','target/',
    },
    sorter = require('telescope.sorters').get_fzy_sorter(),
    file_sorter = function(path)
      return #fn.split(path, '/') .. path
    end,
    generic_sorter = function(a, b)
      return a.previewer[1] < b.previewer[1]
    end,
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--sortr=modified '},
    },
    buffers = {
      sort_mru = true,
      ignore_current_buffer = true,
      find_command = { 'rg', '--files', '--sortr=modified '}, -- ???????
    },
    current_buffer_fuzzy_find = {
      preview = { treesitter = false, },
      layout_config = { width = 150, },
    },
    live_grep = {
      preview = { treesitter = false, },
      layout_config = { width = 180, preview_width = 70, },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    file_browser = {
      hidden = true,
      grouped = true,
      prompt_path = true,
      follow_symlinks = true,
      respect_gitignore = true,
    },
  },
  theme = require('telescope.themes').get_dropdown(),
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('recent-files')

require('mini.pairs').setup()
-- require('mini.splitjoin').setup()
-- require('mini.statusline').setup()

require('mini.indentscope').setup({
  draw = {
    delay = 50,
    animation = require('mini.indentscope').gen_animation.none(),
  }
})

require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt' }
})

require('gitsigns').setup({
  signs = {
    delete    = {text = '_', show_count=true},
    topdelete = {text = '‾', show_count=true},
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
    ['+'] = '|',
  }
})

require('nvim_comment').setup({
  comment_empty = false,
  comment_empty_trim_whitespace = false,
  hook = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end
})

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.blade = {
  install_info = {
    url = 'https://github.com/EmranMR/tree-sitter-blade',
    files = {'src/parser.c'},
    branch = 'main',
  },
  filetype = 'blade'
}

require('nvim-treesitter.configs').setup({
  modules = {},
  ignore_install = {},
  ensure_installed = {
    'astro',
    'bash',
    'blade',
    'c',
    'css',
    'go',
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
    'vimdoc',
    'vue',
    'yaml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- TEST
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = { enable = true },
  auto_install = true,
  sync_install = false,
  autotag = {
    enable = true,
    filetypes = {
      'astro',
      'blade',
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
      lookahead = true,
      keymaps = {
        ["av"] = "@assignment.outer",
        ["iv"] = "@assignment.inner",
        ["vl"] = "@assignment.lhs",
        ["vr"] = "@assignment.rhs",

        -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
        ["=a"] = "@property.outer",
        ["=i"] = "@property.inner",
        ["=l"] = "@property.lhs",
        ["=r"] = "@property.rhs",

        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",

        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",

        ["af"] = "@call.outer",
        ["if"] = "@call.inner",

        ["ad"] = "@function.outer",
        ["id"] = "@function.inner",

        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
        enable = true,
        swap_next = {
            ["<leader>ml"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>mj"] = "@property.outer", -- swap object property with next
            ["<leader>mm"] = "@function.outer", -- swap function with next
        },
        swap_previous = {
            ["<leader>mh"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>mk"] = "@property.outer", -- swap object property with prev
            ["<leader>,m"] = "@function.outer", -- swap function with previous
        },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Right>",
      node_incremental = "<Right>",
      scope_incremental = "<S-CR>",
      node_decremental = "<Left>",
    },
  },
  disable = { 'log', 'txt' },
})

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
base_capabilities.textDocument.completion.completionItem.snippetSupport = true
base_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
if not vim.lsp.inlay_hint then
  base_capabilities.textDocument.inlayHint = nil
end

local capabilities = require('blink.cmp').get_lsp_capabilities(base_capabilities)

require('lspconfig').lua_ls.setup{
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
}

require'lspconfig'.volar.setup{
  capabilities = capabilities,
  filetypes = { 'vue', 'json' },
  settings = {
    vue = {
      useWorkspaceDependencies = true,
      validation = {
        script = true,
        style = true,
        template = true,
      },
      completion = {
        autoImport = true,
        tagCasing = 'kebab',
        tagPrefix = 'v',
        getAttributes = 'all',
      },
      format = {
        defaultFormatter = {
          css = 'vscode-css-languageservice',
          html = 'prettyhtml',
          js = 'vscode-typescript-languageservice',
          json = 'vscode-json-languageservice',
          less = 'vscode-css-languageservice',
          md = 'vscode-markdown-languageservice',
          postcss = 'vscode-css-languageservice',
          pug = 'pug-formatter',
          sass = 'vscode-css-languageservice',
          scss = 'vscode-css-languageservice',
          ts = 'vscode-typescript-languageservice',
          yaml = 'vscode-json-languageservice',
        },
      },
    },
  },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = {
      css = true,
      javascript = true,
      typescript = true,
      html = true,
      json = true,
    },
  },
  on_attach = on_attach,
}

-- LSP Config Mappings
kmap('n', '<leader>di', vim.diagnostic.open_float, opts)
kmap('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
kmap('n', '<leader>dn', vim.diagnostic.goto_next, opts)
kmap('n', '<leader>q', vim.diagnostic.setloclist, opts)


-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o> ???
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.server_capabilities.documentRangeFormattingProvider then
    local lsp_format_modifications = require'lsp-format-modifications'
    lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  -- -- Use vim.cmd with echo to display messages in Neovim
  -- vim.cmd('echo "LSP client attached with the following capabilities: ' .. vim.inspect(client.resolved_capabilities) .. '"')

  if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint(bufnr, true)
  end

  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(true)
  -- end

  -- if vim.lsp.inlay_hint then
  --   vim.lsp.inlay_hint.enable(true)
  -- end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  kmap('n', 'gr', vim.lsp.buf.references, bufopts)
  kmap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  kmap('n', 'gd', vim.lsp.buf.definition, bufopts)
  kmap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  kmap('n', 'gi', '<cmd>Telescope lsp_references theme=cursor<CR>', bufopts)
  kmap('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  kmap('n', 'gh', vim.lsp.buf.hover, bufopts)
  kmap('n', 'K', vim.lsp.buf.hover, bufopts)
  kmap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  kmap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  kmap('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  -- kmap('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  kmap('v', '<leader>f', ':lua vim.lsp.buf.format<CR>', bufopts)

  kmap('n', '<leader>dk', vim.diagnostic.goto_prev, bufopts)
  kmap('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
  kmap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', bufopts)
end

require'lspconfig'.lua_ls.setup{
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} }, -- Get the language server to recognize the `vim` global
      workspace = { library = api.nvim_get_runtime_file("", true) }, -- Make the server aware of Neovim runtime files
      telemetry = { enable = false },
    },
  },
}

require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

require'lspconfig'.volar.setup{
  capabilities = capabilities,
  filetypes = { 'vue', 'json' },
  settings = {
    vue = {
      useWorkspaceDependencies = true,
      validation = {
        script = true,
        style = true,
        template = true,
      },
      completion = {
        autoImport = true,
        tagCasing = 'kebab',
        tagPrefix = 'v',
        getAttributes = 'all',
      },
      format = {
        defaultFormatter = {
          css = 'vscode-css-languageservice',
          html = 'prettyhtml',
          js = 'vscode-typescript-languageservice',
          json = 'vscode-json-languageservice',
          less = 'vscode-css-languageservice',
          md = 'vscode-markdown-languageservice',
          postcss = 'vscode-css-languageservice',
          pug = 'pug-formatter',
          sass = 'vscode-css-languageservice',
          scss = 'vscode-css-languageservice',
          ts = 'vscode-typescript-languageservice',
          yaml = 'vscode-json-languageservice',
        },
      },
    },
  },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = {
      css = true,
      javascript = true,
      typescript = true,
      html = true,
      json = true,
    },
  },
  on_attach = on_attach,
}

local util = require 'lspconfig.util'
require'lspconfig'.biome.setup{
  capabilities = capabilities,
  cmd = { 'biome', 'lsp-proxy' },
  root_dir = util.root_pattern('biome.json', 'biome.jsonc'),
  filetypes = {
    "astro",
    "css",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  init_options = {
    provideFormatter = true,
    provideInlayHints = true,
  },
  on_attach = on_attach,
}

require'lspconfig'.ts_ls.setup{
  capabilities = capabilities,
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  filetype = {
    'javascript',
    'typescript',
    'vue',
  },
  on_attach = on_attach,
}

require'lspconfig'.bashls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.pylsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.intelephense.setup{
  capabilities = capabilities,
  filetypes = { 'blade', 'php' },
  telemetry = {
    enable = false,
  },
  init_options = {
    provideFormatter = true,
  },
  inlayHints = {
    parameterNames = 'all',
    enabled = 'all',
  },
  on_attach = on_attach,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  filetypes = { 'html', 'blade', 'svelte', 'astro' },
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

require'lspconfig'.intelephense.setup{
  capabilities = capabilities,
  filetypes = { 'blade', 'php' },
  init_options = {
    provideFormatter = true,
  },
  on_attach = on_attach,
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.spell,
    },
})

-- Smart line delete
local function smart_dd()
  if api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })

-- vim.api.nvim_create_augroup("lsp_document_highlight", {
--   clear = true
-- })
-- vim.api.nvim_clear_autocmds {
--   buffer = bufnr,
--   group = "lsp_document_highlight"
-- }
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = vim.lsp.buf.document_highlight,
--   buffer = bufnr,
--   group = "lsp_document_highlight",
--   desc = "Document Highlight",
-- })
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   callback = vim.lsp.buf.clear_references,
--   buffer = bufnr,
--   group = "lsp_document_highlight",
--   desc = "Clear All the References",
-- })

-- local statusline = require('statusline')
-- statusline.tabline = false

function open_in_trae()
  local pos = api.nvim_win_get_cursor(0)
  local file = fn.expand('%:p')
  local target = string.format("%s:%d:%d", file, pos[1], (pos[2]+1))
  -- vim.api.nvim_echo({{target, 'Normal'}}, true, {})
  os.execute(string.format("trae . && trae -g '%s'", target))
end

function open_in_finder()
  os.execute(string.format("open '%s'", fn.expand('%:h')))
end

function run_bun_run()
  vim.cmd(string.format("!bun '%s'", fn.expand('%:p')))
end

map('n', '<leader>ot', ':lua open_in_trae()<CR>', opts)
map('n', '<leader>of', ':lua open_in_finder()<CR>', opts)
map('n', '<leader><CR>', ':lua run_bun_run()<CR>', opts)
map('n', '<leader>;', ':Neogit<CR>', opts)

-- Move between splits
map('n', '<leader>k', ':wincmd k<CR>', opts)
map('n', '<leader>j', ':wincmd j<CR>', opts)
map('n', '<leader>h', ':wincmd h<CR>', opts)
map('n', '<leader>l', ':wincmd l<CR>', opts)


local function disable_treesitter_features()
  local features = {
    "highlight",
    "incremental_selection",
    "indent",
    "textobjects",
    "fold",
    "playground",
    "query_linter",
    "rainbow",
    "refactor",
    "context_commentstring"
  }
  for _, feature in ipairs(features) do
    vim.cmd("TSBufDisable " .. feature)
  end
end

local function disable_additional_plugins()
  local plugins = {
    'mini.indentscope',
    'colorizer',
  }
  for _, plugin in ipairs(plugins) do
    -- Try to disable the plugin if it has a disable method
    if package.loaded[plugin] then
      local plugin_module = require(plugin)
      if plugin_module and type(plugin_module.disable) == 'function' then
        pcall(plugin_module.disable)
      end
    end
  end
end

local function disable_treesitter_for_large_files()
  local file = fn.expand('%:p')
  local size = fn.getfsize(file)
  local max_size = 1024 * 1024 * 2 -- 2MB
  local log_file_types = { 'log', 'txt' }

  if size > max_size then
    disable_treesitter_features()
    disable_additional_plugins()
    return
  end

  local file_type = fn.expand('%:e')
  if vim.tbl_contains(log_file_types, file_type) then
    disable_treesitter_features()
    disable_additional_plugins()
  end
end

api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  callback = disable_treesitter_for_large_files,
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if not vim.b.already_read then
      vim.b.already_read = true
      local file_type = vim.bo.filetype
      if (file_type == 'log' or file_type == 'txt') then
        vim.cmd('syntax off')
        vim.notify("Syntax highlighting disabled for filetype "..file_type, vim.log.levels.INFO)
      end
    end
  end
})

local uv = vim.loop
api.nvim_create_autocmd('VimEnter', {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. '/tmux-window-name/scripts/rename_session_windows.py', {})
		end
	end,
})

