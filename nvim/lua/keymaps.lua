-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "H", "<C-w>h", opts)
vim.keymap.set("n", "J", "<C-w>j", opts)
vim.keymap.set("n", "K", "<C-w>k", opts)
vim.keymap.set("n", "L", "<C-w>l", opts)
vim.keymap.set("n", "<C-[>", "<C-o>", opts)
vim.keymap.set("n", "<C-]>", "<C-i>", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- for nvim-tree
-- default leader key: \
vim.keymap.set("n", "<C-E>", ":NvimTreeToggle<CR>", opts)
vim.keymap.set({"n", "v", "i"}, "<C-p>", "9k", opts)
vim.keymap.set({"n", "v", "i"}, "<C-n>", "9j", opts)
vim.keymap.set({"n", "v", "i"}, "<C-h>", "9h", opts)
vim.keymap.set({"n", "v", "i"}, "<C-l>", "9l", opts)
vim.keymap.set({"n", "v", "i"}, "<C-q>", "<Esc>ZZ", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
