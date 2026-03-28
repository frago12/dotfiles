-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Focus the Snacks explorer window (opens it if closed)
map("n", "<leader>o", function()
  local pickers = Snacks.picker.get({ source = "explorer" })
  if #pickers > 0 then
    pickers[1]:focus("list")
  else
    Snacks.explorer.open()
  end
end, { desc = "Explorer focus" })