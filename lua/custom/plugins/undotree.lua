-- undotree: visual undo history tree (<leader>u)
return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  config = function() vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle) end,
}
