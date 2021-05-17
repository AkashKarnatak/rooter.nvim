if vim.g.rooter_pattern == nil then
  vim.g.rooter_pattern = {'.git', 'Makefile', '_darcs', '.hg', '.bzr', '.svn', 'node_modules', 'CMakeLists.txt'}
end
if vim.g.outermost_root == nil then
  vim.g.outermost_root = true
end

-- https://stackoverflow.com/a/4991602
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- https://stackoverflow.com/a/20460403
function findLast(haystack, needle)
    local i=haystack:match(".*"..needle.."()")
    if i==nil then return nil else return i-1 end
end

function _G.__root_dir(prefix, cwd)
  if prefix:sub(1,5) ~= '/home' then
    return cwd
  end
  possible_root_dir = prefix
  found = false
	while prefix ~= '/home' do
		for _, dir in ipairs(vim.g.rooter_pattern) do
			if file_exists(prefix .. '/' .. dir) then
        found = true
				possible_root_dir = prefix
        if not vim.g.outermost_root then
          return possible_root_dir
        end
        break
			end
		end
    prefix = prefix:sub(1, findLast(prefix, '/')-1)
	end
  if found then
    return possible_root_dir
  else
    return cwd
  end
end

vim.cmd('autocmd BufEnter * exe "cd " .. v:lua.__root_dir(expand(\'%:p:h\'), getcwd())')
