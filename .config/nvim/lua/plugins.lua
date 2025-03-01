-- lua/plugins.lua

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Essential plugin: auto-detect indent settings
  "tpope/vim-sleuth",

  -- nvim-tree: file explorer on the left
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "left",
        width = 30,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- Call the default mappings (includes Enter, etc.)
        api.config.mappings.default_on_attach(bufnr)

        -- You can then add any extra custom mappings here:
        vim.keymap.set("n", "<C-h>", function()
          vim.g.nvim_tree_show_hidden = not vim.g.nvim_tree_show_hidden
          require("nvim-tree").setup({
            filters = { dotfiles = not vim.g.nvim_tree_show_hidden }
          })
          api.tree.reload()
        end, { desc = "Toggle Hidden Files", buffer = bufnr, noremap = true, silent = true })
      end,
    },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
  },

  -- Telescope: fuzzy finder and search tool
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      -- Global keymaps for file search and pattern search
      vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").live_grep, { desc = "Grep (pattern search)" })
    end,
  },

  -- LSP, Mason, and related tooling
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim",       opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim",             opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- LSP attachment callback with additional keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local opts = { buffer = buf, desc = "LSP: " }
          vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, vim.tbl_extend("force", opts, { desc = opts.desc .. "Goto Definition" }))
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, vim.tbl_extend("force", opts, { desc = opts.desc .. "Goto References" }))
          vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, vim.tbl_extend("force", opts, { desc = opts.desc .. "Goto Implementation" }))
          vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, vim.tbl_extend("force", opts, { desc = opts.desc .. "Type Definition" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = opts.desc .. "Rename" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = opts.desc .. "Code Action" }))
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })

      -- Setup LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Configure servers (example for lua_ls)
      require("mason-tool-installer").setup { ensure_installed = { "stylua" } }
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = false,
      })
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
          },
        },
      })
    end,
  },

  -- Completion engine and snippet support
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip").config.setup {}
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
        },
      })
    end,
  },

  -- Comment.nvim for VS Code–like commenting with Ctrl-/
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc" }, -- original mappings (you can disable these if you want custom ones)
    config = function()
      require("Comment").setup({
        -- Disable default mappings so we can define our own
        mappings = {
          basic = false,
          extra = false,
        },
      })
      -- Map Ctrl-/ (using <C-_> which is often equivalent)
      vim.keymap.set("n", "<C-_>", function() require("Comment.api").toggle.linewise.current() end,
      { desc = "Toggle comment" })
      vim.keymap.set("v", "<C-_>", function()
        local mode = vim.fn.visualmode()
        require("Comment.api").toggle.linewise(mode)
      end, { desc = "Toggle comment" })
    end,
  },

  -- lualine for a status bar at the bottom
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "auto", section_separators = "", component_separators = "|" },
    },
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  -- Material dark theme
  {
  "marko-cerovac/material.nvim",
  config = function()
    vim.g.material_style = "darker"  -- choose the dark variant
    vim.cmd("colorscheme material")
  end,
},

  -- Treesitter for better syntax highlighting
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({
        transparent = false,
        style = {
          boolean = "bold",
          number = "none",
          float = "none",
          error = "bold",
          comments = "italic",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "italic",
          variables = "none",
          keywords = "none",
          keyword_return = "italic",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",
          builtin_constants = "bold",
          builtin_functions = "none",
          builtin_types = "bold",
          builtin_variables = "none",
        },
        plugins = {
          cmp = { match = "bold", match_fuzzy = "bold" },
          dashboard = { footer = "italic" },
          lsp = {
            diagnostic_error = "bold",
            diagnostic_hint = "none",
            diagnostic_info = "italic",
            diagnostic_warn = "bold",
          },
          neotest = { focused = "bold", adapter_name = "bold" },
          telescope = { match = "bold" },
        },
        colors = {
          bg = "#141415",
          fg = "#cdcdcd",
          floatBorder = "#878787",
          line = "#252530",
          comment = "#606079",
          builtin = "#b4d4cf",
          func = "#c48282",
          string = "#e8b589",
          number = "#e0a363",
          property = "#c3c3d5",
          constant = "#aeaed1",
          parameter = "#bb9dbd",
          visual = "#333738",
          error = "#df6882",
          warning = "#f3be7c",
          hint = "#7e98e8",
          operator = "#90a0b5",
          keyword = "#6e94b2",
          type = "#9bb4bc",
          search = "#405065",
          plus = "#8cb66d",
          delta = "#f3be7c",
        },
      })
      -- Optionally, set the colorscheme immediately:
      vim.cmd("colorscheme vague")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

}, {
  ui = {
    -- Optional: You can define custom icons if your Nerd Font is enabled,
    -- otherwise, fallback to text icons.
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

