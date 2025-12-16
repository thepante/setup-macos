vim.loader.enable()

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.numberwidth = 1
opt.signcolumn = 'yes:1'
opt.cursorline = true
opt.laststatus = 3
opt.showmode = false
opt.termguicolors = true
opt.wrap = false
opt.shortmess:append("sI")

-- Behavior
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'
opt.hlsearch = true

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = '0'
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Clean up wildmenu
opt.wildignore:append({
    "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
    "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/*",
    "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico",
    "*.DS_Store", "*/node_modules/*", "*/target/*", "*/dist/*", "*/tmp/*"
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    -- UI & THEMES
    {
        'dgox16/oldworld.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('oldworld')
            -- Optional: Transparent background adjustments
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        end
    },
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
    {
        'folke/todo-comments.nvim',
        event = "BufReadPost",
        opts = { signs = false }
    },
    {
        'echasnovski/mini.nvim',
        version = false,
        event = "VeryLazy",
        config = function()
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.comment').setup()
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
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
    },

    -- GIT
    {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
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
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = { "sindrets/diffview.nvim" },
        opts = { disable_hint = true, integrations = { diffview = true } }
    },

    -- COMPLETION (Blink.cmp)
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',
        event = 'InsertEnter',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                min_keyword_length = 2,
            },
            completion = {
                menu = { border = 'rounded' },
                documentation = { window = { border = 'rounded' } },
            },
            signature = { enabled = true }
        }
    },

    -- AI
    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        build = 'make',
        opts = { provider = 'gemini' },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'stevearc/dressing.nvim', 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' }
    },

    -- NAVIGATION (FZF-Lua + Oil)
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
            require('fzf-lua').setup({
                winopts = { height = 0.85, width = 0.80, preview = { layout = 'flex' } },
            })
        end
    },
    {
        'stevearc/oil.nvim',
        opts = {
            skip_confirm_for_simple_edits = true,
            view_options = { show_hidden = true },
            float = { padding = 2, max_width = 100, max_height = 0 },
        },
        keys = { { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" } },
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-file-browser.nvim'
        },
        opts = {
            defaults = { file_ignore_patterns = { "node_modules", ".git" } },
            extensions = { fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true } }
        },
        config = function(_, opts)
            local t = require('telescope')
            t.setup(opts)
            t.load_extension('fzf')
            t.load_extension('file_browser')
        end
    },

    -- TREESITTER
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash", "c", "html", "javascript", "json", "lua", "markdown",
                    "markdown_inline", "python", "query", "regex", "tsx", "typescript",
                    "vim", "vimdoc", "yaml", "php", "go", "rust", "css", "scss"
                },
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then return true end
                    end,
                },
                indent = { enable = true },
                autotag = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer", ["if"] = "@function.inner",
                            ["ac"] = "@class.outer", ["ic"] = "@class.inner",
                        },
                    },
                },
            })
        end
    },

    -- FORMATTING & LINTING
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            { "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format" },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
                typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "biome", "prettier" },
                php = { "pint", "php_cs_fixer" },
                go = { "goimports", "gofmt" },
            },
        },
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'saghen/blink.cmp',
            'lvimuser/lsp-inlayhints.nvim',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({ automatic_installation = true })
            require("lsp-inlayhints").setup()

            -- 1. Create a global LspAttach listener (The modern 0.11 way)
            -- This replaces the old "on_attach" passed to every server
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local bufnr = args.buf

                    -- Inlay Hints
                    if client.server_capabilities.inlayHintProvider then
                        require('lsp-inlayhints').on_attach(client, bufnr)
                    end

                    -- Keymappings
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                    end

                    map('gd', require('fzf-lua').lsp_definitions, "Goto Definition")
                    map('gr', require('fzf-lua').lsp_references, "References")
                    map('gI', require('fzf-lua').lsp_implementations, "Implementation")
                    map('<leader>rn', vim.lsp.buf.rename, "Rename")
                    map('<leader>ca', vim.lsp.buf.code_action, "Code Action")
                    map('K', vim.lsp.buf.hover, "Hover")
                    map('<leader>di', vim.diagnostic.open_float, "Diagnostic Float")
                end,
            })

            -- 2. Define Servers & Settings
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = { globals = { 'vim' } }
                        }
                    }
                },
                html = { filetypes = { 'html', 'blade', 'php', 'javascript' } },
                cssls = {},
                ts_ls = {
                    root_dir = require('lspconfig.util').root_pattern("package.json"),
                    single_file_support = false,
                },
                biome = {},
                intelephense = {
                    settings = {
                        intelephense = {
                            files = { maxSize = 5000000 },
                            stubs = { "bcmath", "date", "filter", "hash", "iconv", "json", "mbstring", "openssl", "pcre", "readline", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", "zlib", "wordpress", "woocommerce" }
                        }
                    }
                },
                gopls = {},
                rust_analyzer = {},
                pyright = {},
            }

            -- 3. Configure & Enable Servers (0.11 Native API)
            -- We do NOT use lspconfig.setup() anymore.
            local blink = require('blink.cmp')

            for server, config in pairs(servers) do
                -- Get base config from nvim-lspconfig (if it exists) or empty table
                local default_config = vim.lsp.config[server] or {}

                -- Merge Capabilities
                config.capabilities = blink.get_lsp_capabilities(config.capabilities or default_config.capabilities)

                -- Merge everything into vim.lsp.config[server]
                vim.lsp.config[server] = vim.tbl_deep_extend("force", default_config, config)

                -- Enable the server (This sets up the FileType autocmds to start it)
                vim.lsp.enable(server)
            end

            -- Diagnostics Styling
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded", source = "always" },
            })
        end
    },
})

local map = vim.keymap.set
local opts = { silent = true }

-- General
map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
map('n', '<leader>w', '<cmd>w<CR>', opts)
map('n', '<leader>q', '<cmd>q<CR>', opts)
map('n', 'x', '"_x', opts) -- Do not yank on x

-- Navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Buffers
map('n', '<S-l>', '<cmd>bnext<CR>', opts)
map('n', '<S-h>', '<cmd>bprev<CR>', opts)
map('n', '<leader>x', '<cmd>bdelete<CR>', opts)

-- Moving Lines
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better Paste
map("x", "<leader>p", [["_dP]])

-- Emmet
vim.g.user_emmet_leader_key = ','

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.filetype.add({
    extension = {
        blade = "php",
        norg = "norg",
    },
    pattern = {
        [".*%.blade%.php"] = "blade",
        [".*%.js"] = "javascriptreact",
    },
})

autocmd('TextYankPost', {
    group = augroup('HighlightYank', { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

autocmd('FileType', {
    group = augroup('CloseWithQ', { clear = true }),
    pattern = { 'help', 'lspinfo', 'man', 'notify', 'qf', 'query', 'checkhealth', 'neotest-output' },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
    end,
})

autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

autocmd({ "BufWritePre" }, {
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

autocmd('TermOpen', {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd('startinsert')
    end,
})

