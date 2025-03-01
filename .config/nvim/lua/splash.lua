-- ~/.config/nvim/lua/splash.lua
local api = vim.api
local fn = vim.fn

local function create_splash_screen()
  -- Create a new buffer for the splash screen
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  
  -- Set up the splash screen content
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  
  -- Calculate center
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  
  -- Create the window with the buffer
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
  }
  
  local win = api.nvim_open_win(buf, true, opts)
  api.nvim_win_set_option(win, 'winhl', 'Normal:Normal')
  
  -- Splash screen content
  local logo = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "                                                     ",
  }
  
  local options = {
    "Quick Actions:",
    "",
    "  [e] New file",
    "  [f] Find file          <C-f>",
    "  [p] Find in files      <C-p>",
    "  [n] File explorer      <C-n>",
    "  [r] Recent files",
    "  [c] Configuration",
    "  [q] Quit               :q",
    "",
  }
  
  -- Combine logo and options
  local lines = {}
  for i, line in ipairs(logo) do
    table.insert(lines, line)
  end
  
  table.insert(lines, "")
  table.insert(lines, "")
  
  for i, line in ipairs(options) do
    table.insert(lines, line)
  end
  
  -- Center the content
  local formatted_lines = {}
  for i, line in ipairs(lines) do
    local padding = math.floor((win_width - #line) / 2)
    local formatted_line = string.rep(" ", padding) .. line
    table.insert(formatted_lines, formatted_line)
  end
  
  -- Set the buffer content
  api.nvim_buf_set_lines(buf, 0, -1, false, formatted_lines)
  
  -- Make the buffer read-only
  api.nvim_buf_set_option(buf, 'modifiable', false)
  api.nvim_buf_set_option(buf, 'filetype', 'splash')
  
  -- Set up keymaps
  local function set_keymap(key, action)
    api.nvim_buf_set_keymap(buf, 'n', key, action, {silent = true, noremap = true})
  end
  
  -- Define key mappings for the splash screen
  set_keymap('e', ':enew<CR>')
  set_keymap('f', ':lua require("telescope.builtin").find_files()<CR>')
  set_keymap('p', ':lua require("telescope.builtin").live_grep()<CR>')
  set_keymap('n', ':NvimTreeToggle<CR>')
  set_keymap('r', ':lua require("telescope.builtin").oldfiles()<CR>')
  set_keymap('c', ':e $MYVIMRC<CR>')
  set_keymap('q', ':q<CR>')
  
  -- Also define keymaps for the actual shortcuts
  api.nvim_set_keymap('n', '<C-f>', ':lua require("telescope.builtin").find_files()<CR>', {silent = true, noremap = true})
  api.nvim_set_keymap('n', '<C-p>', ':lua require("telescope.builtin").live_grep()<CR>', {silent = true, noremap = true})
  api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true, noremap = true})
  
  -- Auto commands to close the splash screen when a key is pressed
  api.nvim_create_autocmd({"BufLeave"}, {
    buffer = buf,
    callback = function()
      if api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
      end
    end
  })
  
  return buf
end

return {
  create_splash_screen = create_splash_screen
}