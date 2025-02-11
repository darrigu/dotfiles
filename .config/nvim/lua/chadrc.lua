local options = {
   base46 = {
      theme = "catppuccin",
      hl_override = {
         CmpPmenu = { bg = "#191828" },
      },
   },
   ui = {
      cmp = {
         style = "atom_colored",
         format_colors = {
            tailwind = true,
            icon = "󱓻",
         },
      },
      statusline = { theme = "vscode_colored" },
      tabufline = { enabled = false },
   },
   lsp = { signature = true },
   colorify = {
      enabled = true,
      mode = "virtual",
      virt_text = "󱓻 ",
      highlight = { hex = true, lspvars = true },
   },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
