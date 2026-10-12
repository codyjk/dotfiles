-- Use the colorscheme and light/dark mode that the `theme` shell command
-- picked. Running instances switch when either changes.
local config = (vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")) .. "/theme/themes"
local state = (vim.env.XDG_STATE_HOME or vim.fn.expand("~/.local/state")) .. "/theme"
local fallback = "quiet"

-- No italics in any colorscheme, including ones a theme hard-codes.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
      if hl.italic then
        hl.italic = false
        if hl.cterm then hl.cterm.italic = false end
        vim.api.nvim_set_hl(0, name, hl)
      end
    end
  end,
})

-- name -> { dark = colorscheme or nil, light = colorscheme or nil }
local function themes()
  local t = {}
  local ok, lines = pcall(vim.fn.readfile, config)
  for _, line in ipairs(ok and lines or {}) do
    if not line:match("^%s*#") and line:match("%S") then
      local f = vim.tbl_map(vim.trim, vim.split(line, "|", { plain = true }))
      local function opt(s) return s ~= "-" and s or nil end
      t[f[1]] = { dark = opt(f[4]), light = opt(f[5]) }
    end
  end
  return t
end

local function read(file, default)
  local ok, lines = pcall(vim.fn.readfile, state .. "/" .. file)
  return ok and lines[1] or default
end

local function system_mode()
  vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return vim.v.shell_error == 0 and "dark" or "light"
end

-- What apply() last set. Compared instead of g:colors_name, which a
-- colorscheme may set to a different name than the one loaded.
local applied

local function apply()
  local name, mode = read("name", fallback), read("mode", "auto")
  if mode == "auto" then mode = system_mode() end
  local t = themes()[name] or { dark = fallback, light = fallback }
  -- A theme with one variant uses it in both modes.
  local bg = t[mode] and mode or (mode == "dark" and "light" or "dark")
  local scheme = t[bg]
  if applied == scheme .. ":" .. bg then return end
  applied = scheme .. ":" .. bg
  vim.o.background = bg
  if not pcall(vim.cmd.colorscheme, scheme) then
    vim.cmd.colorscheme(fallback)
  end
end

apply()

-- Watch the folder: `theme` replaces the files, so a watch on one would stop.
local watcher = vim.uv.new_fs_event()
if watcher and vim.fn.isdirectory(state) == 1 then
  watcher:start(state, {}, vim.schedule_wrap(function(_, file)
    if file == "name" or file == "mode" then apply() end
  end))
end

-- In auto mode, catch macOS appearance changes when Neovim gets focus.
vim.api.nvim_create_autocmd("FocusGained", { callback = apply })

-- :Theme [NAME] [MODE] switches every tool, not only this Neovim.
vim.api.nvim_create_user_command("Theme", function(opts)
  local out = vim.fn.system(vim.list_extend({ "theme" }, opts.fargs))
  if #opts.fargs == 0 or vim.v.shell_error ~= 0 then
    vim.notify(vim.trim(out), vim.v.shell_error ~= 0 and vim.log.levels.ERROR or nil)
  end
end, {
  nargs = "*",
  complete = function()
    return vim.list_extend(vim.tbl_keys(themes()), { "dark", "light", "auto", "next" })
  end,
})
