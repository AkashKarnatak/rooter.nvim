## rooter.nvim
`rooter.nvim` changes current working directory to project root of the file opened in current buffer. It
identifies a directory as project root if it contains any of the file or folder specified
in `vim.g.rooter_pattern`. `rooter.nvim` triggers every time the buffer changes.

This plugin works only on linux.

## Customization
`rooter.nvim` provides you with two options.


| Options                | Description                                                                 | Type     |
|------------------------|-----------------------------------------------------------------------------|----------|
| `vim.g.rooter_pattern` | List of patterns(file or folder) which describes a directory as project root| list     |
| `vim.g.outermost_root` | Whether to change directory to outermost root directory or not              | boolean  |

Default configurations are 

```lua
vim.g.rooter_pattern = {'.git', 'Makefile', '_darcs', '.hg', '.bzr', '.svn', 'node_modules', 'CMakeLists.txt'} 
vim.g.outermost_root = true
```

## Bugs
Patterns like `*.sln` does not work as of now.
