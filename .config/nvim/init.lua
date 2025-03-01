require("config.settings")
require("config.keymaps")
require("plugins")

-- Load splash screen on startup
local function setup_splash_screen()
  -- Only show splash when nvim is started without arguments
  if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
    -- Check if we're not in a git diff, commit message, etc.
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      require("splash").create_splash_screen()
    end
  end
end

-- Set up the splash screen to display on startup
vim.api.nvim_create_autocmd({"VimEnter"}, {
  callback = function()
    vim.defer_fn(setup_splash_screen, 0)
  end
})