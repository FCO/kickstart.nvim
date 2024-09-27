local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function shift(index, indent, initial)
  local default = 'variable_name'
  if indent == nil then
    indent = ''
  end
  if initial then
    default = 'self'
  end
  return sn(index, {
    t 'my $',
    i(1, default),
    t ' = shift;',
    c(2, {
      t '',
      sn(nil, {
        t { '', indent },
        d(1, function()
          return shift(index, indent, nil)
        end, {}),
      }),
    }),
  })
end

local function snsub()
  return sn(nil, {
    t 'sub ',
    i(1, 'sub_name'),
    t { ' {', '\t' },
    d(2, function()
      return shift(3, '\t', true)
    end, {}),
    t { '', '' },
    i(3),
    t { '', '}', '' },
  })
end

local function par_type(index, type)
  if type == 'required' or type == 'coerce' or type == 'weak_ref' or type == 'lazy' then
    return i(index, '0')
  end
  if type == 'trigger' then
    return sn(index, { t 'sub { my $self = shift; ', i(1), t '}' })
  end
  if type == 'traits' then
    return sn(index, { t '[', i(1), t ']' })
  end
  if type == 'handles' then
    return sn(index, { t '{', i(1), t '}' })
  end
  return sn(index, { t '"', i(1, type), t '"' })
end

local function pars(used)
  local all_pars = {
    isa = true,
    coerce = true,
    does = true,
    required = true,
    weak_ref = true,
    lazy = true,
    trigger = true,
    handles = true,
    traits = true,
    builder = true,
    default = true,
    clearer = true,
    predicate = true,
    documentation = true,
  }

  local order = {
    'isa',
    'coerce',
    'does',
    'required',
    'weak_ref',
    'lazy',
    'trigger',
    'handles',
    'traits',
    'builder',
    'default',
    'clearer',
    'predicate',
    'documentation',
  }

  if used == nil then
    used = all_pars
  end

  return function()
    local data = {
      t '',
    }

    for _, key in ipairs(order) do
      if used[key] then
        local lp = {}
        for k, v in pairs(used) do
          lp[k] = v
        end
        lp[key] = false
        table.insert(data, sn(nil, { t(', ' .. key .. ' => '), par_type(1, key), d(2, pars(lp), {}) }))
      end
    end

    return sn(nil, c(1, data))
  end
end

local function snhas()
  return sn(nil, {
    t 'has ',
    i(1, 'attribute'),
    t " => ( is => '",
    c(2, { t 'ro', t 'rw' }),
    t "'",
    d(3, pars(), {}),
    t { ' );', '' },
    c(4, {
      t '',
      d(5, snhas, {}),
    }),
  })
end
local shas = s('has', { d(1, snhas, {}) })

local sub = s('sub', { d(1, snsub, {}) })

local function methods()
  return sn(nil, {
    d(1, snsub, {}),
    c(2, {
      t '',
      d(3, methods, {}),
    }),
  })
end

local spackage = s('class', {
  t 'package ',
  i(1),
  t { ';', '' },
  c(2, {
    t 'use Moose;',
    t 'use Mouse;',
    t 'use Moo;',
  }),
  t { '', '', '# Attributes:', '' },
  c(3, {
    t '',
    d(1, snhas, {}),
  }),
  t { '', '# Methods:', '' },
  c(4, {
    t '',
    d(1, methods, {}),
  }),
  i(5),
  t { '', '1;' },
})

ls.add_snippets('perl', { shas, sub, s('shift', { shift(1, '', true) }), spackage })
