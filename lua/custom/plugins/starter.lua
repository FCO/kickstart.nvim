local opts = {
  theme = 'doom',
  hide = {
    -- this is taken care of by lualine
    -- enabling this messes up the actual laststatus setting after loading a file
    statusline = false,
  },
  config = {
    center = {
      { action = 'Telescope find_files', desc = ' Find File', icon = '󰈞 ', key = 'f' },
      { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
      { action = 'Telescope oldfiles', desc = ' Recent Files', icon = '󰙰 ', key = 'r' },
      {
        action = 'lua require "telescope.builtin".find_files { cwd = vim.fn.stdpath "config" }',
        desc = ' Config',
        icon = ' ',
        key = 'c',
      },
      { action = "lua require('persisted').load()", desc = ' Last Session', icon = ' ', key = 's' },
      { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'p' },
      { action = 'Mason', desc = ' Mason', icon = '󱧕 ', key = 'm' },
      {
        action = function()
          vim.api.nvim_input '<cmd>qa<cr>'
        end,
        desc = ' Quit',
        icon = ' ',
        key = 'q',
      },
    },
    footer = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      local info = {}
      info[1] = '⚡ Neovim loaded '
        .. stats.loaded
        .. '/'
        .. stats.count
        .. ' plugins in '
        .. ms
        .. 'ms'
        .. ' on v'
        .. vim.version().major
        .. '.'
        .. vim.version().minor
        .. '.'
        .. vim.version().patch
      info[2] = ''

      local fortune = require('fortune').get_fortune()
      local footer = vim.list_extend(info, fortune)

      return info
    end,
  },
}

for _, button in ipairs(opts.config.center) do
  button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
  button.key_format = '  %s'
end

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == 'lazy' then
  vim.cmd.close()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'DashboardLoaded',
    callback = function()
      require('lazy').show()
    end,
  })
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    {
      'olimorris/persisted.nvim',
      lazy = false, -- make sure the plugin is always loaded at startup
      config = true,
    },
  },
  opts = opts,
}
