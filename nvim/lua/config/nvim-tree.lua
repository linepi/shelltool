local is_ok, nvim_tree = pcall(require, "nvim-tree")
if not is_ok then
	return
end

--
-- This function has been generated from your
--   view.mappings.list
--   view.mappings.custom_only
--   remove_keymaps
--
-- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
--
-- Although care was taken to ensure correctness and completeness, your review is required.
--
-- Please check for the following issues in auto generated content:
--   "Mappings removed" is as you expect
--   "Mappings migrated" are correct
--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- vim.keymap.set("n", "<Space>", api.node.open.preview, opts("Open Preview"))
	-- vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	-- vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	-- vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	-- vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	-- vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	-- vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	-- vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
	-- vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
	-- vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
	-- vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
	-- vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	-- vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	-- vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	-- vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
	-- vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	-- vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
	-- vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	-- vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
    --
	vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
	vim.keymap.set("n", "n", api.fs.create, opts("Create")) -- name for file, name/ for folder
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))

	vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
	vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
	vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "e", api.tree.expand_all, opts("Expand"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("CollapseAll"))
	vim.keymap.set("n", "w", api.tree.collapse, opts("Collapse"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "|", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "-", api.node.open.horizontal, opts("Open: Vertical Split"))
	vim.keymap.set("n", ";", api.node.show_info_popup, opts("Info"))
  -- global command
  vim.keymap.set({"n", "v"}, "<A-w>", api.tree.find_file, {});
end

local function leftmost_win_path_and_width()
    local original_win = vim.api.nvim_get_current_win()
    local leftmost_win = original_win
    local min_col = 999

    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        local col = vim.api.nvim_win_get_position(win_id)[2]
        if col < min_col then
            min_col = col
            leftmost_win = win_id
        end
    end

    vim.api.nvim_set_current_win(leftmost_win)
    local file_path = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(leftmost_win))
    vim.api.nvim_set_current_win(original_win)
    return file_path, vim.api.nvim_win_get_width(leftmost_win)
end

MY_TREE_WIDTH = 30
function update_nvim_tree_width()
    local path, width = leftmost_win_path_and_width()
    if string.find(path, "NvimTree") ~= nil then
        MY_TREE_WIDTH = width
    end
end

-- Hint: :help nvim-tree-default-mappings
-- setup with some options
nvim_tree.setup({
	sort_by = "case_sensitive",
	on_attach = on_attach,
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
        git_ignored = false
	},
	diagnostics = {
		enable = true,
	},
  view = {
      -- adaptive_size = false,
      width = function()
          return MY_TREE_WIDTH
      end
  },
  git = {
    enable = true,
    timeout = 400 -- (in ms)
  },
  actions = {
    expand_all = {
      max_folder_discovery = 100000,
      exclude = {".git"},
    },
  }
})
