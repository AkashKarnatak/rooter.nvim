if vim.fn.has("nvim-0.5") == 0 then
  return
end

if vim.g.loaded_rooter_nvim ~= nil then
  return
end

if vim.g.rooter_pattern == nil then
  vim.g.rooter_pattern = {'.git', 'Makefile', '_darcs', '.hg', '.bzr', '.svn', 'node_modules', 'CMakeLists.txt'} 
end

if vim.g.outermost_root == nil then
  vim.g.outermost_root = true
end

require('rooter')

vim.g.loaded_rooter_nvim = 1
