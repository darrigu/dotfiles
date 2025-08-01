-- Put this at the top of 'init.lua'
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
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    require('mini.basics').setup({
        mappings = {
            basic = false
        }
    })

    vim.o.expandtab = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
    vim.o.softtabstop = -1
    vim.o.relativenumber = true
    vim.o.scrolloff = 8
    vim.o.sidescrolloff = 8
    vim.g.maplocalleader = ' '
end)

now(function()
    add({
        source = 'catppuccin/nvim',
        name = 'catppuccin',
    })
    require('catppuccin').setup({
        transparent_background = true
    })
    vim.cmd('colorscheme catppuccin')
end)

now(function() require('mini.icons').setup() end)

now(function() require('mini.statusline').setup() end)

now(function() require('mini.starter').setup() end)

later(function()
    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
        highlighters = {
            fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
            todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
            note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end)

later(function()
    require('mini.trailspace').setup()
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
            MiniTrailspace.trim()
            MiniTrailspace.trim_last_lines()
        end
    })
end)

later(function()
    require('mini.pairs').setup({
        mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

            [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
    })
end)

later(function() require('mini.align').setup() end)

later(function()
    require('mini.surround').setup({
        custom_surroundings = {
            ['('] = { output = { left = '(', right = ')' } },
            ['['] = { output = { left = '[', right = ']' } },
            ['{'] = { output = { left = '{', right = '}' } },
            ['<'] = { output = { left = '<', right = '>' } },
        }
    })
end)

later(function() require('mini.splitjoin').setup() end)

later(function() require('mini.bracketed').setup() end)

later(function() require('mini.move').setup({
    mappings = {
        left = '<M-left>',
        right = '<M-right>',
        down = '<M-down>',
        up = '<M-up>',

        line_left = '<M-left>',
        line_right = '<M-right>',
        line_down = '<M-down>',
        line_up = '<M-up>'
    }
}) end)

later(function()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup({
        snippets = {
            gen_loader.from_file('~/.config/nvim/snippets/global.json'),
            gen_loader.from_lang()
        }
    })
end)

later(function() require('mini.completion').setup() end)

later(function()
    local miniclue = require('mini.clue')
    miniclue.setup({
        triggers = {
            { mode = 'n', keys = '<leader>' },
            { mode = 'x', keys = '<leader>' },

            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },

            { mode = 'n', keys = '<C-w>' },

            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
        }
    })
end)

later(function()
    require('mini.pick').setup()
    vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
    vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>')
    vim.keymap.set('n', '<leader>l', ':Pick buf_lines<CR>')
end)

later(function()
    require('mini.files').setup({
        mappings = {
            go_in = '<right>',
            go_out = '<left>',
        }
    })
    vim.keymap.set('n', '<leader>.', MiniFiles.open)
end)

later(function() require('mini.extra').setup() end)

later(function()
    add('Olical/conjure')
    vim.cmd('let g:conjure#client#scheme#stdio#command = "petite"')
    vim.cmd('let g:conjure#client#scheme#stdio#prompt_pattern = "> $?"')
end)
