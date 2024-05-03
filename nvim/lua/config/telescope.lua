local is_ok, builtin = pcall(require, "telescope.builtin")
if not is_ok then
	return
end

vim.keymap.set("n", "<A-p>", builtin.find_files, {})
vim.keymap.set("n", "<A-f>", builtin.live_grep, {}) -- find word
vim.keymap.set("n", "<A-o>", builtin.oldfiles, {}) -- i.e. previously open files


