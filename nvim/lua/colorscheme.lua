-- define your colorscheme here
-- local colorscheme = 'monokai.nvim'
local colorscheme = 'vscode'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
