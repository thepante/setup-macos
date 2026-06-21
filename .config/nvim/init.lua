vim.loader.enable()

-- Disable default providers
vim.g.loaded_python2_provider = 0
vim.g.loaded_ruby_provider = -1
vim.g.loaded_perl_provider = -4
vim.g.loaded_node_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local opt = vim.opt

-- UI Configuration
opt.number = true
opt.relativenumber = false
opt.numberwidth = 1
opt.signcolumn = 'yes:1'
opt.cursorline = true
opt.laststatus = 3
opt.showmode = false
opt.wrap = false
opt.shortmess:append("sI")
opt.termguicolors = true

-- Behavior
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 500 -- Increased from 300 to give more time for leader sequences
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'

-- Folding (Native 0.12 Treesitter Folds)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = '0'
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

-- Clean up wildmenu
opt.wildignore:append({
    "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
    "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/*",
    "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico",
    "*.DS_Store", "*/node_modules/*", "*/target/*", "*/dist/*", "*/tmp/*"
})

-- ========================================================================== --
--                                  2. PLUGIN BOOTSTRAP                       --
-- ========================================================================== --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
--                                  3. PLUGIN SETUP                           --
-- ========================================================================== --
require('lazy').setup({

    -- UI & THEMES
	{
		'dgox16/oldworld.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('oldworld')
			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		end
	},
	-- { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = { options = { theme = 'catppuccin' } } },
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = { options = { theme = 'auto' } } },

    -- Navigation & Utilities
    { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = true },
    { 'lewis6991/gitsigns.nvim', opts = {} },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    { 'numToStr/Comment.nvim', opts = {} },

	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'MunifTanjim/nui.nvim', lazy = true },
    {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        opts = {
            input = { enabled = true },
            select = { enabled = true, backend = { "fzf_lua", "telescope", "builtin" } },
        }
    },

    -- UTILS
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'folke/todo-comments.nvim', event = "BufReadPost", opts = { signs = false } },
    {
        'echasnovski/mini.nvim',
        version = false,
        event = "VeryLazy",
        config = function()
            require('mini.pairs').setup()
            require('mini.surround').setup({
                mappings = {
                    add = 'ca', delete = 'cd', find = 'cf', find_left = 'cF',
                    highlight = 'ch', replace = 'cr', update_n_lines = 'cn',
                    suffix_last = 'l', suffix_next = 'n',
                },
            })
            require('mini.indentscope').setup({
                symbol = "│",
                draw = { animation = require('mini.indentscope').gen_animation.none() }
            })
            require('mini.ai').setup()
        end
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = { modes = { search = { enabled = false } } },
        keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" } },
    },

    -- GIT
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "▎" }, change = { text = "▎" }, delete = { text = "_" },
                topdelete = { text = "‾" }, changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end
                map('n', ']h', gs.next_hunk, "Next Hunk")
                map('n', '[h', gs.prev_hunk, "Prev Hunk")
                map('n', '<leader>hp', gs.preview_hunk, "Preview Hunk")
                map('n', '<leader>hb', function() gs.blame_line{full=true} end, "Blame Line")
            end,
        }
    },
    { "NeogitOrg/neogit", cmd = "Neogit", dependencies = { "sindrets/diffview.nvim" }, opts = { integrations = { diffview = true } } },

    -- COMPLETION (Blink)
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        event = 'InsertEnter',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },
            appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
            sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, min_keyword_length = 2 },
            completion = {
                menu = { border = 'rounded' },
                documentation = { window = { border = 'rounded' } },
            },
            signature = { enabled = true }
        }
    },

