local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local sfor = s('for', {
  t 'for ',
  i(1, '@'),
  c(2, {
    t '',
    sn(nil, {
      t ' -> ',
      i(1, '$i'),
    }),
    sn(nil, {
      t '.kv -> ',
      i(1, '$i'),
      t ', ',
      i(2, '$value'),
    }),
  }),
  t { ' {', '\t' },
  i(0),
  t { '', '}' },
})

local function snhas(indent)
  if indent == nil then
    indent = ''
  end
  return sn(nil, {
    t(indent .. 'has '),
    c(1, {
      i(nil),
      i(nil, 'Int'),
      i(nil, 'Str'),
    }),
    t ' ',
    c(2, {
      t '$',
      t '@',
      t '%',
      t '&',
    }),
    c(3, { t '.', t '!' }),
    i(4, 'attr'),
    c(5, {
      t '',
      t ' is required',
    }),
    c(6, {
      t '',
      sn(nil, {
        t ' = ',
        i(1),
      }),
    }),
    t { ';', '' },
    c(7, {
      t '',
      d(8, snhas),
    }),
  })
end

local has = s('has', { d(1, snhas, {}) })

local function uclass()
  return sn(nil, {
    t 'unit class ',
    i(1, '::'),
    t { ';', '' },
    c(2, {
      t '',
      d(3, function()
        return snhas ''
      end, {}),
    }),
    i(0),
    t { '', '' },
  })
end

local function bclass()
  return sn(nil, {
    t 'class ',
    i(1, '::'),
    t { ' {', '' },
    c(2, {
      t '',
      d(3, function()
        return snhas '\t'
      end, {}),
    }),
    t '\t',
    i(0),
    t { '', '}' },
  })
end

local sclass = s(
  'class',
  c(1, {
    d(2, uclass, {}),
    d(2, bclass, {}),
  })
)

ls.add_snippets('raku', { sfor, has, sclass })
