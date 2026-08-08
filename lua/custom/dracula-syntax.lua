-- syntax highlight groups for dracula (adapted from jonkero9's syntax_hl.lua)

local M = {}

-- dracula color palette
local colors = {
  bg        = '#282a36',
  fg        = '#f8f8f2',
  purple    = '#bd93f9',
  pink      = '#ff79c6',
  cyan      = '#8be9fd',
  green     = '#50fa7b',
  orange    = '#ffb86c',
  red       = '#ff5555',
  yellow    = '#f1fa8c',
  comment   = '#6272a4',
  selection = '#44475a',
}

-- dracula syntax roles
local dracula_syntax = {
  identifier  = colors.fg,
  para        = colors.orange,    -- parameters: orange
  prop        = colors.cyan,      -- properties: cyan
  var         = colors.fg,        -- variables: foreground
  func        = colors.green,     -- functions: green
  statement   = colors.pink,      -- keywords: pink
  structure   = colors.cyan,      -- types/structs: cyan
  stringg     = colors.yellow,    -- strings: yellow
  comment     = colors.comment,   -- comments: muted blue
  type        = colors.cyan,      -- types: cyan
  warning     = colors.orange,    -- warnings: orange
  err         = colors.red,       -- errors: red
}

function M.apply()
  -- base syntax
  vim.api.nvim_set_hl(0, 'Comment',    { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, 'Identifier', { fg = dracula_syntax.identifier })
  vim.api.nvim_set_hl(0, 'Function',   { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, 'Statement',  { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, 'Keyword',    { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, 'Structure',  { fg = dracula_syntax.structure })
  vim.api.nvim_set_hl(0, 'Type',       { fg = dracula_syntax.structure })
  vim.api.nvim_set_hl(0, 'Special',    { fg = dracula_syntax.structure })
  vim.api.nvim_set_hl(0, 'Delimiter',  { fg = dracula_syntax.structure })
  vim.api.nvim_set_hl(0, 'Operator',   { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, 'Macro',      { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, 'String',     { fg = dracula_syntax.stringg })
  vim.api.nvim_set_hl(0, 'Boolean',    { fg = dracula_syntax.stringg })
  vim.api.nvim_set_hl(0, 'Number',     { fg = dracula_syntax.stringg })
  vim.api.nvim_set_hl(0, 'Character',  { fg = dracula_syntax.stringg })
  vim.api.nvim_set_hl(0, 'MatchParen', { bg = colors.selection, bold = true })

  -- diagnostics
  vim.api.nvim_set_hl(0, 'DiagnosticWarn',  { fg = dracula_syntax.warning })
  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = dracula_syntax.err })
  vim.api.nvim_set_hl(0, 'DiagnosticInfo',  { fg = colors.cyan })
  vim.api.nvim_set_hl(0, 'DiagnosticHint',  { fg = colors.comment })

  -- lsp semantic tokens
  vim.api.nvim_set_hl(0, '@lsp.type.struct',         { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, '@lsp.type.enum',           { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, '@lsp.type.class',          { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, '@lsp.type.typeParameter',  { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, '@lsp.type.parameter',      { fg = dracula_syntax.para })
  vim.api.nvim_set_hl(0, '@lsp.type.property',       { fg = dracula_syntax.prop })
  vim.api.nvim_set_hl(0, '@lsp.type.variable',       { fg = dracula_syntax.var })
  vim.api.nvim_set_hl(0, '@lsp.type.function',       { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, '@lsp.type.method',         { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, '@lsp.type.keyword',        { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, '@lsp.type.namespace',      { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@lsp.type.macro',          { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, '@lsp.type.decorator',      { fg = colors.pink })

  -- treesitter groups
  vim.api.nvim_set_hl(0, '@variable',                { fg = dracula_syntax.var })
  vim.api.nvim_set_hl(0, '@variable.parameter',      { fg = dracula_syntax.para })
  vim.api.nvim_set_hl(0, '@variable.builtin',        { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@property',                { fg = dracula_syntax.prop })
  vim.api.nvim_set_hl(0, '@function',                { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, '@function.call',           { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, '@function.builtin',        { fg = colors.cyan })
  vim.api.nvim_set_hl(0, '@method',                  { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, '@keyword',                 { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, '@keyword.return',          { fg = colors.pink, bold = true })
  vim.api.nvim_set_hl(0, '@type',                    { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, '@type.builtin',            { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@string',                  { fg = dracula_syntax.stringg })
  vim.api.nvim_set_hl(0, '@number',                  { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@boolean',                 { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@comment',                 { fg = colors.comment, italic = true })
  vim.api.nvim_set_hl(0, '@operator',                { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, '@punctuation.bracket',     { fg = colors.fg })
  vim.api.nvim_set_hl(0, '@punctuation.delimiter',   { fg = colors.fg })
  vim.api.nvim_set_hl(0, '@namespace',               { fg = colors.purple })
  vim.api.nvim_set_hl(0, '@tag',                     { fg = colors.pink })
  vim.api.nvim_set_hl(0, '@tag.attribute',           { fg = dracula_syntax.para })

  -- cmp popup dracula colors
  vim.api.nvim_set_hl(0, 'CmpNormal',       { bg = '#1e1f29' })
  vim.api.nvim_set_hl(0, 'CmpBorder',       { fg = colors.purple, bg = '#1e1f29' })
  vim.api.nvim_set_hl(0, 'CmpSel',          { bg = colors.selection })
  vim.api.nvim_set_hl(0, 'CmpDocNormal',    { bg = '#1e1f29' })
  vim.api.nvim_set_hl(0, 'CmpDocBorder',    { fg = colors.comment, bg = '#1e1f29' })

  -- cmp kind colors
  vim.api.nvim_set_hl(0, 'CmpItemKindFunction',  { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, 'CmpItemKindMethod',    { fg = dracula_syntax.func })
  vim.api.nvim_set_hl(0, 'CmpItemKindVariable',  { fg = dracula_syntax.var })
  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword',   { fg = dracula_syntax.statement })
  vim.api.nvim_set_hl(0, 'CmpItemKindText',      { fg = colors.fg })
  vim.api.nvim_set_hl(0, 'CmpItemKindSnippet',   { fg = colors.green })
  vim.api.nvim_set_hl(0, 'CmpItemKindClass',     { fg = dracula_syntax.type })
  vim.api.nvim_set_hl(0, 'CmpItemKindModule',    { fg = colors.purple })
  vim.api.nvim_set_hl(0, 'CmpItemKindField',     { fg = dracula_syntax.prop })
  vim.api.nvim_set_hl(0, 'CmpItemKindProperty',  { fg = dracula_syntax.prop })
end

return M
