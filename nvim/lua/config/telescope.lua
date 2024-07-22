local is_ok, builtin = pcall(require, "telescope.builtin")
if not is_ok then
	return
end

local actions
is_ok, actions = pcall(require, "telescope.actions")
if not is_ok then
	return
end

require("telescope").load_extension("projects")
require("telescope").load_extension("live_grep_args")
require("telescope").setup({
    defaults = {
        layout_strategy = 'horizontal', -- horizontal',
        layout_config = {
          bottom_pane = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = "top"
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
            prompt_position = "top",
            width = 0.5
          },
          cursor = {
            height = 0.9,
            preview_cutoff = 40,
            width = 0.8
          },
          horizontal = {
            height = 0.95,
            preview_cutoff = 120,
            prompt_position = "top",
            width = 0.95
          },
          vertical = {
            height = 0.9,
            preview_cutoff = 40,
            prompt_position = "top",
            width = 0.8
          }
        },
        prompt_prefix = "",
        selection_caret = "> ",
        wrap_results = true,
        border = true,
        selection_strategy = "follow",
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        mappings = {
            i = {
                ["<A-j>"] = actions.preview_scrolling_down,
                ["<A-k>"] = actions.preview_scrolling_up,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-n>"] = function(bufnr)
                    for i=1,3 do
                        actions.move_selection_next(bufnr)
                    end
                end,
                ["<C-p>"] = function(bufnr)
                    for i=1,3 do
                        actions.move_selection_previous(bufnr)
                    end
                end,
                ["<Down>"] = require('telescope.actions').cycle_history_next,
                ["<Up>"] = require('telescope.actions').cycle_history_prev,
            },
            n = {
                ["<A-j>"] = actions.preview_scrolling_down,
                ["<A-k>"] = actions.preview_scrolling_up,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-n>"] = function(bufnr)
                    for i=1,3 do
                        actions.move_selection_next(bufnr)
                    end
                end,
                ["<C-p>"] = function(bufnr)
                    for i=1,3 do
                        actions.move_selection_previous(bufnr)
                    end
                end,
                ["<Down>"] = require('telescope.actions').cycle_history_next,
                ["<Up>"] = require('telescope.actions').cycle_history_prev,
            }
        }
    },
})

-- <C-/> in insert or ? in normal to open keymappings
-- vim.keymap.set({"n", "v", "i"}, "<A-s>", builtin.grep_string, {}) -- find string in workspace
-- vim.keymap.set({"n", "v", "i"}, "<A-o>", builtin.oldfiles, {})
--
vim.keymap.set({"n", "v", "i"}, "<A-l>", builtin.builtin, {}) -- list all telescope builtin 
vim.keymap.set({"n", "v", "i"}, "<A-p>", builtin.find_files, {})
vim.keymap.set({"n", "v", "i"}, "<A-f>",
    "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {}) -- find word global
vim.keymap.set({"n", "v", "i"}, "<A-d>", builtin.treesitter, {}) -- definitions in current file
vim.keymap.set({"n", "v", "i"}, "<A-n>", function()
    vim.cmd("Telescope notify")
end, {})
vim.keymap.set({"n", "v"}, "<C-b>", builtin.buffers, {}) -- buffer tab



