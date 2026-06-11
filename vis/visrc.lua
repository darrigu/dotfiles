require('vis')

vis.events.subscribe(vis.events.INIT, function()
    vis:command('set theme base16-nord')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function()
    vis:command('set tabwidth 4')
    vis:command('set expandtab on')
    vis:command('set relativenumbers on')
    vis:command('set autoindent on')
    vis:map(vis.modes.NORMAL, ' ff', function()
        vis:command('open .')
        vis:feedkeys('<C-w>k')
        vis:command('wq!')
    end, '')
end)

require('plugins/vis-lspc')
