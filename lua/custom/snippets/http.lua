local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node

local http = s('http', {
  c(1, {
    t 'GET',
    t 'POST',
    t 'PUT',
    t 'PATCH',
    t 'DELETE',
    t 'OPTIONS',
    t 'HEAD',
    t 'CONNECT',
  }),
  t ' ',
  c(2, {
    t 'https',
    t 'http',
  }),
  t '://',
  i(3, 'domain.com'),
  t { '', '' },
  c(4, {
    t '',
    sn(nil, {
      i(1, 'headerKey'),
      t ': ',
      i(2, 'value'),
      t { '', '' },
    }),
  }),
  c(5, {
    t '',
    sn(nil, {
      i(1, 'key'),
      t '=',
      i(2, 'value'),
    }),
    sn(nil, {
      t { '{', '\t' },
      i(1),
      t { '', '}', '' },
    }),
  }),
  t { '', '###', '' },
})

ls.add_snippets('http', { http })
