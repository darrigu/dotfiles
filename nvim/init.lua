local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
   vim.cmd('echo "Installing `mini.nvim`" | redraw')
   local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      -- Uncomment next line to use 'stable' branch
      -- '--branch', 'stable',
      'https://github.com/echasnovski/mini.nvim', mini_path
   }
   vim.fn.system(clone_cmd)
   vim.cmd('packadd mini.nvim | helptags ALL')
end

local MiniDeps = require('mini.deps')
MiniDeps.setup({ path = { package = path_package } })

local add = MiniDeps.add

add('ellisonleao/gruvbox.nvim')

add('nvim-tree/nvim-web-devicons')

add('kevinhwang91/nvim-bqf')

add({
   source = 'NeogitOrg/neogit',
   depends = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
   },
})

local indent_width = 3
vim.opt.tabstop = indent_width
vim.opt.shiftwidth = indent_width
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.fillchars = { eob = ' ' }
vim.opt.showmode = false
vim.opt.showcmd = false

vim.keymap.set('n', '<space>m', ':make!<cr>')

vim.keymap.set({'n', 'v'}, '<up>', 'g<up>')
vim.keymap.set({'n', 'v'}, '<down>', 'g<down>')

vim.cmd([[
   augroup RestoreCursor
      autocmd!
      autocmd BufRead * autocmd FileType <buffer> ++once
               \ let s:line = line("'\"")
               \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
               \      && index(['xxd', 'gitrebase'], &filetype) == -1
               \ |    execute "normal! g`\""
               \ | endif
   augroup END

   autocmd QuickFixCmdPost [^l]* nested cwindow
   autocmd QuickFixCmdPost    l* nested lwindow
]])

local now, later = MiniDeps.now, MiniDeps.later

now(function()
   vim.opt.background = 'light'
   vim.cmd.colorscheme('gruvbox')
end)

later(function() require('mini.statusline').setup() end)

later(function()
   require('mini.trailspace').setup()
end)

later(function() require('mini.align').setup() end)

later(function() require('mini.splitjoin').setup() end)

later(function()
   require('mini.move').setup({
      mappings = {
         left = '<M-left>',
         right = '<M-right>',
         up = '<M-up>',
         down = '<M-down>',
         line_left = '<M-left>',
         line_right = '<M-right>',
         line_up = '<M-up>',
         line_down = '<M-down>',
      },
      options = {
         reindent_linewise = false,
      },
   })
end)

later(function()
   local gen_loader = require('mini.snippets').gen_loader
   require('mini.snippets').setup({
      snippets = {
         gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
         gen_loader.from_lang(),
      },
   })
end)

later(function() require('mini.completion').setup() end)

now(function()
   require('mini.files').setup({
      mappings = {
         go_in = '<enter>',
         go_out = '-',
      },
   })
   vim.keymap.set('n', '<space>d', require('mini.files').open)
end)

later(function()
   require('mini.pick').setup()
   vim.keymap.set('n', '<space>f', ':Pick files<cr>')
   vim.keymap.set('n', '<space>b', ':Pick buffers<cr>')
   vim.keymap.set('n', '<space>l', ':Pick grep_live<cr>')
end)

later(function()
   require('neogit').setup()
   vim.keymap.set('n', '<space>g', ':Neogit<cr>')
end)
