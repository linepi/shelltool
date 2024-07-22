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

-- Resize with arrows
local resize_delta = 4
-- 向上调整窗口大小（减少行数）
function Resize_up()
    local pos = vim.fn.win_screenpos(0)
    if pos[1] == 1 then
         vim.cmd(string.format("resize -%d", resize_delta))
    else
         vim.cmd(string.format("resize +%d", resize_delta))
    end
end

-- 向下调整窗口大小（增加行数）
function Resize_down()
    local pos = vim.fn.win_screenpos(0)
    if pos[1] == 1 then
         vim.cmd(string.format("resize +%d", resize_delta))
    else
         vim.cmd(string.format("resize -%d", resize_delta))
    end
end

-- 向左调整窗口大小（减少列数）
function Resize_left()
    local pos = vim.fn.win_screenpos(0)
    if pos[2] == 1 then
         vim.cmd(string.format("vertical resize -%d", resize_delta))
    else
         vim.cmd(string.format("vertical resize +%d", resize_delta))
    end
    update_nvim_tree_width()
    DBG("123\n")
end

-- 向右调整窗口大小（增加列数）
function Resize_right()
    local pos = vim.fn.win_screenpos(0)
    if pos[2] == 1 then
         vim.cmd(string.format("vertical resize +%d", resize_delta))
    else
         vim.cmd(string.format("vertical resize -%d", resize_delta))
    end
    update_nvim_tree_width()
    DBG("123\n")
end

-- 设置键映射
vim.keymap.set("n", "<C-Up>", "<cmd>lua Resize_up()<CR>", opts)
vim.keymap.set("n", "<C-Down>", "<cmd>lua Resize_down()<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<cmd>lua Resize_left()<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<cmd>lua Resize_right()<CR>", opts)

vim.keymap.set("n", "<C-E>", "<cmd>NvimTreeToggle<CR>", opts)

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
vim.keymap.set("n", "<C-y>", "<cmd>redo<CR>")

-- delete without yank
vim.keymap.set({"n", "v"}, "d", "\"_d")
vim.keymap.set({"n", "v"}, "x", "\"_x")
vim.keymap.set({"v"}, "p", "\"_dP")
vim.keymap.set({"n", "v"}, "y", "\"+y")

