local M = {}

local colors_dracula = {
  bg = "#282A36", fg = "#F8F8F2", selection = "#44475A",
  comment = "#6272A4", red = "#FF5555", orange = "#FFB86C",
  yellow = "#F1FA8C", green = "#50FA7B", purple = "#BD93F9",
  cyan = "#8BE9FD", pink = "#FF79C6", white = "#F8F8F2",
}

local dracula_classic = {
  identifier = colors_dracula.fg, para = colors_dracula.pink,
  prop = colors_dracula.fg, var = colors_dracula.purple,
  func = colors_dracula.green, statement = colors_dracula.cyan,
  structure = colors_dracula.cyan, stringg = colors_dracula.yellow,
  comment = colors_dracula.comment, type = colors_dracula.orange,
  warning = colors_dracula.orange, err = colors_dracula.red,
}

function M.set_all_hl(cols)
  vim.api.nvim_set_hl(0, "Comment", { fg = cols.comment, italic = true })
  vim.api.nvim_set_hl(0, "Function", { fg = cols.func })
  vim.api.nvim_set_hl(0, "Type", { fg = cols.structure })
  vim.api.nvim_set_hl(0, "String", { fg = cols.stringg })
  vim.api.nvim_set_hl(0, "Identifier", { fg = cols.identifier })
  vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = cols.func })
  vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = cols.var })
  vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = cols.para })
  vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = cols.prop })
  vim.api.nvim_set_hl(0, "@lsp.type.struct", { fg = cols.type })
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#44475A", bg = "none" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#44475A", bg = "none" })
end

function M.setup()
  M.set_all_hl(dracula_classic)
  vim.api.nvim_create_user_command('DraculaVariant', function(opts)
    if opts.fargs[1] == "classic" then M.set_all_hl(dracula_classic) end
  end, { nargs = 1, complete = function() return { "classic" } end })
end

return M
