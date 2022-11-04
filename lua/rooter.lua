-- https://stackoverflow.com/a/4991602
function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

-- https://stackoverflow.com/a/20460403
function findLast(haystack, needle)
    local i = haystack:match(".*" .. needle .. "()")
    if i == nil then
        return nil
    else
        return i - 1
    end
end

function parent_dir(dir)
    return dir:sub(1, findLast(dir, package.config:sub(1, 1)) - 1)
end

term_pattern = parent_dir(os.getenv("HOME"))

function _G.__root_dir(prefix, cwd)
    if not (prefix:find(term_pattern) == 1) then
        return cwd
    end
    possible_root_dir = prefix
    found = false
    while prefix ~= term_pattern do
        for _, dir in ipairs(vim.g.rooter_pattern) do
            if file_exists(prefix .. "/" .. dir) then
                found = true
                possible_root_dir = prefix
                if not vim.g.outermost_root then
                    return possible_root_dir
                end
                break
            end
        end
        prefix = parent_dir(prefix)
    end
    if found then
        return possible_root_dir
    else
        return cwd
    end
end

if vim.fn.exists("g:loaded_tree") and vim.g.loaded_tree then
    vim.cmd('autocmd VimEnter * exe "cd " .. v:lua.__root_dir(expand(\'%:p:h\'), getcwd())')
    vim.cmd(
        [[autocmd VimEnter * autocmd BufEnter * exe "lua vim.api.nvim_set_current_dir(_G.__root_dir(vim.fn.expand('%:p:h'), vim.fn.getcwd()))" | exe "lua require'nvim-tree.lib'.change_dir(_G.__root_dir(vim.fn.expand('%:p:h'), vim.fn.getcwd()))"]]
    )
else
    vim.cmd('autocmd BufEnter * exe "cd " .. v:lua.__root_dir(expand(\'%:p:h\'), getcwd())')
end

