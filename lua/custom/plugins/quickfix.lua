vim.keymap.set('n', '<leader>Q', function()
  require('quicker').toggle()
  require('quicker').refresh()
end, {
  desc = 'Toggle quickfix',
})
vim.keymap.set('n', '<leader>Ql', function()
  require('quicker').toggle { loclist = true }
  require('quicker').refresh()
end, {
  desc = 'Toggle loclist',
})
return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  config = function()
    require('quicker').setup {
      keys = {
        {
          '+',
          function()
            require('quicker').expand { before = 2, after = 2, add_to_existing = true }
          end,
          desc = 'Expand quickfix context',
        },
        {
          '-',
          function()
            require('quicker').collapse()
          end,
          desc = 'Collapse quickfix context',
        },
      },
    }
  end,
}
