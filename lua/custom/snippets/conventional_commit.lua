local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local sn = ls.snippet_node

local snip = s('conventional_commit_message', {
  c(1, {
    t 'feat',
    t 'fix',
    t 'docs',
    t 'style',
    t 'refactor',
    t 'perf',
    t 'test',
    t 'chore',
  }),
  c(2, {
    sn(nil, {
      t '(',
      i(1, 'scope'),
      t ')',
    }),
    t '',
  }),
  t ': ',
})

ls.add_snippets('gitcommit', { snip })
ls.add_snippets('NeogitCommitMessage', { snip })
