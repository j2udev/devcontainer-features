return {
  "folke/flash.nvim",
  -- removing the 'S' keybind as it conflicts with vim.surround motions
  keys = {
    { "S", mode = { "n", "o", "x" }, false }
  },
}