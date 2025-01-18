-- Set the leader key to Left Control (Ctrl)
vim.g.mapleader = "<C-space>"  -- Left Control + Space as the leader key

-- Bootstrap Lazy.nvim if not installed
local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    install_path,
  })
end
vim.opt.rtp:prepend(install_path)

-- Lazy.nvim setup
require("lazy").setup({
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",          -- LSP Config
    dependencies = {
      "williamboman/mason.nvim",       -- Mason for LSP installation
      "williamboman/mason-lspconfig.nvim", -- Mason LSP config
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      
      -- LSP settings
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Example for Python (pyright)
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- TypeScript Language Server (typescript-language-server)
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable formatting for ts_ls because typescript-language-server handles it
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end,
      })

      -- Add other LSP servers as needed
    end
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",          -- Completion plugin
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP completions
      "hrsh7th/cmp-buffer",      -- Buffer completions
      "hrsh7th/cmp-path",        -- Path completions
      "hrsh7th/cmp-cmdline",     -- Command line completions
      "L3MON4D3/LuaSnip",        -- Snippets
      "saadparwaiz1/cmp_luasnip",-- LuaSnip for nvim-cmp
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
      })
    end
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",    -- Treesitter for syntax highlighting
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",            -- Install all languages
        highlight = { enable = true },       -- Enable syntax highlighting
        indent = { enable = true },          -- Enable automatic indentation
      })
    end
  },

  -- Catpuccin Colorscheme
  {
    "catppuccin/nvim",                   -- Catpuccin theme
    config = function()
      vim.cmd("colorscheme catppuccin-macchiato")  -- Set macchiato variant of Catpuccin
    end
  },

  -- File explorer (nvim-tree)
  {
    "nvim-tree/nvim-tree.lua",           -- File tree
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,                     -- Set the width of the file tree
          side = "left",                  -- Position the file tree on the left
          number = true,                  -- Show line numbers in the file tree
          relativenumber = true,          -- Show relative line numbers in the file tree
        },
        filters = {
          dotfiles = false,              -- Show dotfiles
        },
        renderer = {
          group_empty = true,            -- Group empty directories
          highlight_opened_files = "name", -- Highlight opened files in the tree
        },
      })
    end
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",         -- Statusline
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",  -- Use Catpuccin theme for the status line
        },
      })
    end
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",           -- Git integration in Neovim
    config = function()
      require("gitsigns").setup()
    end
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",     -- Fuzzy finder
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
    end
  },

  -- Auto-pairs
  {
    "windwp/nvim-autopairs",            -- Auto pairs for brackets, quotes, etc.
    config = function()
      require("nvim-autopairs").setup()
    end
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",            -- Easy commenting
    config = function()
      require("Comment").setup()
    end
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",          -- Bufferline (tabs)
    dependencies = { "moll/vim-bbye" },
    config = function()
      require("bufferline").setup({
        options = {
          offsets = {{ filetype = "NvimTree", text = "File Explorer" }},
          separator_style = "slant",
        },
      })
    end
  },
})

-- General settings
vim.opt.syntax = "on"                    -- Enable syntax highlighting
vim.opt.number = true                    -- Show line numbers
vim.opt.relativenumber = false           -- Disable relative line numbers (set to absolute)
vim.opt.mouse = "a"                      -- Enable mouse support
vim.opt.tabstop = 4                      -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4                   -- Set indentation width to 4 spaces
vim.opt.expandtab = true                 -- Convert tabs to spaces
vim.opt.smartindent = true               -- Smart indenting
vim.opt.wrap = false                     -- Disable line wrapping
vim.opt.clipboard = "unnamedplus"        -- Use system clipboard

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = false          -- Set relative line numbers to false

-- Set up auto-save on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("write")
  end
})

-- Key mappings
vim.keymap.set('n', '<C-space>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })  -- Toggle NvimTree
vim.keymap.set('n', '<C-space>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })  -- Find files with Telescope
vim.keymap.set('n', '<C-space>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- Find text with Telescope
vim.keymap.set('n', '<C-space>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })  -- Find buffers with Telescope
vim.keymap.set('n', '<C-space>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })  -- Find help tags with Telescope

-- LSP mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })  -- Go to definition
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })  -- Find references
vim.keymap.set('n', '<C-space>rn', vim.lsp.buf.rename, { noremap = true, silent = true })  -- Rename symbol

-- Bufferline mappings
vim.keymap.set('n', '<C-space>bn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })  -- Next buffer
vim.keymap.set('n', '<C-space>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })  -- Previous buffer

