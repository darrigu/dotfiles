return {
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
         require("catppuccin").setup({
            integrations = {
               cmp = true,
               treesitter = true,
               mason = true,
               neogit = true,
            },
         })
         vim.cmd.colorscheme "catppuccin"
      end,
   },

   {
      "nvchad/ui",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         require("nvchad")
      end
   },

   {
      "nvchad/base46",
      lazy = true,
      build = function()
         require("base46").load_all_highlights()
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         local configs = require("nvim-treesitter.configs")
         configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
         })
      end,
   },

   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
   },

   {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp" },
      config = function()
         local cmp = require("cmp")
         local options = {
            mapping = {
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-e>"] = cmp.mapping.abort(),
               ["<C-n>"] = cmp.mapping.select_next_item(),
               ["<C-p>"] = cmp.mapping.select_prev_item(),
               ["<CR>"] = cmp.mapping.confirm({ select = false }),
            },
            sources = {
               { name = "buffer" },
               { name = "path" },
               { name = "nvim_lsp" },
            },
         }
         options = vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
         cmp.setup(options)
      end,
   },

   {
      "williamboman/mason.nvim",
      dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
      config = function()
         local lspconfig_defaults = require("lspconfig").util.default_config
         lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig_defaults.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
         )

         local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
         function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = {
               { '', 'NormalFloat' },
               { '', 'NormalFloat' },
               { '', 'NormalFloat' },
               { ' ', 'NormalFloat' },
               { '', 'NormalFloat' },
               { '', 'NormalFloat' },
               { '', 'NormalFloat' },
               { ' ', 'NormalFloat' },
            }
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
         end

         require("mason").setup()
         require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "csharp_ls", "zls", "html", "cssls" },
            handlers = {
               function(server_name)
                  require("lspconfig")[server_name].setup({})
               end,
               lua_ls = function()
                  require("lspconfig").lua_ls.setup({
                     settings = {
                        Lua = {
                           diagnostics = {
                              globals = { "vim" },
                           },
                           workspace = {
                              library = { vim.env.VIMRUNTIME },
                              checkThirdParty = false,
                           },
                        },
                     },
                  })
               end,
            },
         })
      end,
   },

   {
      "NeogitOrg/neogit",
      cmd = "Neogit",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "sindrets/diffview.nvim",
         "nvim-telescope/telescope.nvim",
      },
   },
}