--	{
--		"nickjvandyke/opencode.nvim",
--		version = "*",
--		dependencies = {
--			{
--				-- `snacks.nvim` integration is recommended, but optional
--				---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
--				"folke/snacks.nvim",
--				optional = true,
--				opts = {
--					input = {}, -- Enhances `ask()`
--					picker = { -- Enhances `select()`
--						actions = {
--							opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
--						},
--						win = {
--							input = {
--								keys = {
--									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
--								},
--							},
--						},
--					},
--				},
--			},
--		},
--		config = function()
--			---@type opencode.Opts
--			vim.g.opencode_opts = {
--				-- Your configuration, if any; goto definition on the type or field for details
--			}
--
--			vim.o.autoread = true -- Required for `opts.events.reload`
--
--			-- Recommended/example keymaps
--			vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
--			vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
--			vim.keymap.set({ "n", "t" }, "<C-r>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
--
--			vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
--			vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })
--
--			vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
--			vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
--
--			-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
--			-- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
--			-- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
--		end,
--	},

	-- 1. THE INLINE AGENT (Surgical buffer edits)
    {
        "pablopunk/pi.nvim",
        cmd = { "PiAsk", "PiAskSelection" },
        keys = {
            { "<leader>pa", "<cmd>PiAsk<CR>", mode = "n", desc = "Pi: Ask (Buffer)" },
            { "<leader>pa", "<cmd>PiAskSelection<CR>", mode = "v", desc = "Pi: Ask (Selection)" },
            -- Specialized inline agent
            { "<leader>pf", function()
                require("pi").run({ system_prompt = "Fix bugs in this code. Output ONLY code." })
            end, mode = { "n", "v" }, desc = "Pi: Fix Selection" },
        }
    },

    -- 2. THE CONVERSATIONAL AGENT (Floating Terminal)
    {
        "aldoborrero/pi-agent.nvim",
        opts = {
            window = { position = "float", float = { width = "90%", height = "90%" } },
        },
        keys = {
            -- Use a different prefix/key for the terminal UI
            { "<leader>pt", "<cmd>PiAgent<cr>", mode = { "n", "t" }, desc = "Pi: Open Terminal UI" },
            { "<leader>pc", "<cmd>PiAgentContinue<cr>", mode = "n", desc = "Pi: Resume Chat" },
        }
    },

    -- NAVIGATION
    {
        'ibhagwan/fzf-lua',
        cmd = "FzfLua",
        keys = {
            { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
            { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Search Word" },
            { "<leader>sd", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols" },
        },
        config = function()
            require('fzf-lua').setup({ winopts = { height = 0.85, width = 0.80, preview = { layout = 'flex' } } })
        end
    },
    {
		'stevearc/oil.nvim',
		opts = {
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
		},
		keys = {{
			"-", "<cmd>Oil<cr>", desc = "Open Parent Directory"
		}}
	},
    {
        'dmtrKovalenko/fff.nvim',
        build = function() require("fff.download").download_or_build_binary() end,
        lazy = false,
        keys = {
            { "ff", function() require('fff').find_files() end, desc = 'FFF Files' },
            { "fF", function() require('fff').live_grep() end, desc = 'FFF Grep' },
            { "fz", function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end, desc = 'FFF Fuzzy Grep' },
            { "fc", function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end, desc = 'FFF Search Word' },
        }
    },

    -- TREESITTER
    -- {
        -- 'nvim-treesitter/nvim-treesitter',
        -- build = ':TSUpdate',
        -- event = { "BufReadPost", "BufNewFile" },
        -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "windwp/nvim-ts-autotag" },
        -- config = function()
            -- require('nvim-treesitter.configs').setup({
                -- ensure_installed = { "bash", "html", "javascript", "json", "lua", "markdown", "markdown_inline", "python", "tsx", "typescript", "php", "go", "rust", "css", "astro" },
                -- highlight = { enable = true },
                -- indent = { enable = true },
                -- autotag = { enable = true },
                -- textobjects = {
                    -- select = {
                        -- enable = true,
                        -- keymaps = { ["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@class.outer", ["ic"] = "@class.inner" },
                    -- },
                -- },
            -- })
        -- end
    -- },

--	{
--		'nvim-treesitter/nvim-treesitter',
--		build = ':TSUpdate',
--		event = { "BufReadPost", "BufNewFile" },
--			config = function()
--			-- FORCE GIT DOWNLOADS TO AVOID TAR ERRORS
--			require('nvim-treesitter.install').prefer_git = true
--
--			require('nvim-treesitter.configs').setup({
--				ensure_installed = {
--					"bash", "html", "javascript", "json", "lua",
--					"markdown", "markdown_inline", "python",
--					"tsx", "typescript", "php", "go", "rust", "css", "astro"
--				},
--				highlight = { enable = true },
--				indent = { enable = true },
--
--				-- Configuration for your extensions goes here
--				textobjects = {
--					select = {
--						enable = true,
--						keymaps = {
--							["af"] = "@function.outer",
--							["if"] = "@function.inner",
--							["ac"] = "@class.outer",
--							["ic"] = "@class.inner"
--						},
--					},
--				},
--			})
--		end
--	},
--	{
--		'nvim-treesitter/nvim-treesitter-textobjects',
--		dependencies = { 'nvim-treesitter/nvim-treesitter' },
--		event = "VeryLazy",
--	},
--    {
--        'windwp/nvim-ts-autotag',
--        dependencies = { 'nvim-treesitter/nvim-treesitter' },
--        event = "VeryLazy",
--        opts = {},
--    },


{
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "windwp/nvim-ts-autotag", opts = {} },
	},
	config = function()
		require('nvim-treesitter.install').prefer_git = true

		-- New API: vim.treesitter.language.* and per-parser configs
		require('nvim-treesitter').setup({
			ensure_installed = {
				"bash", "html", "javascript", "json", "lua",
				"markdown", "markdown_inline", "python",
				"tsx", "typescript", "php", "go", "rust", "css", "astro"
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
},

	-- Keep the extensions separate to avoid the 'module not found' loop
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		opts = {},
	},

--    -- AI (Gemini)
--    {
--        'yetone/avante.nvim',
--        event = 'VeryLazy',
--        build = 'make',
--        opts = { provider = 'gemini' },
--        keys = { { "<leader>aa", function() require("avante.api").toggle() end, desc = "Toggle AI Chat" } },
--		dependencies = {
--			'nvim-treesitter/nvim-treesitter',
--			'stevearc/dressing.nvim',
--			'nvim-lua/plenary.nvim',
--			'MunifTanjim/nui.nvim',
--		}
--    },

    -- FORMATTING
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        keys = { { "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format" } },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "biome" },
                typescript = { "biome" },
                php = { "pint", "php_cs_fixer" },
                go = { "goimports", "gofmt" },
            },
        },
    },

    -- LSP (MODERNIZED FOR 0.12)
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'saghen/blink.cmp' },
        config = function()
            local servers = {
                lua_ls = { settings = { Lua = { workspace = { checkThirdParty = false } } } },
                intelephense = {
                    settings = { intelephense = { files = { maxSize = 5000000 }, stubs = { "bcmath", "date", "filter", "hash", "iconv", "json", "mbstring", "openssl", "pcre", "readline", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", "zlib", "wordpress", "woocommerce" } } }
                },
                ts_ls = { single_file_support = true },
                gopls = {},
                rust_analyzer = {},
                astro = {},
                tailwindcss = {},
                biome = {},
                html = { filetypes = { 'html', 'blade', 'php' } },
            }

            require('mason').setup()
            require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })

            -- Global LspAttach
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client:supports_method('textDocument/inlayHint') then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                    local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = args.buf, desc = desc }) end
                    map('gd', require('fzf-lua').lsp_definitions, "Goto Definition")
                    map('gr', require('fzf-lua').lsp_references, "References")
                    map('<leader>rn', vim.lsp.buf.rename, "Rename")
                    map('<leader>ca', vim.lsp.buf.code_action, "Code Action")
                    map('K', vim.lsp.buf.hover, "Hover")
                end,
            })

            local blink = require('blink.cmp')
            for server, config in pairs(servers) do
                config.capabilities = blink.get_lsp_capabilities(config.capabilities)
                vim.lsp.config(server, config) -- Set the config natively
                vim.lsp.enable(server)         -- Enable the server natively
            end

            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                float = { border = "rounded", source = "always" },
            })
        end
    },
}, {
    performance = { rtp = { disabled_plugins = { "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})


-- ========================================================================== --
--                                  4. CUSTOM KEYMAPS                         --
-- ========================================================================== --
local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
map('n', '<leader>w', '<cmd>w<CR>', opts)
map('n', '<leader>q', '<cmd>q<CR>', opts)
map('n', '<Tab>', '%', opts)
map('v', '<Tab>', '%', opts)
map('x', '<Tab>', '%', opts)
map('n', 'x', '"_x', opts)

-- Toggle comment with Cmd + /
-- Note: 'remap = true' is required to trigger the native 'gcc' and 'gc' behaviors
map('n', '<D-/>', 'gcc', { remap = true, silent = true })
map('v', '<D-/>', 'gc', { remap = true, silent = true })

-- Navigation
map('n', '<D-h>', '<C-w>h', opts)
map('n', '<D-j>', '<C-w>j', opts)
map('n', '<D-k>', '<C-w>k', opts)
map('n', '<D-l>', '<C-w>l', opts)

-- Buffers
map('n', '<A-l>', '<cmd>bnext<CR>', opts)
map('n', '<A-h>', '<cmd>bprev<CR>', opts)
map('n', '<leader>x', '<cmd>bdelete<CR>', opts)

-- Moving Lines
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Better Paste
map("x", "<leader>p", [["_dP]])

-- ========================================================================== --
--                                  5. AUTOCOMMANDS                           --
-- ========================================================================== --
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.filetype.add({
    extension = { blade = "php" },
    pattern = { [".*%.blade%.php"] = "blade" },
})

autocmd('TextYankPost', {
    group = augroup('HighlightYank', { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

-- Jump to last position
autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Auto-create missing directories on save
autocmd({ "BufWritePre" }, {
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
