-- Write Ghostty theme files from Neovim colorschemes, for themes Ghostty
-- does not ship. Uses the colorscheme's own terminal colors when it sets
-- them, and Zenwritten's muted ANSI colors when it does not.
-- GEN_SPECS: lines of "name|colorscheme|variant[|variant]" (dark, light).
-- GEN_OUT: folder to write NAME-VARIANT files to.
-- Example:
--   GEN_OUT=~/.local/share/chezmoi/dot_config/ghostty/themes \
--   GEN_SPECS='komau|komau|dark|light' \
--   nvim --headless "+luafile ~/.config/theme/ghostty-from-nvim.lua" +qa!
local outdir = vim.env.GEN_OUT
local zen = {}
for _, v in ipairs({ "Dark", "Light" }) do
  local t = {}
  for _, l in ipairs(vim.fn.readfile("/Applications/Ghostty.app/Contents/Resources/ghostty/themes/Zenwritten " .. v)) do
    local i, hex = l:match("^palette = (%d+)=#(%x+)")
    if i then t[tonumber(i)] = "#" .. hex end
  end
  zen[v:lower()] = t
end
local function hex(n) return n and string.format("#%06x", n) or nil end
local report = {}
for line in vim.env.GEN_SPECS:gmatch("[^\n]+") do
  local f = vim.split(line, "|", { plain = true })
  local name, scheme = f[1], f[2]
  for i = 3, #f do
    local bg = f[i]
    vim.cmd("hi clear")
    for k = 0, 15 do vim.g["terminal_color_" .. k] = nil end
    vim.o.background = bg
    vim.cmd.colorscheme(scheme)
    local n = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
    local nbg = hex(n.bg) or (bg == "dark" and "#000000" or "#ffffff")
    local nfg = hex(n.fg) or (bg == "dark" and "#d0d0d0" or "#111111")
    local own = vim.g.terminal_color_0 ~= nil
    local lines = { ("# %s (%s), generated from the Neovim colorscheme %s."):format(name, bg, scheme),
      own and "# ANSI colors from the colorscheme." or ("# ANSI colors from Zenwritten " .. (bg == "dark" and "Dark" or "Light") .. "; the colorscheme sets none.") }
    for k = 0, 15 do
      lines[#lines + 1] = ("palette = %d=%s"):format(k, own and vim.g["terminal_color_" .. k] or zen[bg][k])
    end
    local sel = hex(vis.bg) or (vis.reverse and nfg) or (bg == "dark" and "#404040" or "#d0d0d0")
    vim.list_extend(lines, { "background = " .. nbg, "foreground = " .. nfg, "cursor-color = " .. nfg,
      "cursor-text = " .. nbg, "selection-background = " .. sel, "selection-foreground = " .. (hex(vis.fg) or nfg) })
    vim.fn.writefile(lines, outdir .. "/" .. name .. "-" .. bg)
    table.insert(report, ("%-24s %-5s bg=%s fg=%s vo.bg=%s own=%s"):format(name, bg, nbg, nfg, vim.o.background, tostring(own)))
  end
end
print(table.concat(report, "\n"))
