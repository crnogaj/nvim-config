# nvim-config
my nvim config based on NvChad

## Requirements
1. Install Nerd font - https://www.nerdfonts.com/font-downloads
2. Install neovim version >= 0.10
3. Install ripgrep - https://github.com/BurntSushi/ripgrep  
   `sudo apt install ripgrep`
4. Delete old neovim folders if any (same when uninstalling)
   ```
   rm -rf ~/.config/nvim
   rm -rf ~/.local/state/nvim
   rm -rf ~/.local/share/nvim
   ```
6. Install NvChad - https://github.com/NvChad/NvChad  
   `git clone https://github.com/NvChad/starter ~/.config/nvim`
7. Run `:MasonInstallAll` command after lazy.nvim finishes downloading plugins.

## Keymaps
`<leader>` = Space  
Letters at the beginning represent mode

n - normal  
i - insert  
v - visual  
t - terminal

### Select
`n <leader>a` - select all

Commands below end up in visual mode  
`n Shift+l` - select right  
`n Shift+h` - select left  
`n Shift+k` - select up  
`n Shift+j` - select down  

### Copy/Cut
`nv <leader>y` - copy to clipboard  
`nv <leader>d` - cut to clipboard  
`n Ctrl+c` - copy whole file

### Save
`n Ctrl+s` - save file

### Move
`nvi Ctrl+Alt+k` - move line up  
`nvi Ctrl+Alt+j` - move line down  
`n Alt+k` - scroll 10 lines up  
`n Alt+j` - scroll 10 lines down  
`n Ctrl+b` - scroll up by one screen  
`n Ctrl+f` - scroll down by one screen  
`i Ctrl+b` - go to beginning of line  
`i Ctrl+e` - go to end of line  
`i Ctrl+h` - left  
`i Ctrl+l` - right  
`i Ctrl+j` - down  
`i Ctrl+k` - up

### Replace
`n cgw` - replace word under cursor in whole file (prompt)  
`n Ctrl+d` - multiple cursors (https://github.com/mg979/vim-visual-multi)

### Search
`n <leader>ff` - find files in current root  
`n <leader>fw` - find text in files in current root  
`n <leader>fz` - find text in current file  
`Ctrl+c` or `Esc+Esc` - exit search

### Comments
`n gcc` - comment/uncomment line  
`v gc` - comment/uncomment selection

### Formatting
`n <leader>fm` - format whole file

### Explorer
`n Ctrl+n` - toggle explorer  
`n <leader>e` - focus explorer

### Terminal
`n <leader>h` - horizontal terminal  
`n <leader>v` - vertical terminal  
`nt Alt+h` - toggleable horizontal terminal  
`nt Alt+v` - toggleable vertical terminal  
`nt Alt+i` - toggleable floating terminal  
`t Ctrl+x` - exit terminal mode

### Git
`n <leader>gt` - git status  
`n <leader>cm` - git commits

### Focus
`n Ctrl+h` - switch window left  
`n Ctrl+l` - switch window right  
`n Ctrl+j` - switch window down  
`n Ctrl+k` - switch window up

### Buffer
`n <leader>b` - new buffer  
`n <leader>x` - close buffer  
`n Tab` - next buffer  
`n Shift+Tab` - previous buffer
