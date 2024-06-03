-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-- Better window navigation
vim.keymap.set({"n", "v"}, "H", "<C-w>h", opts)
vim.keymap.set({"n", "v"}, "J", "<C-w>j", opts)
vim.keymap.set({"n", "v"}, "K", "<C-w>k", opts)
vim.keymap.set({"n", "v"}, "L", "<C-w>l", opts)

-- jump previous and next
vim.keymap.set({"n", "v"}, "<C-o>", "<C-i>", opts)
vim.keymap.set({"n", "v"}, "<C-i>", "<C-o>", opts)

-- Resize with arrows, delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<C-E>", ":NvimTreeToggle<CR>", opts)

-- some useful mapping in n,v mode
vim.keymap.set({"n", "v"}, "<C-p>", "9k", opts)
vim.keymap.set({"n", "v"}, "<C-k>", "3k", opts)
vim.keymap.set({"n", "v"}, "<C-n>", "9j", opts)
vim.keymap.set({"n", "v"}, "<C-j>", "3j", opts)
vim.keymap.set({"n", "v"}, "<C-h>", "9h", opts)
vim.keymap.set({"n", "v"}, "<C-l>", "9l", opts)
vim.keymap.set({"n", "v"}, "<C-q>", "<Esc>ZZ", opts)

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- source current file
vim.keymap.set("n", "<C-r>", ":source %<CR>", opts)

-- move cursor in insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-e>", "<S-Right>")
vim.keymap.set("i", "<C-b>", "<S-Left>")

-- redo and undo in insert mode
vim.keymap.set("i", "<C-z>", "<esc>:undo<CR>i")
vim.keymap.set("i", "<C-y>", "<esc>:redo<CR>i")
vim.keymap.set("n", "<C-y>", ":redo<CR>")

-- delete without yank
vim.keymap.set({"n", "v"}, "d", "\"_d")
vim.keymap.set({"v"}, "p", "\"_dP")
vim.keymap.set({"n", "v"}, "y", "\"+y")

