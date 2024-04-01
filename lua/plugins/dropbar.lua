return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim'
  },

  config = function()
    vim.keymap.set("n", "<leader>db", ":lua require('dropbar.api').pick()<CR>")
  end,
}
