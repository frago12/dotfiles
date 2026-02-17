-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- NeoTree: focus the explorer window (opens it if closed)
map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "NeoTree focus" })